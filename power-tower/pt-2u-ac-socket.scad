use </home/pi/_git/3d-experiments/power-tower/sixinch_enclosure.scad>

rotate ([90,0,45]) {
    translate([-(155/2),0,-1.5]){
      difference(){
      sidepanel(2,false);

      translate([155/2-9,(28-22)/2,-2]) {
        cube([24,22,6]);
        }
      }
    }
}