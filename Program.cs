using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Diagnostics.SymbolStore;
using System.Runtime.InteropServices.Marshalling;
using System.Text.RegularExpressions;





public class LSLTFactory
{
 
    public string TypeToMethod(string value)
    {
        switch (value)
        {
            case "integer": return "llList2Integer"; 
            case "float": return "llList2Float";
            case "key": return "llList2Key";
            case "string": return "llList2String";
            case "vector": return "llList2Vector"; 
            case "rotation": return "llList2Rot";
            case "list": return "llList2List";
            default: throw new InvalidCastException("Cannot match value to recognized LSL type");
        }
    }
    public string ZeroVariableToType(string value)
    {
        switch (value)
        {
            case "FALSE": return "integer";
            case "TRUE": return "integer";
            case "0": return "integer";
            case "0.0": return "float";
            case "NULL_KEY": return "key";
            case @"""""": return "string";
            case "<0,0,0>": return "vector";
            case "ZERO_VECTOR": return "vector";
            case "ZERO_ROTATION": return "rotation";
            case "[]": return "list";
            default: throw new InvalidCastException("Cannot match value to recognized LSL type");
        }
    }
    public string TypeVariableToMethod(string value)
    {
        switch (value)
        {
            case "integer": return "llList2Integer";        
            case "float": return "llList2Float";
            case "key": return "llList2Key";
            case "string": return "string";
            case "vector": return "llList2Vector";      
            case "rotation": return "llList2Rot";
            case "list": return "llList2List";
            default: throw new InvalidCastException("Cannot match value to recognized LSL type");
        }
    }

    public string ZeroVariableToMethod(string value)
    {
        switch (value)
        {
            case "FALSE": return "llList2Integer";
            case "TRUE": return "llList2Integer";
            case "0": return "llList2Integer";
            case "0.0": return "llList2Float";
            case "NULL_KEY": return "llList2Key";
            case @"""""": return "llList2String";
            case "<0,0,0>": return "llList2Vector";
            case "ZERO_VECTOR": return "llList2Vector";
            case "ZERO_ROTATION": return "llList2Rot";
            case "[]": return "llList2List";
            default: throw new InvalidCastException("Cannot match value to recognized LSL type");
        }
    }
    ///[]|NULL_KEY|ZERO_VECTOR|TRUE|ZERO_ROTATION|0|""


    protected void validateType(string value)
    {
        switch (value)
        {
            case "integer":
            case "float":
            case "string":
            case "key":
            case "vector":
            case "rotation":
            case "list": break;
            default: throw new InvalidCastException("list may not be typed as " + value);
        }
    }
    public string payload { get; set; }

    public LSLTFactory(string text)
    {
        this.payload = text;
    }
    public Dictionary<string, string> Lists { get; set; } = new Dictionary<string, string>();

    public LSLTFactory DoTemplateStrings()
    {
        var rex = new Regex("´(.*?)´");
        this.payload=  rex.Replace(this.payload, m =>
        {
            var inner = m.Groups[1].ToString();
            var innerRex = new Regex(@"\$\{(.*?)\}");
            return "\"" + innerRex.Replace(inner, m =>
            {
                return $@"""+{m.Groups[1].ToString()}+""";
            }) + "\"";          
        });
        return this;
    }

    public LSLTFactory DoList()
    {
        Regex rex = new Regex(@"list\s*(.*)\s*=\s*(integer|float|string|key|vector|rotation)\[([^\]]*)];");
        this.payload = rex.Replace(this.payload, m =>
        {
            var listName = m.Groups[1].ToString();
            var listType = m.Groups[2].ToString();
            var listContent = m.Groups[3].ToString();

            SetLists(listName, listType);

            return  $@"list {listName} = [{listContent}] ";         
        });
        return this;
    }

    public LSLTFactory DoListIndexer()
    {

        var rex = new Regex(@"([a-z|A-Z|0-9]+)\.Get\(([^)]*)\)");

        this.payload = rex.Replace(this.payload, (Match m) =>
        {

            var listName = m.Groups[1].ToString();
            var index = m.Groups[2].ToString();
            var listMethod = TypeToMethod(Lists[listName]);

            return $@"{listMethod}({listName}, {index})";
        });

        return this;
    }

    public LSLTFactory DoListCount()
    {
        var rex = new Regex(@"([a-z|A-Z|0-9]+)\.Count\(\)");
        this.payload = rex.Replace(this.payload, (Match m) =>
        {
            var listName = m.Groups[1].ToString();
            var index = m.Groups[2].ToString();       
            return $@"llGetListLength({listName})";
        });

        return this;
    }
    private void SetLists(string name, string type)
    {
        name = name.Trim();
        type = type.Trim();
        if (this.Lists.ContainsKey(name))
        {
            this.Lists[name] = type;
        }
        this.Lists.Add(name, type);

    }

    public LSLTFactory DoTable()
    {
        Regex rex = new Regex(@"[D|d]eclare[T|T]able\s((.|\n|\s|\w)+?)[W|w]ith(V|v)alues\s((.|\n|\s|\w)+?)[E|e]nd[T|t]able");

        this.payload = rex.Replace(this.payload, (Match m) =>
    {
        var declaration = m.Groups[1].ToString();

        Regex rex2 = new Regex(@"list\s*(.*)\s*=\s*(integer|float|string|key|vector|rotation)\[\];");

        var csv = m.Groups[4].ToString();

        var options = new Csv.CsvOptions()
        {
            HeaderMode = Csv.HeaderMode.HeaderAbsent,
            Separator = '|', // Autodetects based on first row                
            NewLine = Environment.NewLine // The new line string to use when multiline field values are read (Requires "AllowNewLineInEnclosedFieldValues" to be set to "true" for this to have any effect.)
        };

        var data = Csv.CsvReader.ReadFromText(csv, options).ToList();

        var names = new Dictionary<string, List<string>>();
        var ColIndex = 0;
        foreach (Match m2 in rex2.Matches(declaration))
        {
            var listName = m2.Groups[1].ToString();

            if (string.IsNullOrEmpty(listName))
            {
                throw new InvalidEnumArgumentException("List name cannot be empty");
            }

            var listType = m2.Groups[2].ToString();

            validateType(listType);

            List<string> list = new List<string>();

            for (int rowIndex = 0; rowIndex < data.Count; rowIndex++)
            {
                var cell =   data[rowIndex][ColIndex].Trim();
                list.Add(cell);
            }

            SetLists(listName, listType);
 
            names.Add(listName, list);
            ColIndex++;
        }

        var result = "";
        foreach (var kvp in names)
        {

            var listString = $@"list {kvp.Key} = [{string.Join(',', kvp.Value)}];
";
            result += listString;


        }
        return result;
    });

        return this;
    }
}




public class Program
{
    public static void Main(params string[] args)
    { 
        string appPath = AppDomain.CurrentDomain.BaseDirectory;

        if (args.Count() > 0)
        {
            appPath = args[0];
        }

        Program.Instance.executeOnDirs(appPath, file => Program.Instance.process(file));

    }
    private Program() { }
    public static Program Instance = new Program();



    private void executeOnDirs(string path, Action<string> action)
    {
        var dir = new DirectoryInfo(path);


        foreach (var file in dir.GetFiles("*" + rawExtension))
        {
            action(file.FullName);
        }

        foreach (var dir2 in dir.GetDirectories())
        {
            executeOnDirs(dir2.FullName, action);
        }
    }




    private string rawExtension = ".p.lsl"; //pre transpiled
    private string transpiledExtension = ".t.lsl"; //transpiled

    //just lsl should be ignored

    private void process(string file)
    {
        if (!file.EndsWith(transpiledExtension) && file.EndsWith(rawExtension))
        {
            var transpiledFileName = file.Substring(0, file.Length - rawExtension.Length) + transpiledExtension;
            var transpilerChain = new LSLTFactory(File.ReadAllText(file));
            var newText = transpilerChain.DoTable().DoTemplateStrings().DoList().DoListIndexer().DoListCount().payload;
            File.WriteAllText(transpiledFileName, newText);
        }
    }
}
