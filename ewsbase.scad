use <BOSL/constants.scad>
use <BOSL/math.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <MCAD/regular_shapes.scad>
use <commonfunctions.scad>

// Setup für Customizer
/* [Maße] */
// Höhe in mm
hoehe = 50;
// Seitenbreite
seite = 18.5;
/* [Gebäudeauswahl] */
// Turm
turm_zeigen = true;
// Bergfried oberer Turmteil
bergfried_zeigen = true;
// Tor mit Dorn
tor_zeigen = true;
// Zinnenkranz
zinnen_zeigen = true;
// Einzelmauer
Mauer_zeigen = true;
/* [Tore und Durchgänge] */
// Tore für Turm (Erdgeschoss BF) (Windrichtungen) z.B. [1]
tore = [];
// Durchgänge im Erdgeschoß (Windrichtungen)
durchgaenge = [];
// Durchgänge im Obergeschoß eines Bergfrieds (Windrichtungen)  z.B. [3,5]
bf_durchgaenge = [];
// Bei Zinnenkranz ausgesparte Seiten z.B. [3,5]
zinnen_durchgaenge = [];
/* [Dekoration] */
// Mauerstruktur
mauerwerk = true;
// Strukturauswahl
mauer_map = "mauer2.png"; //  ["mauer1.png":"Grob", "mauer2.png":"Mittel",
//  "mauer3.png":"Fein", "mauer4.png":"Bögen"]
// Gesimse und andere Mauerfeatures
gesimse = 0; // [0:Kein Gesims,1:Rechtwinklig,2:Faschen]
// Zinnenform
zinnentyp = 1; // [1:Rechteck, 2:Schwalbenschwanz, 3:Bogen]
// Fenstertyp
fenster = 1; // [1:"schmal", 2:"doppelbogen"]
// Tortyp
tortyp = 1; // [1:"Drehangel", 2:"Offen"]
// Torform
torform = 1; // [1:"8eck oben", 2:"Spitzbogen"]