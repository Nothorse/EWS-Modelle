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

// Ausgabevariablen
// Zeige Langschiff
langschiff_zeigen = false;
// Zeige Mast mit Segel
segel_zeigen = false;

$fn = 100;
// Für Geräte 1mm kleinere Seiten.
if (langschiff_zeigen) {
  langschiff(reling = 15, mastloch = true);
}
if (segel_zeigen) {
  mast(seite, 50);
}