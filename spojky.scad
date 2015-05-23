profilSirka = 10; 
profilVyska = 10; 
tloustka = 1; 
tolerance = 0.2;
sirka = profilSirka + tolerance;
vyska = profilVyska + tolerance;

module rameno() {
    $fn=30; 
    difference() {
        minkowski() {
            cube([sirka + 2 * tloustka, 3 * sirka, vyska + 2 * tloustka]); 
            sphere(r = 2); 
        }
        color("red") 
        translate([tloustka, vyska, tloustka]) 
        cube([sirka, 3 * sirka, vyska]); 
    }
}

module dvojRameno() {
    rameno(); 
    translate([0, vyska + 2 * tloustka, 0]) 
    rotate(90, [1, 0, 0]) 
    rameno(); 
}

module trojRameno() {
    dvojRameno(); 
    translate([0, sirka + 2 * tloustka, 0]) 
    rotate(90, [0, 0, -1])
    rameno(); 
}

trojRameno(); 
