union() {

difference() {

translate([20,-12,0])
  import("d:/_git/3d-experiments/makerbeamxl/FirstHinge15mm.stl", convexity=10);

# translate([-10.3,-2,0])  
  cylinder(18,2,2);
    
    # translate([-33,-8,0])  
  cube(20,20);
}

translate([-5,-6.8,1]) 
cube([4,2,6]);
}