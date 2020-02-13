include <font.scad>
include <teknik/font.scad>

Line_One_Text = "12345";

Line_Two_Text = "RANCH NAME";

Part_to_Render = 1;

//--------------------------------

Tag_Thickness = 3;
Tag_Width = 85;
Tag_Length = 50;

Tab_Width = 20;
Tab_Length = 45;

Peg_Minor_Diameter = 5;
Peg_Major_Diameter = 7;
Peg_Length = 15;
Peg_Base_Thickness = 2;

$fn = 55;

Part_to_Render();

module Part_to_Render(){

	if(Part_to_Render == 1)Tag();

	if(Part_to_Render == 2)Peg();

}

module Peg(){

cylinder(h = Peg_Base_Thickness, r = Peg_Minor_Diameter*2);

cylinder(h = Peg_Length+Peg_Base_Thickness, r = Peg_Minor_Diameter/2);

translate([0,0,Peg_Length+Peg_Base_Thickness])
cylinder(h = 5, r1 = Peg_Major_Diameter/2, r2 = 0);

}

module Tag(){

difference(){

union(){

	hull(){
	
		translate([(Tag_Length/2-5), (Tag_Width/2-5),0])
			cylinder(h = Tag_Thickness, r = 5, center = true, $fn = 4);
	
		translate([(Tag_Length/2-5), -(Tag_Width/2-5),0])
			cylinder(h = Tag_Thickness, r = 5, center = true, $fn = 4);

		translate([-(Tag_Length/2-5), -(Tag_Width/2-5),0])
			cylinder(h = Tag_Thickness, r = 5, center = true, $fn = 4);
	
		translate([-(Tag_Length/2-5), (Tag_Width/2-5),0])
			cylinder(h = Tag_Thickness, r = 5, center = true, $fn = 4);

		translate([-(Tag_Length/2-Tab_Width/2+Tab_Length/2), 0,0])
			cylinder(h = Tag_Thickness, r = Tab_Width/2, center = true, $fn = 4);

	}

	hull(){

		translate([-(Tag_Length/2+Tab_Length-Tab_Width/2), 0,0])
			cylinder(h = Tag_Thickness, r = Tab_Width/2, center = true);

		translate([(Tag_Length/2-Tab_Width/2), 0,0])
			cylinder(h = Tag_Thickness, r = Tab_Width/2, center = true);

	}

	translate([-(Tag_Length/2+Tab_Length-Tab_Width/2), 0,Tag_Thickness-.5])
		cylinder(h = Tag_Thickness+1, r = Peg_Major_Diameter/2+1, center = true);

}

	translate([-(Tag_Length/2+Tab_Length-Tab_Width/2), 0,Tag_Thickness-2])
		cylinder(h = Tag_Thickness*2+1, r = Peg_Minor_Diameter/2, center = true);

	translate([-(Tag_Length/2+Tab_Length-Tab_Width/2), 0,Tag_Thickness+1])
		cylinder(h = Tag_Thickness*2+1, r = Peg_Major_Diameter/2, center = true);

	Font_Line_One(Line_One_Text, Tag_Thickness);

	Font_Line_Two(Line_Two_Text, Tag_Thickness);

}

}

module Font_Line_One(Font, Thickness){

bbox1 = font_bbox (Font);
bbox2 = font_bbox (Font);
width = max (bbox1[0], bbox2[0]);
height = max (bbox1[1], bbox2[1]);

echo("Text Width = ", width);

echo("Text Height = ", height);


rotate([0,0,90])
	translate([0,Tag_Length/-2.5,0])
		scale([(Tag_Width/width/1.25),(Tag_Width/width/1.25),1])
			translate([width/-2, height,0])
				font_render(Font, height = Thickness);

}

module Font_Line_Two(Font, Thickness){

bbox1 = font_bbox (Font);
bbox2 = font_bbox (Font);
width = max (bbox1[0], bbox2[0]);
height = max (bbox1[1], bbox2[1]);

echo("Text Width = ", width);

echo("Text Height = ", height);


rotate([0,0,90])
translate([0,Tag_Length/2-height,0])
scale([(Tag_Width/(width+8)/1.05),(Tag_Width/(width+8)/1.05),1])
translate([width/-2, height,0])
	font_render(Font, height = Thickness);

}
