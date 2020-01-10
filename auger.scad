$fn=100;

width=18;
pitch=18;
thickness=.125;
pipe=2.125;
length=36;


flightwidth=7.88;
r1=11.69;
r2=3.81;

m = 4; //multiplier for printing

difference() {
pieSlice(355,r1*m,thickness*m);
# cylinder(6,r2*m,r2*m,center=true);
}

cylinder(pitch*m,pipe*m,pipe*m,center=false);

module pieSlice(a, r, h){
  // a:angle, r:radius, h:height
  rotate_extrude(angle=a) square([r,h]);
}
