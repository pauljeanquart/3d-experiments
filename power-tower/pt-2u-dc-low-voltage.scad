use </home/pi/_git/3d-experiments/power-tower/sixinch_enclosure.scad>

//rotate ([90,0,45]) {
//    translate([-(155/2),0,-1.5]){
      difference(){
      sidepanel(3,false);


      }
//    }
//}
      
translate([(155-31.75)-36.2,(42.15-28)/2,0]) {
      dualUSB();
 }

dualBannana();

translate([19.05,0,0]) {
    dualBannana();
}
translate([19.05 * 2,0,0]) {
    dualBannana();
}
     
module  dualBannana() {
translate([31.25,(42.15  
    - 19.05)/2,-1]) {
    # cylinder(6,d=5.5, false);
    translate([0,19.05,0]) {
       # cylinder(6,d=5.5
        , false);

    }
  }
}
module dualUSB(){
 # cube([36.2,28,6]);
}

module lighterSocket() {
    translate([4*25.4,(42.15  
    - 25.4)/2+12.7,-1]) {
    # cylinder(6,d=25.4, false);
    }
}