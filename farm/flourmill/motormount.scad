h = 58;
d = 130;
wall = 8;
cogwidth = 10;
cogdepth = 3;
cogheight = 10;

all();

// r[adius], h[eight], [rou]n[d]
module rounded_cylinder(r, h, n) {
  rotate_extrude(convexity = 1) {
    offset(r = n) offset(delta = -n) square([ r, h ]);
    square([ n, h ]);
  }
}

module horn2() {
  difference() {
    horn();
    rh = 20;
    translate([ -d / 2 + 17 + 5, 0, h / 2 - (rh / 2) ]) {
      rounded_cylinder(r = d / 2, h = rh, n = 7, $fn = 180);
    }
  }
}

// horn();

module all() {
  difference() {
    motorMount();
    translate([ -70, 6, h - 20 ]) {
      rotate(a = -12) { cube(size = [ 18, 18, 22 ], center = false); }
    }
  }
}

module horn() {
  difference() {
    roundedTri();
    translate([ 50, 0, -2 ]) { cylinder(h + 4, d1 = 14, d2 = 14, true); }
    translate([ -50, 0, -2 ]) { cylinder(h + 4, d1 = d, d2 = d, true); }
  }
}

module motorMount() {
  translate([ d / 2 - 13, 0, 0 ]) { horn2(); }
  $fn = 180;
  union() {
    ring();
    translate([ d / 2 - cogdepth, 0, 0 ]) { cog(); }
    translate([ -(d / 2) - cogdepth + wall / 2 + 1, 0, 0 ]) {
      rotate(a = 180) { cog(); }
    }
  }
}

module cog() {

  cube(size = [ cogdepth + 1, cogwidth, cogheight ], center = false);
}

module ring() {
  difference() {
    cylinder(h, d1 = d + wall, d2 = d + wall, true);
    , , translate([ 0, 0, -2 ]) { cylinder(h + 4, d1 = d, d2 = d, true); }
  }
}

module roundedTri() {
  $fn = 75;
  minkowski() {
    cylinder(d = 100, h, $fn = 3); // makes ,,y,our triangle
    cylinder(d = 30, h = 0.00001); // rounds off the corners
  }                                // end minkowski
}


ass





















