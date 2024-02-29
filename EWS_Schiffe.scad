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

// Für Geräte 1mm kleinere Seiten.
gseite = seite - 1;

sideRad = gseite * sqrt(3) / 2;
hoehe = 50 - 3;
langschiff();

module langschiff() {
  difference() {
    _schiffbasis();
    move(z = 25) hull() {
      move(rx = 90) cylinder(r = 18, h = 60, center = true);
      move(rx = 90, x = sideRad * 2 + 3)
          cylinder(r = 18, h = 60, center = true);
    }
  }
  move(x = -sideRad, y = -2.5) cube([ 2, 5, 20 ]);
}

module _schiffbasis() {
  difference() {
    union() {
      move(rz = 30) union() {
        hexagon_tube(15, seite, 1);
        hexagon_prism(1, seite);
      }
      move(x = sideRad, y = -seite / 2) cube([ 3, seite, 15 ]);
      move(x = sideRad * 2 + 1, rz = 30) union() {
        hexagon_tube(15, seite, 1);
        hexagon_prism(1, seite);
      }
    }
    move(x = sideRad - 2, y = -seite / 2 + 0.75, z = 1)
        cube([ 7, seite - 1.25, 15 ]);
  }
}