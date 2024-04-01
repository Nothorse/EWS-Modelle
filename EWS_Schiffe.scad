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
//_schiffbasis(seite, 9);
langschiff(reling = 12);
// halbschiff(reling = 15);
// rumpf(18.5, 10);
//   _addNegativeSurface(seite = 18.5);
//_test(seite = 18.5, reling = 15, dicke = 1);
//_reling(18.5, 15, 1);

module rumpf(seite = 18.5, reling = 15) {
  hexr = hexradius(seite);
  halbschiff(seite, reling);
  translate([ hexr * 2, 0, 0 ]) rotate([ 0, 0, 180 ]) halbschiff(seite, reling);
}

module _rundung(seite, dm = 7) {
  hull() {
    _rundeck(seite, dm, 1);
    _rundeck(seite, dm, 2);
    _rundeck(seite, dm, 3);
    _rundeck(seite, dm, 4);
  }
}

module _teilrund(l = 18.5, dm = 4) {
  lang = l + 5;
  difference() {
    rotate([ 90, 0, 0 ]) cylinder(lang, r = dm, center = true);
    translate([ 0, 0, dm / 2 ]) cube([ dm * 2, lang, dm ], center = true);
  }
}

module _rundeck(seite = 18.5, dm = 4, r = 1) {
  distanz = hexradius(seite) - dm;
  intersection() {
    wallmove(x = distanz, richtung = r % 6) _teilrund(seite, dm);
    wallmove(x = distanz, richtung = (r + 1) % 6) _teilrund(seite, dm);
  }
}

module _reling_mit_struktur(seite, reling, dicke = 1) {
  union() {
    _relingstruktur(seite, reling, dicke);
    _reling(seite - .15, reling, dicke - .15);
  }
}

module _reling(seite, reling, dicke = 1) {
  color("#cc9900") linear_extrude(reling) {
    translate([ 0, 0, 0 ]) rotate([ 0, 0, -90 ]) difference() {
      circle(seite, $fn = 6);
      circle(seite - dicke, $fn = 6);
      translate([ 0, hexradius(seite) + dicke, 0 ])
          square([ seite + 2, 2 ], center = true);
      polygon([[seite - dicke, 0], [-seite + dicke, 0],
               [0, hexradius(seite - dicke) * 2]]);
    }
  }
}

module _relingstruktur(seite, reling, dicke) {
  difference() {
    _reling(seite, reling, dicke);
    for (i = [1:2:reling]) {
      translate([ 0, 0, i + .2 ]) cube([ 40, 40, .3 ], center = true);
    }
  }
}

module halbschiff(seite = 18.5, reling = 15, rumpfhoehe = 10) {
  hexr = hexradius(seite);
  rdm = rumpfhoehe / 2;
  union() {
    color("#996633") hull() {
      linear_extrude(1) #union() {
        scale([ 1.3, 1 ]) circle(seite / 2);
        polygon([
          [ 0, -seite / 2 ], [ 0, seite / 2 ], [ hexr, seite / 2 ],
          [ hexr, -seite / 2 ]
        ]);
      }
      translate([ 0, 0, rumpfhoehe ]) _rundung(seite, rdm);
      translate([ 0, 0, rumpfhoehe ]) linear_extrude(.001) {
        translate([ 0, 0, 0 ]) rotate([ 0, 0, 30 ]) { circle(seite, $fn = 6); }
      }
    }
    rotate([ 0, 0, 90 ]) translate([ 0, 0, rumpfhoehe ])
        _addNegativeSurface(seite = 18.5);
    translate([ 0, 0, rumpfhoehe ])
        _reling_mit_struktur(seite = seite, reling = reling, dicke = 1);
    linear_extrude(.5) {
      translate([ 0, 0, 0 ]) rotate([ 0, 0, 30 ]) { circle(seite, $fn = 6); }
    }
  }
}

module langschiff(seite = 18.5, reling = 15) {
  mx = hexradius(seite) / 2;
  my = seite * 1.5;
  mz = seite * .75 + 10 + (reling / 2);
  difference() {
    rumpf(seite, reling);
    translate([ mx, my, mz ]) rotate([90]) linear_extrude(60) scale([ 1, .75 ])
        hull() {
      circle(seite);
      translate([ seite + 5, 0, 0 ]) circle(seite);
    }
  }
}

module _addNegativeSurface(seite) {
  difference() {
    scale([ seite / 256, seite / 256, 0.9 / 256 ])
        surface("holz.png", invert = false, convexity = 3, center = true);
    linear_extrude(20, center = true) {
      difference() {
        square(100, center = true);
        circle(seite, $fn = 6);
      }
    }
  }
}