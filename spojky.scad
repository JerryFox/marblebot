profilSirka = 10; 
profilVyska = 10; 
tloustka = 1; 
tolerance = 0.3;
sirka = profilSirka + tolerance;
vyska = profilVyska + tolerance;
radius = 2; 

module rameno(delka=3*sirka) {
    $fn=30; 
    difference() {
        minkowski() {
            cube([sirka + 2 * tloustka, delka, vyska + 2 * tloustka]); 
            sphere(r = radius); 
        }
        color("red") 
        translate([tloustka, vyska, tloustka]) 
        cube([sirka, delka, vyska]); 
    }
}

module dutinka(delka=3*sirka) {
    $fn=30; 
    difference() {
        minkowski() {
            cube([sirka + 2 * tloustka, delka - 2 * radius, vyska + 2 * tloustka]); 
            sphere(r = radius); 
        }
        color("red") 
        translate([tloustka, -1 - radius, tloustka]) 
        cube([sirka, delka + 2 + 2 * radius, vyska]); 
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

module sg90HorniLevy() {
    // drzak serva nad ramem
    $fn = 30; 
    delka = 25; 
    radius = 2; 
    tl = 7; 
    s = 12; 
    dutinka(delka); 
    translate([-radius, 4.6 - radius, vyska + tloustka]) 
    difference() {
        cube([tl, delka, s]); 
        translate([-1, delka - 2.3, s / 2])
        rotate(90, [0, 1, 0]) 
        cylinder(r = 0.75, h = tl + 2);
    } 
}

module sg90HorniPravy() {
    // drzak serva nad ramem
    $fn = 30; 
    delka = 25; 
    radius = 2; 
    tl = 7; 
    s = 12;
    dutinka(delka);  
    translate([-radius, - 4.6 - radius, vyska + tloustka]) 
    difference() {
        cube([tl, delka, s]); 
        translate([-1, 2.3, s / 2])
        rotate(90, [0, 1, 0]) 
        cylinder(r = 0.75, h = tl + 2);
    } 
}

module drzakOsy() {
    // drzak osy nad ramem
    $fn = 30; 
    delka = 25; 
    radius = 2; 
    tl = 7; 
    s = 12;
    difference() {
        union() {
            difference() {
                hull() {
                    dutinka(delka);  
                    translate([0, delka / 2 - radius, vyska + tloustka + 6]) 
                    rotate(90, [0, 1, 0])
                    minkowski() {
                        cylinder(r = 5, h = sirka + 2 * tloustka); 
                        sphere(r = radius); 
                    }
                }
                translate([-radius - 1, -radius - 1,  -radius - tloustka]) 
                cube([sirka + 2 * (tloustka + radius + 1), delka + 2, vyska + 2 * tloustka + radius]); 
            }
                dutinka(delka); 
        }
        translate([-radius - 1, delka / 2 - radius, vyska + tloustka + 6])
        rotate(90, [0, 1, 0]) 
        {
            cylinder(r = 1.35, h = sirka + 2 * (tloustka + radius + 1)); 
            cylinder(r = 5, h = 2 + 1); 
        }
    }
}

module servo_arm(body_r = 7.5/2, arm_r1 = 6/2, arm_r2 = 4/2, arm_len = 15, arm_t = 1.5, body_t = 5) {
    // http://www.thingiverse.com/thing:449397
    $fn = 30; 
	cylinder(r = body_r, h = body_t);
	
	linear_extrude(height = arm_t) {
		circle(r = arm_r1);
		translate([0,arm_len,0]) circle(r = arm_r2);
		polygon(points = [ [-arm_r1, 0], [arm_r1, 0], [arm_r2, arm_len], [-arm_r2, arm_len] ]);
	}
}
//
module pouzdroRameneServa() {
    // upevneni ramena pro rotaci
    $fn = 30; 
    delka = 30; 
    radius = 2; 
    tl = 7; 
    s = 12; 
    difference() {
        dutinka(delka);
        translate([sirka / 2 + tloustka, -radius, 1.01]) 
        rotate(180, [0, 1, 0]) 
        servo_arm(arm_t = 2); 
    }
}

module dutinkaNaOsu() {
    $fn = 30; 
    delka = 30;
    difference() {
        union() {
            dutinka(delka); 
            translate([sirka / 2 + tloustka, delka / 2 - radius, vyska + 2 * tloustka + radius]) 
            cylinder(r = 4, h = 3) ; 
        }
        translate([sirka / 2 + tloustka, delka / 2 - radius, vyska]) 
        cylinder(r = 1.65, h = vyska); 
    }
}


//translate([0, -40, 0]) 
//sg90HorniPravy(); 
//sg90HorniLevy(); 

pouzdroRameneServa(); 
//dutinka(); //
//dutinkaNaOsu(); 
//drzakOsy(); 