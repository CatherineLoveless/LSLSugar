LSLSugar V0.01
https://github.com/CatherineLoveless/LSLSugar

(FYI very early on syntax very much subject to change until i know what i actually wnana do with this...)


transpiled syntax sugar on top pf LSL

Code is written in <filename>.p.lsl files that are recognized as the precursor... and transpiled into  <filename>.t.lsl meaning they are transpiled... this also marks them out... ordinary  <filename>.lsl files are ignored by the transpiler.

the transpiler is a command line tool and is run by specifying the folder where its ment to start parsing and rooting out  .p.lsl files.



Currently it supports 


Table syntax
---------------------------------------------
DeclareTable

    list points = string[];
    list elements = integer[];
    list values = integer[];
    list isElement = integer[];

WithValues

    "Inpurities"    |2|0|FALSE
    "Coal"          |4|1|FALSE
    "Lead(Pb)"      |4|1|TRUE
    "Manganese(Mn)" |4|1|TRUE
    
EndTable
---------------------------------------------

which populates the list at the start with the pipe separated values (trimd so you can pad the list out as much as you want for readability)



Typed List syntax and infered type indexing

---------------------------------------------
list test123 = string["k545","65h46"];
---------------------------------------------

You specify list type when making the list

---------------------------------------------
z= test123.Get(0);
---------------------------------------------

and you can then use a more intuitive syntax  this then output the right listretrival method on its own.


javascript style Template string
---------------------------------------------
   llOwnerSay(´Ore contains: ${elements.Get(element1)},  ${elements.Get(element2)}, ${elements.Get(element1)}´);
---------------------------------------------
i.e ${} denotes bits of arbitrary string generating code that you can then automatically stitch together in the ´´ special tempalte string.


Easy Count short hand callable on list variable
---------------------------------------------
llOwnerSay((string)elements.Count());
---------------------------------------------

so no having to remeber llGetListLength(elements) which is clunky and unintuitive....
plan on putting a bunch of these helper on the list so it can be easily accessible...

The transpiler will then write out the normal LSL that can then be put back in SL and run...

To install download the zip of the dotnet9  commandline tool
https://dotnet.microsoft.com/en-us/download

download the filesof git either by cloning or downloading the source code extract it somewhere good then start a terminal in that folder and run donnet build

the command line tool should be on the bin/debug/net9.0 folder 

just run it with the folder where you .p.lsl files are and it will traverse all subdirectories and write out your .t.lsl files
