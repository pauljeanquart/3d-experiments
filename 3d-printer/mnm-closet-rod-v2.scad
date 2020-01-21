union() {
hangerBase();
    translate([0,0,-10]) {
  snip();
    }
}

module hangerBase() {
difference() {
hanger();
    translate ([-121,-1,80]) {
     cube([122,122,21]);
    }
}
}


module snip() {
  intersection() {
  hanger();
    translate ([-121,-1,89]) {
     cube([122,122,12]);
    }
 }
}

module hanger(){
    difference() {
        union() {
            translate([-12.8,12.8,0]) {
                rotate([0,0,-45]) {
                import("D:/_git/3d-experiments/3d-printer/Filament_Spool_Closet_Rod_Hanger_-_smaller_spool_r2.stl");
                }
            }
            translate([-12,12,98]) {
              cylinder(h=2, d=48, center=false);
            }

            translate([-14,12,0]) {
              cylinder(h=2, d=53, center=false);
            }
            
            translate([-12,12,0]) {
              cylinder(h=12, d=55, center=false);
            }

        }
        translate([-39,-20,-4]) {
         cube([60,20,120]);
        }

        translate([0,-20,-4]) {
         cube([20,60,120]);
        }

    }

    translate([-28,0,0]) {
    cube([28,28,100]);
    }
}



