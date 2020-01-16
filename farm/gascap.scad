difference ()
{
	union ()
	{
	translate([0,0,0]) cylinder(3.5,36/2,38.3/2,$fn=50);	
	translate([0,0,3.5]) cylinder(1.5,38.3/2,34.3/2,$fn=50);	
	translate([0,0,5]) cylinder(19,34/2,32.3/2,$fn=50);



	}
//	translate([0,0,21])  rotate_extrude(convexity = 10) translate([12,0,0]) circle(r = 1.5);
	translate([0,0,-.01]) cylinder(22,22/2,21.5/2,$fn=50);	
	translate([17.5,-15,0]) cube([5,30,10]);

}