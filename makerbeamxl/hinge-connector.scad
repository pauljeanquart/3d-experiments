rotate([0,90,0]) {
rotate([0,00,30]) {
difference(){
cylinder($fn = 6, h = 100, r1 = 3.75, r2 = 3.75, center = false);
# translate([0,0,-1])
{
 cylinder($fn = 100, h = 14, r1 = 1.6, r2 = 1.6, center = false);
}
# translate([0,0,100-13])
{
 cylinder($fn = 100, h = 14, r1 = 1.6, r2 = 1.6, center = false);
}
}
}
}