
difference(){
cube([250,50,4],false);
    translate([20,25,0]){
cylinder(6,4,false);
    }
        translate([220,25,0]){
cylinder(6,4,false);
    }
}

translate([240, 25,28]){
    myring(49);
}

translate([4, 25,28]){
    myring(49);
}

difference(){
translate([0,56,0]){
rotate([90,00,]){
cube([5,25,60], false);
translate([0,32,0]) {
cube([5,25,60], false);
}
}
}
translate([-2,25,28]){
myring(56,30);
}
}

module myring (d, t=7) {
       rotate([0,90,0]) {
        difference(){
            cylinder(10,d=d+t,false);
            translate([0,0,-1]){
                cylinder(12,d=d,false);
            }
        }
    }
 
    
}