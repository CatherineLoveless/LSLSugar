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
    "Zinc(Zn)"      |4|1|TRUE
    "Titanium(Ti)"  |5|2|TRUE
    "Copper(Cu)"    |6|2|TRUE
    "Bismuth(Bi)"   |6|2|TRUE
    "Chromium(Cr)"  |6|2|TRUE
    "Ytterbium(Yb)" |6|2|TRUE
    "Chert"         |6|2|FALSE
    "Cadmium(Cd)"   |8|3|TRUE
    "Flint"         |8|3|FALSE
    "Aventurine"    |8|3|FALSE
    "Aluminum(Al)"  |9|3|TRUE
    "Nickel(Ni)"    |9|3|TRUE
    "Thulium(Tm)"   |9|3|TRUE
    "Tin(Sn)"       |9|3|TRUE
    "Jasper"        |9|3|FALSE
    "Chalcedony"    |9|3|FALSE
    "Vanadium(V)"   |10|3|TRUE
    "Onyx"          |10|3|FALSE
    "Carnelian"     |10|3|FALSE
    "Erbium(Er)"    |11|3|TRUE
    "Mercury(Hg)"   |11|3|TRUE
    "Molybdenum(Mo)"|11|3|TRUE
    "Praseodymium(Pr)"|11|3|TRUE
    "Agate"         |11|3|FALSE
    "Tungsten(W)"   |12|3|TRUE
    "Cerium(Ce)"    |13|4|TRUE
    "Holmium(Ho)"   |13|4|TRUE
    "Quartzite"     |13|4|FALSE
    "Dysprosium(Dy)"|15|4|TRUE
    "Lanthanum(La)" |15|4|TRUE
    "Thallium(Tl)"  |15|4|TRUE
    "Zirconium(Zr)" |15|4|TRUE
    "Amethyst"      |15|4|FALSE
    "Neodymium(Nd)" |16|4|TRUE
    "Terbium(Tb)"   |16|4|TRUE
    "Gadolinium(Gd)"|18|4|TRUE
    "Europium(Eu)"  |19|5|TRUE
    "Samarium(Sm)"  |22|5|TRUE
    "Samarium(Sm)"  |22|5|TRUE
    "Tantalum(Ta)"  |28|6|TRUE
    "Tungsten(W)"   |28|6|TRUE
    "Gallium(Ga)"   |43|7|TRUE
    "Indium(In)"    |43|7|TRUE
    "Hafnium(Hf)"   |91|11|TRUE
    "Germanium(Ge)" |118|13|TRUE
    "LapisLazuli"   |118|13|FALSE
    "Scandium(Sc)"  |221|18|TRUE
    "Lutetium(Lu)"  |256|20|TRUE
    "Peridot"       |332|23|FALSE
    "Tourmaline"    |400|25|FALSE
    "Garnet"        |520|29|FALSE
    "Rhenium(Re)"   |520|29|TRUE
    "Topaz"         |520|29|FALSE
    "Osmium(Os)"    |585|31|TRUE
    "Iridium(Ir)"   |724|35|TRUE
    "Citrine"       |815|37|FALSE
    "Jade"          |1060|43|FALSE
    "Gold(Au)"      |1305|48|TRUE
    "Amethyst"      |1477|51|FALSE
    "Aquamarine"    |2317|65|FALSE
    "Sapphire"      |5701|105|FALSE
    "Emerald"       |9185|136|FALSE
    "Ruby"          |10783|148|FALSE
    "Jewelers'Opal" |14412|173|FALSE
    "Diamond"       |28141|249|FALSE
    "Unobtanium(Uo)"|35483|282|TRUE
EndTable

list test123 = string["k545","65h46"];



float tollerance = 0.05;
list temp = [];

integer element1 = -1;
integer element2 = -1;
integer element3 = -1;

integer i = -1;
integer x = -1;

float y = -1;
float z = -1;
float q = -1;



roll(){
    temp =[];
    element1 = 7;
    element2 = 0;
    element3 = 0;
    
    for (i=1; i< 44; i++){
        x =llList2Integer(values,i);
        z = llRound(llFrand(x));
        if(x==z){
        temp += i; 
        }    
    }
    
    if (llGetListLength(temp) == 1 && llList2Integer(values,0) != 0 ){
        element1 = llList2Integer(values,0);
        element2 = 0//$Math.Round($Math.FRand(4));   
        element3 = 0;
        return; 
    }
    
    if (llGetListLength(temp) == 2){
        element1 = llList2Integer(values,0);
        element2 = llList2Integer(values,1);
        element3 = 0;
        return;
    }
    
    if (llGetListLength(temp) == 3){
        element1 = llList2Integer(values,0);
        element2 = llList2Integer(values,1);
        element3 = llList2Integer(values,2);
        return;
    } 
    

        element1 = 6;
        element2 =  llRound(llFrand(4)); // you get something semi shitty..;
        element3 = 0; 
}


default
{
    
    state_entry()
    {

    }

    touch_start(integer total_number)
    {    
        roll();
    

         //llOwnerSay( "Ore contains: " + llList2String( Elements, element1) + ", "+ llList2String( Elements, element2) + ", "+ llList2String( Elements, element3));
        

         //rather then figure out what list accessor function to use the idea here is to just write the column List name and use a indexer... 
         //but a default value has to be used
         //[]|NULL_KEY|ZERO_VECTOR|TRUE|ZERO_ROTATION|0|""
         // either this will only work paired with the table since i have the metadata there or... i change the float zero value to 0.0 tha 
         //way i could detect if its to be cast as a float and make it more universal....


        llOwnerSay((string)elements.Count());

        llOwnerSay(´Ore contains: ${elements.Get(element1)},  ${elements.Get(element2)}, ${elements.Get(element1)}´);





        z= test123.Get(0);

        z= test123.Count() + 4;


        y = llList2Float(points, element1) + 
            llList2Float(points, element2) + 
            llList2Float(points, element3);


        llOwnerSay( "valued at "+  
        (string)llRound(y)
        );


    }
} 