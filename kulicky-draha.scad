modul = 1000 / 60; 
pocetX = 5; 
pocetY = 5; 
diraR = 1.5; 
okrajTloustka = 6; 
okrajVyska = 18; 
vnitrniOkraj = 4; 

module roundCube(x, y, z, r) {
	translate([r, r, O]) 
	minkowski() {
		cube([x - 2 * r, y - 2 * r, z / 2]);
		cylinder(r = r, h = z / 2);  
	}
}

module draha01() {
	$fn = 30;
	difference()  
	{
		cube([modul * pocetX + 2 * okrajTloustka, modul * pocetY + 2 * okrajTloustka, okrajVyska]); 
		translate([okrajTloustka, okrajTloustka, 10]) cube([modul * pocetX, modul * pocetY, okrajVyska]); 
		translate([0, 0, 10]) 
		{
			for (i = [0 : (pocetX - 1)] ) {
				translate([(i + 0.5) * modul + okrajTloustka, okrajTloustka, 0]) rotate(90, [-1, 0, 0]) cylinder(r = 5, h = modul * (pocetY)); 
			}
			for (i = [0 : (pocetY - 1)] ) {
				translate([okrajTloustka, (i + 0.5) * modul + okrajTloustka, 0]) rotate(90, [0, 1, 0]) cylinder(r = 5, h = modul * (pocetX)); 
			}
		}
		for (i = [0 : (pocetX - 1)]) {
			for (j = [0 : (pocetY - 1)]) {
				translate([(i + 0.5) * modul + okrajTloustka, (j + 0.5) * modul + okrajTloustka, -1]) cylinder(r = diraR, h = 30); 
			}
		}
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

module draha02() {
	$fn = 30;
	difference()  
	{
		cube([modul * pocetX + 2 * okrajTloustka, modul * pocetY + 2 * okrajTloustka, 10]); 
		for (i = [0 : (pocetX - 1)]) {
			for (j = [0 : (pocetY - 1)]) {
				translate([(i + 0.5) * modul + okrajTloustka, (j + 0.5) * modul + okrajTloustka, -1]) cylinder(r = diraR, h = 30); 
				translate([(i + 0.5) * modul + okrajTloustka, (j + 0.5) * modul + okrajTloustka, 10]) sikmyKriz(); 
			}
		}
	}
	difference()  
	{
		cube([modul * pocetX + 2 * okrajTloustka, modul * pocetY + 2 * okrajTloustka, okrajVyska]); 
		translate([okrajTloustka, okrajTloustka, -1]) cube([modul * pocetX, modul * pocetY, okrajVyska + 2]); 
	}
}

module draha03() {
	$fn = 30;
	difference()  
	{
		roundCube(modul * pocetX + 2 * vnitrniOkraj + 2 * okrajTloustka, modul * pocetY + 2 * vnitrniOkraj + 2 * okrajTloustka, 10, 10 + okrajTloustka); 
		for (i = [0 : (pocetX - 1)]) {
			for (j = [0 : (pocetY - 1)]) {
				translate([(i + 0.5) * modul + vnitrniOkraj + okrajTloustka, (j + 0.5) * modul + vnitrniOkraj + okrajTloustka, -1]) cylinder(r = diraR, h = 30); 
				translate([(i + 0.5) * modul + vnitrniOkraj + okrajTloustka, (j + 0.5) * modul + vnitrniOkraj + okrajTloustka, 10]) sikmyKriz(); 
			}
		}
	}
	difference()  
	{
		roundCube(modul * pocetX + 2 * vnitrniOkraj + 2 * okrajTloustka, modul * pocetY + 2 * vnitrniOkraj + 2 * okrajTloustka, okrajVyska, 10 + okrajTloustka); 
		translate([okrajTloustka, okrajTloustka, -1]) roundCube(modul * pocetX + 2 * vnitrniOkraj, modul * pocetY + 2 * vnitrniOkraj, okrajVyska + 2, 10); 
	}
}


draha03();
//roundCube(30, 20, 10, 5); 


