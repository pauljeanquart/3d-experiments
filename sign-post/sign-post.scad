
$fn = 99; // number of faces

width = 39;


support();

module support() {
    union()
    {
        difference()
        {
            translate([ -2, -2, 0 ]) { cube([ 52, width + 4, 65 ]); }
            translate([ 0, 0, -1]) { cup(offset = 5, w = width); }
        }
        postHeight = 120;
        translate([ 24, width / 2, 0 ]) { post(22, postHeight); }
        translate([24,width / 2,60]) {outsidePost(height = 60, diameter = 40.5);}
    }
}

module outsidePost(height, diameter) {
    difference(){
    cylinder(h = height, d = diameter + 8, center = false);
      #  translate([0,0,-1]) { cylinder(h = height+2, d = diameter, center = false);}
    }
}

module cup(offset, w)
{
    CubePoints = [
        [ 0, 0, 0 ],            // 0
        [ 48, 0, 0 ],           // 1
        [ 48, w, 0 ],           // 2
        [ 0, w, 0 ],            // 3
        [ offset, 0, 59 ],      // 4
        [ 48 - offset, 0, 59 ], // 5
        [ 48 - offset, w, 59 ], // 6
        [ offset, w, 59 ]
    ];

    CubeFaces = [
        [ 0, 1, 2, 3 ], // bottom
        [ 4, 5, 1, 0 ], // front
        [ 7, 6, 5, 4 ], // top
        [ 5, 6, 2, 1 ], // right
        [ 6, 7, 3, 2 ], // back
        [ 7, 4, 0, 3 ] // left
    ];

    polyhedron(CubePoints, CubeFaces);
}

module post(diameter, height)
{
    union()
    {
        cylinder(h = height,, d = 30, center = false);
        translate([ diameter / -2, , , diameter / -2, 0 ])
        {
            cube([ diameter, diameter, height ]);
        }
    }
}
