$fa = 0.5; // default minimum facet angle is now 0.5
$fs = 0.5; // default minimum facet size is now 0.5 mm

// Parametric Funnel by Coasterman

// VARIABLES
bottom_diameter = 110;
bottom_height = 20;
top_diameter = 44;
top_height = 5;
width = 2.0;
cone_height = 60;

cone_2_height = 3;
top_2_height = 5;
top_2_diameter = 38;

module funnel()
{
    // CODE
    union()
    {
        difference()
        {
            cylinder(h = bottom_height, r = bottom_diameter / 2 + width);
            translate([ 0, 0, -2 ])
            {
                cylinder(h = bottom_height + 4, r = bottom_diameter / 2);
            }
        }
        translate([ 0, 0, bottom_height ])
        {
            difference()
            {
                cylinder(h = cone_height, r1 = bottom_diameter / 2 + width, r2 = top_diameter / 2 + width);
                translate([ 0, 0, -1]) 
                {
                    cylinder(h = cone_height+2, r1 = bottom_diameter / 2, r2 = top_diameter / 2);
                }
            }
        }
        translate([ 0, 0, cone_height + bottom_height ])
        {
            difference()
            {
                cylinder(h = top_height, r = top_diameter / 2 + width);
                translate([ 0, 0, -2 ])
                {
                    cylinder(h = top_height + 4, r = top_diameter / 2);
                }
            }
        }
        
        // in the bottle narrowing
        translate([ 0, 0, top_height+cone_height + bottom_height ])
        {
            difference()
            {
                cylinder(h = cone_2_height, r1 = top_diameter / 2 + width, r2 = top_2_diameter / 2 + width);
                translate([ 0, 0, -1]) 
                {
                    cylinder(h = cone_2_height+2, r1 = top_diameter / 2, r2 = top_2_diameter / 2);
                }
            }
        }
        
        // top top
        translate([ 0, 0, cone_height + bottom_height + top_height + cone_2_height])
        {
            difference()
            {
                cylinder(h = top_2_height, r = top_2_diameter / 2 + width);
                translate([ 0, 0, -2 ])
                {
                    cylinder(h = top_2_height + 4, r = top_2_diameter / 2);
                }
            }
        }
    }
}

difference()
{
    funnel();
    //cube([ 115, 115, 150 ], center = true);
}