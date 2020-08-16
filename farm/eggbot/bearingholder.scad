rotate([0,90,0]){
difference(){
scale([1, .85,.85]) {
#import("/home/pi/_git/3d-experiments/farm/eggbot/EggBot_07.stl");
}

translate([31,0,0]){
rotate([0,90,0]){
cylinder(d=24.5,h=8+1, $fn=99);
}}

translate([39,0,0]){
rotate([0,90,0]){
cylinder(d=25,h=7, $fn=99);
}}

}

}