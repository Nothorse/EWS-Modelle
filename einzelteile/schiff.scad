use <BOSL/beziers.scad>;
include <BOSL/constants.scad>;

/*
 * Schiffsbasis mit Ausschnitt für Langschiff.
 */
module langschiff(seite = 18.5, reling = 15, mastloch = false) {
  mx = hexradius(seite) / 2;
  my = seite * 1.5;
  mz = seite * .75 + 10 + (reling / 2);
  difference() {
    schiffsbasis(seite, reling);
    if (mastloch)
      mast(seite, 40, 5, .5);
    translate([ mx, my, mz ]) rotate([90]) linear_extrude(60) scale([ 1, .75 ])
        hull() {
      circle(seite);
      translate([ hexradius(seite), 0, 0 ]) circle(seite);
    }
  }
}

/*
 * Rumpf mit Reling ohne Ausschnitt.
 */
module schiffsbasis(seite = 18.5, reling = 15) {
  hexr = hexradius(seite);
  halbschiff(seite, reling);
  translate([ hexr * 2, 0, 0 ]) rotate([ 0, 0, 180 ]) halbschiff(seite, reling);
  translate([ -hexr + .45, 0, 10 + reling ]) rotate([ 0, 0, 90 ])
      teardrop(d = 7, l = .9, ang = 45, cap_h = 5, align = V_CENTER);
}

/*
 * Basis Schiffshälfte, mit gerundetem Rumpf, deckstrucktur und reling.
 */
module halbschiff(seite = 18.5, reling = 15, rumpfhoehe = 10) {
  union() {
    color("#996633") _rumpf_mit_struktur(seite, rumpfhoehe);
    rotate([ 0, 0, 90 ]) translate([ 0, 0, rumpfhoehe - .07 ])
        _deckplanken_struktur(seite = 18.5);
    translate([ 0, 0, rumpfhoehe ])
        _reling_mit_struktur(seite = seite, reling = reling, dicke = 1);
    linear_extrude(.5) {
      translate([ 0, 0, 0 ]) rotate([ 0, 0, 30 ]) { circle(seite, $fn = 6); }
    }
  }
}

/*
 * Rundung für den Rumpf
 */
module _rundung(seite, dm = 7) {
  hull() {
    _rundeck(seite, dm, 1);
    _rundeck(seite, dm, 2);
    _rundeck(seite, dm, 3);
    _rundeck(seite, dm, 4);
  }
}

/**
 * Rundung unter dem Deck.
 */
module _teilrund(l = 18.5, dm = 4) {
  lang = l + 5;
  difference() {
    rotate([ 90, 0, 0 ]) cylinder(lang, r = dm, center = true);
    translate([ 0, 0, dm / 2 ]) cube([ dm * 2, lang, dm ], center = true);
  }
}

/**
 * Ecken für Rumpfrundungshülle.
 */
module _rundeck(seite = 18.5, dm = 4, r = 1) {
  distanz = hexradius(seite) - dm;
  intersection() {
    wallmove(x = distanz, richtung = r % 6) _teilrund(seite, dm);
    wallmove(x = distanz, richtung = (r + 1) % 6) _teilrund(seite, dm);
  }
}

/**
 * Reling zweimal ineinander, einmal mit Ausschnitt für Planken, innen ohne.
 */
module _reling_mit_struktur(seite, reling, dicke = 1) {
  union() {
    _relingstruktur(seite, reling, dicke);
    _reling(seite - .15, reling, dicke - .15);
  }
}

/**
 * Reling mit Höhe und Dicke und abschnitt für Halbschiff.
 */
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

/**
 * Äussere Hülle Reling mit Durchbrüchen für Plankenstruktur.
 */
module _relingstruktur(seite, reling, dicke) {
  difference() {
    _reling(seite, reling, dicke);
    for (i = [-4:2:reling]) {
      //   translate([ 0, 0, i + .2 ]) cube([ 40, 40, .3 ], center = true);
      translate([ 0, 0, i + .2 ]) _plankenbiegung(seite);
    }
  }
}

/**
 * Rumpf bis zum Deck. Hülle über Sechseck, Rundung und Bodenform.
 */
module _rumpf(seite, rumpfhoehe) {
  hexr = hexradius(seite);
  rdm = rumpfhoehe / 2;
  hull() {
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
}

/**
 * Rumpf mit Plankenausschnitten und kleiner ohne Ausschnitte für Struktur.
 */
module _rumpf_mit_struktur(seite, rumpfhoehe) {
  _rumpf(seite - .15, rumpfhoehe);
  _rumpfstruktur(seite, rumpfhoehe);
}

/*
 * Rumpfhülle mit ausgeschnittentene Plankenprofil.
 */
module _rumpfstruktur(seite, rumpfhoehe) {
  difference() {
    _rumpf(seite, rumpfhoehe);

    for (i = [-4:2:rumpfhoehe]) {
      //   translate([ 0, 0, i + .2 ]) cube([ 40, 40, .3 ], center = true);
      translate([ 0, 0, i + .2 ]) _plankenbiegung(seite = seite);
    }
  }
}

/**
 * Plankenstruktur mit Maske für Sechseck.
 */
module _deckplanken_struktur(seite) {
  difference() {
    render(convexity = 5) scale([ seite / 256, seite / 256, 0.9 / 256 ])
        surface("../holz.png", invert = false, convexity = 5, center = true);
    linear_extrude(20, center = true) {
      difference() {
        square(100, center = true);
        circle(seite, $fn = 6);
      }
    }
  }
}

/*
 * Gebogene Ebenen als Differenz für Planken
 */
module _plankenbiegung(seite) {
  hexr = hexradius(seite);
  bez = [ [ -hexr - 2, 3 ], [ -5, 0 ], [ 5, 0 ], [ hexr - .3, 0 ] ];
  closed = bezier_offset(.4, bez);
  //   trace_bezier(bez = closed, N = 3, size = 1);
  translate([ 0, seite, 0 ]) rotate([ 90, 0, 0 ])
      linear_extrude_bezier(closed, height = hexr * 4, center = true);
}

/*
 * Mast
 */
module mast(seite, hoehe = 40, block = 5, slop = 0) {
  hexr = hexradius(seite);
  mastlang = hoehe + 5;
  translate([ hexr, 0, (hoehe / 2) + 10 + slop ]) union() {
    cylinder(h = mastlang, r = 1.3 + (slop / 2), center = true);
    translate([ 0, 0, -((mastlang / 2)) ])
        cube([ 4 + slop, 4 + slop, block ], center = true);
    segel(seite, hoehe);
  }
}

module segel(seite, hoehe = 40) {
  segelhoehe = hoehe - 15;
  translate([ seite, 0, -10 ]) rotate([ 0, 270, 0 ]) {
    segelpfad(segelbreite = seite * 2, segelhoehe = segelhoehe);
  }
}

module segelpfad(segelbreite, segelhoehe) {
  bez = [
    [ 0, 0 ], [ segelhoehe / 3, 4 ], [ 2 * (segelhoehe / 3), 8 ],
    [ segelhoehe, 0 ]
  ];
  closed = bezier_offset(1.5, bez);

  linear_extrude_bezier(closed, height = segelbreite, splinesteps = 32);
}