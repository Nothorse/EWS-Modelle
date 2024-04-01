include <einzelteile/tor.scad>
include <einzelteile/turm.scad>
include <einzelteile/zinnenkranz.scad>
include <ewsbase.scad>
/**
 * Kontrolldatei für alle EWS-Gebäude
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

sideRad = hexradius(seite);

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