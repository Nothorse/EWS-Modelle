/**
 * Zinnenkranz für Türme und Bergfriede
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */

// Module: zinnenkranz
//
//   Zinnenkranz für Turm
// Arguments:
//
//   durchbrueche = z.B. [1,3] Ausgesparte Seiten um zwei Türme passgenau aneinanderzufügen
//   typ = Zinnentyp [1:Rechteck, 2:Schwalbenschwanz, 3:Bogen]
//   
module zinnenkranz(durchbrueche, typ) {
  move(0, 0, -1) {
    difference() {
      union() {
        difference() {
          translate([ 0, 0, 0 ]) hexagon_tube(12, seite + 3.5, 2);
          _zinnen(typ);
        }
        move(0, 0, 3) hexagon_prism(1, seite + 1.5);
        move(0, 0, 0) hexagon_prism(3, seite - 1.2);
      }
      for (i = durchbrueche) {
        rotate([ 0, 0, i * 60 ]) translate([ 0, sideRad + 2.2, 4 ])
            cube([ seite * 2, 4, seite + 1.5 ], center = true);
      }
    }
  }
}

// Module: _zinnen
//
//   ${2:description
// Arguments:
//   typ = Zinnentyp [1:Rechteck, 2:Schwalbenschwanz, 3:Bogen]
module _zinnen(typ) {
  zinB = seite / 8;
  zinVers = seite / 6 * 1.8;
  echo("typ:", typ);
  for (i = [1:6]) {
    rotate([ 0, 0, i * 60 ]) {
      color("Blue") {
        translate([ 0, sideRad, 7 ]) {
          translate([ -zinVers, 0, 5 ]) cube([ zinB, 7, 12 ], center = true);
          translate([ 0, 0, 5 ]) cube([ zinB, 7, 12 ], center = true);
          translate([ zinVers, 0, 5 ]) cube([ zinB, 7, 12 ], center = true);
          if (typ == 2) {
            move(x = 0.5, y = 4) _schwalbenschwanz();
            move(x = zinVers + .5, y = 4) _schwalbenschwanz();
            move(x = -zinVers + .5, y = 4) _schwalbenschwanz();
            move(x = -(zinVers) * 2, y = 4) _schwalbenschwanz();
          }
          if (typ == 3) {
            move(rx = 90, y = 4, z = 6) linear_extrude(4) ellipse(seite + 4, 8);
          }
        }
      }
    }
  }
}

// Module: _schwalbenschwanz
//
//   differenzmodule für Schwalbenschwanzzinnen
//
module _schwalbenschwanz() {
  $fn = 20;
  move(z = 3, rx = 90) linear_extrude(4) {
    difference() {
      move(x = 0) square(4.5);
      union() {
        move() circle(d = 4);
        move(x = 4.5) circle(d = 4);
      }
    }
  }
}