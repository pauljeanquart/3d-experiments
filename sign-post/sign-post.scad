$fn = 99;
postSize = 22;
postHeight = 60;

width = 39;
union(){
difference() {
  translate([-2,-2,1]) { cube([52,width + 4,62]);    }
  cup(offset=5, w=width);
}
translate([24,width/2,60]){
#post();
}
}


module cup(offset, w) {
CubePoints = [
  [  0,  0,  0 ],  //0
  [ 48,  0,  0 ],  //1
  [ 48,  w,  0 ],  //2
  [  0,  w,  0 ],  //3
  [  offset,  0,  59 ],  //4
  [ 48-offset,  0, 59],  //5
  [ 48-offset,  w,  59],  //6
  [  offset,  w,  59 ]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
polyhedron( CubePoints, CubeFaces );
}

module post() {
union() {
    cylinder(h = postHeight,d = 30,center = false);
    translate([postSize/-2,postSize/-2,0]) {
    cube([postSize,postSize,postHeight]);
    }
   // cylinder(h = 20,d = 5,center = false);
}
}