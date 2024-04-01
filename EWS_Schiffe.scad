include <commonfunctions.scad>
include <einzelteile/schiff.scad>
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

$fn = 100;
// Für Geräte 1mm kleinere Seiten.
render() langschiff(reling = 15);
// halbschiff(reling = 15);
// schiffsbasis(18.5, 10);
//   _addNegativeSurface(seite = 18.5);
//_test(seite = 18.5, reling = 15, dicke = 1);
//_reling(18.5, 15, 1);
// _plankenbiegung(seite = 18.5);

/*
 * Rumpf mit Reling ohne Ausschnitt.
 */
module schiffsbasis(seite = 18.5, reling = 15) {
  hexr = hexradius(seite);
  halbschiff(seite, reling);
  translate([ hexr * 2, 0, 0 ]) rotate([ 0, 0, 180 ]) halbschiff(seite, reling);
}

/*
 * Schiffsbasis mit Ausschnitt für Langschiff.
 */
module langschiff(seite = 18.5, reling = 15) {
  mx = hexradius(seite) / 2;
  my = seite * 1.5;
  mz = seite * .75 + 10 + (reling / 2);
  difference() {
    schiffsbasis(seite, reling);
    translate([ mx, my, mz ]) rotate([90]) #linear_extrude(60) scale([ 1, .75 ])
        hull() {
      circle(seite);
      translate([ hexradius(seite), 0, 0 ]) #circle(seite);
    }
  }
}