/**
 * Belagerungsturm.
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */
use <geraetebasis.scad>

// Module: bete (BT)
//
//   Belagerungsturm
//
module bete(gseite = 18.5) {
  
  schief = rands(min = -3, max = 3, value_count = 60);
  difference() {
    _bretterwaende([ 1, 3, 4, 5, 6 ], schief);
    wallmove(x = 0, y = -sideRad * 3, z = 1, richtung = 3.5)
        cube([ sideRad + 3, gseite * 10, hoehe - 17 ]);
    wallmove(x = 8, y = -sideRad * 3, z = hoehe - 17, richtung = 3.5)
        cube([ sideRad - 4, gseite * 10, 20 ]);
  }
  wallmove(y = 7, z = hoehe - 8, richtung = 2) union() {
    // cube([gseite*1.5,1,16], center=true);
    move(x = -gseite * .75, z = 4) nagelbalken(gseite * 1.5, 0);
    move(x = -gseite * .75, z = -7) nagelbalken(gseite * 1.5, 0);
  }
}