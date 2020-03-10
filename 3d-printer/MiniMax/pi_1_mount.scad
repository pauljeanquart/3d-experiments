use <.\raspberry_pi_ab.scad>

use <.\raspi_mount.scad>


translate([0,-5,0]) {
rotate(a=90) { bottom();}
}

// parameters
thickness = 5;
standoffHeight = 5; // set to 0 for no standoff
extrusionMountScrewDiam = 5.9; // screw outer diameter
extrusionMountScrewHeadDiam = 10.5; // screw head outer diameter - only used if you set screwIndents to true
screwIndentDepth = 3; // depth the indent for the extrusion mounting screw head indent should be (must be less than thickness) - only used if screwIndents is true
raspiMountingScrewDiam = 4; // diameter of screws used to mount the raspi
extrusionMountingScrewHoleSep = 40; // hole separation between extrusion mounting holes

raspiHorizontalHoleSep = 48.5;
raspiVerticalHoleSep = 58;

difference() {
translate([0,0,3]) {
  raspiMount();
}
translate([-29,-44,0]) {
cube([58,88,12]);
}
}