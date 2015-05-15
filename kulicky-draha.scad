/*
MARBLEBOT
MARBLE-BOT
BB-BOT (BallBearing-BOT)
BBB-BOT (BallBearingBall-BOT)

oble rohy - kvuli zvedani modelu pri tisku
*/
modul = 1000 / 60; 
pocetX = 5; 
pocetY = 5; 
diraR = 1.5; 
okrajTloustka = 6; 
okrajVyska = 18; 
vnitrniOkraj = 4; 

module roundCube(x, y, z, r) {
	translate([r, r, 0]) 
	minkowski() {
		cube([x - 2 * r, y - 2 * r, z / 2]);
		cylinder(r = r, h = z / 2);  
	}
}

module sikmyKriz() {
	for (i = [0, 90, 180, 270]) {
		rotate(i, [0, 0, 1]) 
		hull() {
			sphere(5);
			translate([modul / 2, 0, 1.5]) sphere(5);
		}
	}
}

module draha() {
	$fn = 30;
	// vlastni draha
	difference()  
	{
		roundCube(modul * pocetX + 2 * vnitrniOkraj + 2 * okrajTloustka, 
		modul * pocetY + 2 * vnitrniOkraj + 2 * okrajTloustka, 10, 10 + okrajTloustka); 
		for (i = [0 : (pocetX - 1)]) {
			for (j = [0 : (pocetY - 1)]) {
				translate([(i + 0.5) * modul + vnitrniOkraj + okrajTloustka, (j + 0.5) * modul + vnitrniOkraj + okrajTloustka, -1]) 
				cylinder(r = diraR, h = 30); 
				translate([(i + 0.5) * modul + vnitrniOkraj + okrajTloustka, (j + 0.5) * modul + vnitrniOkraj + okrajTloustka, 10]) 
				sikmyKriz(); 
			}
		}
	}
}

module ohradka() {
	$fn = 30;
	difference()  
	{
		roundCube(modul * pocetX + 2 * vnitrniOkraj + 2 * okrajTloustka, modul * pocetY + 2 * vnitrniOkraj + 2 * okrajTloustka, 
		okrajVyska, 10 + okrajTloustka); 
		translate([okrajTloustka, okrajTloustka, -1]) 
		roundCube(modul * pocetX + 2 * vnitrniOkraj, modul * pocetY + 2 * vnitrniOkraj, okrajVyska + 2, 10); 
	}
}

module draha_s_ohradkou() {
	$fn = 30;
	// draha s ohradkou
	union() { 
		// vlastni draha
		draha(); 
		// ohradka
		ohradka();
	}
}

module diry_na_svetlo() {
	$fn = 30;
	for (i = [0 : (pocetX - 1)]) {
		translate([(i + 0.5) * modul + vnitrniOkraj + okrajTloustka, -1, 8])
		rotate(90, [-1, 0, 0])
		union() {
			cylinder(r = 1.5, h = pocetY * modul + 2 * (vnitrniOkraj + okrajTloustka) + 2);
			cylinder(r = 3, h = okrajTloustka + 1.1); // dira na laser
			translate([0, 0, pocetY * modul + 2 * (vnitrniOkraj + okrajTloustka) - 2])
			cylinder(r = 2, h = okrajTloustka / 3 + 2); // zapusteni diody
		}
	}
	for (j = [0 : (pocetY - 1)]) {
		translate([-1, (j + 0.5) * modul + vnitrniOkraj + okrajTloustka, 8])
		rotate(90, [0, 0, -1])
		rotate(90, [-1, 0, 0])
		union() {
			cylinder(r = 1.5, h = pocetX * modul + 2 * (vnitrniOkraj + okrajTloustka) + 2);
			cylinder(r = 3, h = okrajTloustka + 1.1); // dira na laser
			translate([0, 0, pocetX * modul + 2 * (vnitrniOkraj + okrajTloustka) - 2])
			cylinder(r = 2, h = okrajTloustka / 3 + 2); // zapusteni diody
		}
	}
}


difference() {
	draha_s_ohradkou();
	diry_na_svetlo();
} 
//roundCube(30, 20, 10, 5); 


