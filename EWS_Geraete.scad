include <einzelteile/belagerungsturm.scad>
include <einzelteile/geraetebasis.scad>
include <einzelteile/kistenkroete.scad>
include <einzelteile/schildkroete.scad>
include <ewsbase.scad>
/**
 * remix erwünscht
 * module mit _name sind privat
 */
// Setup für Customizer
/* [Maße] */
// Höhe in mm
basishoehe = 50;
// Seitenbreite
seite = 18.5;
/* [Modelle] */
// Einfache Schildkröte
schildkroete_zeigen = true;
// Gezimmerte Schildkröte
kistenkroete_zeigen = true;
// Belagerungsturm
bete_zeigen = true;

// Für Geräte 1mm kleinere Seiten.
gseite = seite - 1;

sideRad = gseite * sqrt(3) / 2;
hoehe = 50 - 3;

// Anzeige

if (schildkroete_zeigen) {
  schildkroete();
}
if (kistenkroete_zeigen) {
  xmove(40) kistenkroete();
}

if (bete_zeigen) {
  xmove(80) bete();
}