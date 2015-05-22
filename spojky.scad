profilSirka = 10; 
profilVyska = 10; 
tloustka = 1; 

module rameno() {
    difference() {
        cube([profilSirka + 2 * tloustka, 3 * profilSirka, profilVyska + 2 * tloustka]); 
        translate([tloustka, profilVyska, tloustka]) 
        cube([profilSirka, 3 * profilSirka, profilVyska]); 
    }
}

module dvojRameno() {
    rameno(); 
    translate([0, profilVyska + 2 * tloustka, 0]) 
    rotate(90, [1, 0, 0]) 
    rameno(); 
}

module trojRameno() {
    dvojRameno(); 
    translate([0, profilSirka + 2 * tloustka, 0]) 
    rotate(90, [0, 0, -1])
    rameno(); 
}

trojRameno(); 
