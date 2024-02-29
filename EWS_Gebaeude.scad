include <einzelteile/tor.scad>
include <einzelteile/turm.scad>
include <einzelteile/zinnenkranz.scad>
include <ewsbase.scad>
/**
 * Gebäude für EWS
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */

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

// Berechnete größen

sideRad = seite * sqrt(3) / 2;

function flatten(l) = [for (a = l) for (b = a) b];

function intersect(l) = [for (c = l) for (d = c) d];

x = intersect([ [1:2], [ 1, 3 ] ]);
echo(x);

if (zinnen_zeigen) {
  move(z = 1) zinnenkranz(zinnen_durchgaenge, zinnentyp);
}

if (turm_zeigen) {
  move(x = sideRad * 3) turm(tore, durchgaenge, mauerwerk, fenster, torform);
}

if (bergfried_zeigen) {
  move(x = sideRad * 3, y = sideRad * 3, z = 2)
      bergfried(bf_durchgaenge, mauerwerk);
}

if (tor_zeigen) {
  move(x = -sideRad * 3, z = 1, rx = -90) tor(tortyp);
  if (tortyp == "1")
    move(x = -(sideRad * 2) + 4) drehtordorn();
}

if (Mauer_zeigen) {
  move(y = sideRad * 3) solomauer(mauerwerk);
}

module solomauer(struktur) {
  intersection() {
    difference() {
      union() {
        cube([ seite, 1, hoehe ]);
        if (struktur) {
          move(x = 0, y = -0.1, rx = 90) { _mauerstruktur(); }
        }
        cube([ seite, sideRad - 5, 2 ]);
      }
      move(z = 7, x = seite / 2) _fenster();
      move(x = -1, y = -2, z = hoehe - 3.6) cube([ seite + 5, 4, 4 ]);
    }
    move(y = 4, x = seite / 2) triangle_prism(hoehe + 10, seite / 3 * 2);
  }
  move(y = -1, x = 1) cube([ seite - 2, 1, 1 ]);
}