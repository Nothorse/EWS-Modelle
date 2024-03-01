/**
 * Schildkröte mit einfacher Struktur
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */
use <geraetebasis.scad>

// Module: schildkroete
//
//   Schildkröte
//
module schildkroete() {
  schief = rands(min = -3, max = 3, value_count = 60);
  difference() {
    union() {
      hexagon_tube(hoehe, gseite, 1);
      hexagon_prism(1, gseite);
      move(z = hoehe - 1) hexagon_prism(1, gseite);
    }
    for (i = [ 1, 3, 4, 6 ]) {
      bretterschlitze([1:5], schief, i);
    }
    wallmove(x = -sideRad * 1.5, y = -gseite / 2, z = 1, richtung = 3.5)
        cube([ sideRad * 4, gseite, hoehe - 2 ]);
  }
  for (i = [ 1, 3, 4, 6 ]) {
    _bretterwand(schief, i);
  }
}