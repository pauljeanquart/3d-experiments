$fn = 99;
cubeSize = 22;
difference() {
    translate([-1,-1,1]) {
 cube([50,45,60]);
        }
 
# cup();
}


module cup() {
CubePoints = [
  [  0,  0,  0 ],  //0
  [ 48,  0,  0 ],  //1
  [ 48,  43,  0 ],  //2
  [  0,  43,  0 ],  //3
  [  3.5,  0,  59 ],  //4
  [ 41+3.5,  0, 59],  //5
  [ 41+3.5,  43,  59],  //6
  [  3.5,  43,  59 ]]; //7
  
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
    cylinder(h = 10,d = 30,center = false);
    translate([cubeSize/-2,cubeSize/-2,0]) {
    cube([cubeSize,cubeSize,10]);
    }
    cylinder(h = 20,d = 5,center = false);
}
}