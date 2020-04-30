rotate([0,90,0]){
union(){
#import("/home/pi/_git/3d-experiments/farm/eggbot/EggBot_08.stl");

translate([-7.5,0,0]){
rotate([0,90,0]){
cylinder(d=9,h=9, $fn=99);
}}
}
}