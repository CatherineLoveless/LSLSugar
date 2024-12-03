list Points = [0,
0.5,
0.5,
0.5,
0.5,
0.5,
1,
1,
1,
1,
1,
1,
1,
1,
2,
2,
2,
2,
2,
2,
3,
3,
3,
3,
3,
3,
3,
4,
4,
4,
5,
5,
6,
7,
8,
10,
10,
15,
18,
20,
25,
27,
28,
31,
62,
62];


list Elements = [
"Impurities",
"Lead(Pb)",
"Manganese(Mn)",
"Aluminum(Al)",
"Zinc(Zn)",
"Titanium(Ti)",
"Copper(Cu)",
"Chromium(Cr)",
"Ytterbium(Yb)",
"Cadmium(Cd)",
"Nickel(Ni)",
"Tin(Sn)",
"Thulium(Tm)",
"Vanadium(V)",
"Molybdenum(Mo)",
"Praseodymium(Pr)",
"Erbium(Er)",
"Tungsten(W)",
"Cerium(Ce)",
"Holmium(Ho)",
"Zirconium(Zr)",
"Lanthanum(La)",
"Dysprosium(Dy)",
"Neodymium(Nd)",
"Terbium(Tb)",
"Gadolinium(Gd)",
"Europium(Eu)",
"Samarium(Sm)",
"Samarium(Sm)",
"Tantalum(Ta)",
"Indium(In)",
"Gallium(Ga)",
"Silver(Ag)",
"Hafnium(Hf)",
"Germanium(Ge)",
"Scandium(Sc)",
"Lutetium(Lu)",
"Rhenium(Re)",
"Osmium(Os)",
"Ruthenium(Ru)",
"Iridium(Ir)",
"Platinum(Pt)",
"Palladium(Pd)",
"Rhodium(Rh)",
"Gold(Au)",
"Unobtanium(Ua)"];

float tollerance = 0.05;

list values= [
0,2,2,3,3,
6,9,10,10,15,
18,20,20,25,30,
30,30,35,40,40,
50,50,50,60,60,
70,80,100,100,150,
300,300,750,1000,1500,
4000,5000,15000,18000,20000,
25000,27000,28000,31000,62000,
62000];

list temp = [];

integer element1 = -1;
integer element2 = -1;
integer element3 = -1;
integer i = 0;
integer x=0;
float y = 0;
float z = 0;
float q =

roll(){
    temp =[];
    element1 = 7;
    element2 = 0;
    element3 = 0;
    
    for (i=1; i< 44; i++){
        x =llList2Integer(values,i);
        z = llRound(llFrand(x));


      if( - x  ){
         temp += i; 
        }    
    }
    
     if (llGetListLength(temp) == 1 && llList2Integer(values,0) != 0 ){
        element1 = llList2Integer(values,0);
        element2 = llRound(llFrand(4)); // you get something semi shitty..
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
    
        llOwnerSay( "Ore contains: " + llList2String( Elements, element1) + ", "+ llList2String( Elements, element2) + ", "+ llList2String( Elements, element3));
        

        llOwnerSay((string)element1 + "= "+ (string)llList2Float(Points, element1));
        llOwnerSay((string)element2 + "= "+ (string)llList2Float(Points, element2));    
        llOwnerSay((string)element3 + "= "+ (string)llList2Float(Points, element3));


        y = llList2Float(Points, element1) + 
            llList2Float(Points, element2) + 
            llList2Float(Points, element3);


        llOwnerSay( "valued at "+  
        (string)llRound(y)
        );


    }
}
list Points = [0,
0.5,
0.5,
0.5,
0.5,
0.5,
1,
1,
1,
1,
1,
1,
1,
1,
2,
2,
2,
2,
2,
2,
3,
3,
3,
3,
3,
3,
3,
4,
4,
4,
5,
5,
6,
7,
8,
10,
10,
15,
18,
20,
25,
27,
28,
31,
62,
62];


list Elements = [
"Impurities",
"Lead(Pb)",
"Manganese(Mn)",
"Aluminum(Al)",
"Zinc(Zn)",
"Titanium(Ti)",
"Copper(Cu)",
"Chromium(Cr)",
"Ytterbium(Yb)",
"Cadmium(Cd)",
"Nickel(Ni)",
"Tin(Sn)",
"Thulium(Tm)",
"Vanadium(V)",
"Molybdenum(Mo)",
"Praseodymium(Pr)",
"Erbium(Er)",
"Tungsten(W)",
"Cerium(Ce)",
"Holmium(Ho)",
"Zirconium(Zr)",
"Lanthanum(La)",
"Dysprosium(Dy)",
"Neodymium(Nd)",
"Terbium(Tb)",
"Gadolinium(Gd)",
"Europium(Eu)",
"Samarium(Sm)",
"Samarium(Sm)",
"Tantalum(Ta)",
"Indium(In)",
"Gallium(Ga)",
"Silver(Ag)",
"Hafnium(Hf)",
"Germanium(Ge)",
"Scandium(Sc)",
"Lutetium(Lu)",
"Rhenium(Re)",
"Osmium(Os)",
"Ruthenium(Ru)",
"Iridium(Ir)",
"Platinum(Pt)",
"Palladium(Pd)",
"Rhodium(Rh)",
"Gold(Au)",
"Unobtanium(Ua)"];


list values= [
0,
2,
2,
3,
3,
6,
9,
10,
10,
15,
18,
20,
20,
25,
30,
30,
30,
35,
40,
40,
50,
50,
50,
60,
60,
70,
80,
100,
100,
150,
300,
300,
750,
1000,
1500,
4000,
5000,
15000,
18000,
20000,
25000,
27000,
28000,
31000,
62000,
62000];

list temp = [];

integer element1 = -1;
integer element2 = -1;
integer element3 = -1;
integer i = 0;
integer x=0;
float y = 0;
roll(){
    temp =[];
    element1 = 7;
    element2 = 0;
    element3 = 0;
    
    for (i=1; i< 44; i++){
        x =llList2Integer(values,i);
      if(llRound(llFrand(x)) == x){
         temp += i; 
        }    
    }
    
     if (llGetListLength(temp) == 1 && llList2Integer(values,0) != 0 ){
        element1 = llList2Integer(values,0);
        element2 = llRound(llFrand(4)); // you get something semi shitty..
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
    
        llOwnerSay( "Ore contains: " + llList2String( Elements, element1) + ", "+ llList2String( Elements, element2) + ", "+ llList2String( Elements, element3));
        

        llOwnerSay((string)element1 + "= "+ (string)llList2Float(Points, element1));
        llOwnerSay((string)element2 + "= "+ (string)llList2Float(Points, element2));    
        llOwnerSay((string)element3 + "= "+ (string)llList2Float(Points, element3));


        y = llList2Float(Points, element1) + 
            llList2Float(Points, element2) + 
            llList2Float(Points, element3);


        llOwnerSay( "valued at "+  
        (string)llRound(y)
        );


    }
}
