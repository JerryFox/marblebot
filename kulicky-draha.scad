// funkcni vzorek
// vytisteno 5 x 5 v cervenem plastu

modul = 1000 / 60; 
pocetX = 5; 
pocetY = 5; 
diraR = 2.5; 
okrajTloustka = 5; 
okrajVyska = 20; 

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