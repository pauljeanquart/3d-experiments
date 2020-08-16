union(){
import("/home/pi/_git/3d-experiments/farm/beebix weather station/files/center-fix.stl");
translate([0,0,25]){
difference(){
    cylinder(1.5,d1=50, d2=40, true);
    cylinder(2, d=38, true);
}}}