use </home/pi/_git/3d-experiments/power-tower/sixinch_enclosure.scad>

// dcBarTest();

panelUSB();

$fn = 99;

module dcBarTest() {
    difference(){
        cube([14.05*1.5,14.05*3,3]);
        translate([10,10,0]) {
            dualBannana();
        }
    }
}
 
module dcBarFinal() {
rotate ([90,0,45]) {
    translate([-(155/2),0,-1.5]){
    dcBar();
   }
}
}

module dcBar() {
      difference(){
        sidepanel(3,false);
        dualBannana();
        translate([19.05,0,0]) {
            dualBannana();
        }
        translate([19.05 * 2,0,0]) {
            dualBannana();
        } 
     translate([19.05 * 4.5,5,0]) {
        panelUSB();
                }
   translate([19.05 * 4.5,21,0]) {
        panelUSB();
                }

      }
    }


     
module  dualBannana2() {
translate([31.25,(42.15  
    - 19.05)/2,-1]) {
     cylinder(6,d=5.5, false);
    translate([0,19.05,0]) {
        cylinder(6,d=5.5, false);

    }
  }
}

module dualBannana(){
    bannana();
    translate([0,19.05,0])
    {
        bannana();
    }
}

module bannana() {
  translate([0,0,-1]) {
    cylinder(4,d=8.5, false);
        }
  translate([0,0,1]) {
    cylinder(2,d=11.5, false);
        }
}

module panelUSB(){
    translate([(36-16)/2,(15-8)/2,-1]) {
     #  cube([16,8,6]);
    }
    translate([3.5,7.5,-1]) {
     #  cylinder(6,d=4, false);
    }
   translate([32.5,7.5,-1]) {
     #  cylinder(6,d=4, false);
    }
}
