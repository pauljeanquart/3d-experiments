newTube();


module newTube(){
    difference(){
        union(){
            translate([0,0,6]){
                top();
            }
            bottom();
        }
       
        translate([-50, 0,-3]){
             rotate([-45,0,90]){
        cylinder(d=1.5, h=8,$fn=99);
        }
    }
    }
}

module top() {
    difference(){
  original(); 
       translate([-140,-40,0]){ 
     cube([100,100,2])  ;
       }
    }
}
module bottom() {
    intersection(){
  original(); 
       translate([-140,-40,0]){ 
      cube([100,100,9])  ;
       }
    }
}


module original() {
import("/home/pi/_git/3d-experiments/battery/screw-cap-tube/18650CaseNoKnurbs.stl");
}




