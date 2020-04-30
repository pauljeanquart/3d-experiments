difference(){
import("/home/pi/_git/3d-experiments/battery/screw-cap-tube/18650CapNoKnurbs.stl");
        translate([00, 0,-3]){
             rotate([-45,0,90]){
        cylinder(d=1.5, h=8,$fn=99);
        }
    }
}