use </home/pi/_git/3d-experiments/power-tower/sixinch_enclosure.scad>

blankFacePlate(2);

module blankFacePlate(heightInUnits){
    rotate ([90,0,45]) {
        translate([-(155/2),0,-1.5]){
            sidepanel(heightInUnits,false);
        }
    }
}

