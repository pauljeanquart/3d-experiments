$fn=360;

rotate([0,180,0]){
difference(){
  cylinder(10,d=16);
  
    translate([0,0,-1]) {
    cylinder(12,d=6);
        }
  translate([0,0,-.5]) {
  #cylinder(4.5, d=10.25);
  }
}
}