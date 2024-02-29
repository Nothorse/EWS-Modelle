/**
 * Turm und Bergfried mit verschiedenen Strukturen.
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */

module turm(turmtore, turmdurchgaenge, struktur, fenster, torform) {
  alle_durch = flatten([ turmdurchgaenge, turmtore ]);
  difference() {
    // turmkörper
    union() {
      hexagon_tube(hoehe, seite, 1);
      hexagon_prism(2, seite);
      for (i = turmtore) {
        // wallmove(0, sideRad-.1, 0, i)
        // tor();
        if (tortyp == 1) {
          wallmove(richtung = i, y = .4, x = .5) _drehtorangeln();
        }
      }
      if (struktur) {
        for (i = [1:6]) {
          move(rz = i * 60)
              move(x = -sideRad / 2 - 1, y = -sideRad + 0.1, rx = 90) {
            _mauerstruktur();
          }
        }
      }
      if (gesimse == 1) {
        for (i = [1:6]) {
          if (!in_list(i, alle_durch))
            move(rz = i * 60) move(x = -1, y = sideRad)
                cube([ 1, .5, hoehe - 3 ]);
          move(rz = i * 60) move(x = seite / 2 - 1, y = sideRad)
              cube([ 1, .5, hoehe - 3 ]);
          move(rz = i * 60) move(x = -seite / 2, y = sideRad)
              cube([ 1, .5, hoehe - 3 ]);
          move(rz = i * 60) move(x = 0, y = sideRad + .15,
                                 z = (hoehe * 2 / 3 + hoehe / 6) - 3)
              cube([ seite, .7, hoehe / 3 ], center = true);
        }
        for (i = alle_durch) {
          wallmove(0, sideRad + .5, 1, i) move(x = -.4, z = 18, rx = 90)
              linear_extrude(1) shell2d(1) _toroeffnung2d(torform, "fa");
        }
      }
    }
    for (i = alle_durch) {
      wallmove(0, sideRad - 2, 1, i) _toroeffnung();
    }
    for (i = [1:6]) {
      wallmove(0, sideRad - 2, 7, i) _fenster(fenster);
    }
    // move(0,0,1) cylinder_tube(5, sideRad-2, seite);
  }
}

module bergfried(durchgaenge, struktur) {
  turm([], durchgaenge, struktur);
  move(0, 0, -2.5) hexagon_prism(3, seite - 1.2);
}

// Teilmodule

module _mauerstruktur() {
  scale([ seite / 72, (hoehe - 2) / 108, 0.9 / 256 ])
      surface(file = mauer_map, convexity = 3);
}

module _fenster(fenstertyp) {
  echo(fenstertyp);
  if (fenstertyp == 1) {
    _schmalfenster();
  }
  if (fenstertyp == 2) {
    _doppelfenster();
  }
}

module _schmalfenster() {
  $fn = 8;
  fensterbreit = seite / 5;
  fensterhoch = hoehe;
  fensterdm = fensterbreit / 2 - fensterbreit / 10;
  //
  translate([ 0, 5, fensterdm * 14 ]) {
    union() {
      rotate([ 90, 0, 0 ]) {
        linear_extrude(6) {
          circle(fensterdm);
          move(0, -fensterdm * 4)
              square([ fensterdm * 1.8, (fensterdm * 10) - 3 ], center = true);
        }
      }
    }
  }
}

module _doppelfenster() {
  $fn = 20;
  fensterbreit = seite / 2 - 5;
  fensterhoch = hoehe / 3 - 7;
  translate([ (seite / 2 - 5.5), 5, ((hoehe / 4) * 3) + 1 ]) {
    union() {
      rotate([ 90, 0, 0 ]) {
        linear_extrude(6) {
          move(y = -6) ellipse(fensterbreit, fensterbreit * 2);
          move(y = -10)
              square(size = [ fensterbreit, fensterbreit + 3 ], center = true);
        }
      }
    }
  }
  translate([ -(seite / 2 - 4.5), 5, ((hoehe / 4) * 3) + 1 ]) {
    union() {
      rotate([ 90, 0, 0 ]) {
        linear_extrude(6) {
          move(y = -6) ellipse(fensterbreit, fensterbreit * 2);
          move(y = -10)
              square(size = [ fensterbreit, fensterbreit + 3 ], center = true);
        }
      }
    }
  }
}

module _toroeffnung() {
  if (torform == 1) {
    _torachteck();
  }
  if (torform == 2) {
    _spitzbogen();
  }
}

module _torachteck() {
  torbreit = seite - seite / 5;
  torhoch = hoehe / 3 - (hoehe / 30);
  rundungdm = torbreit / 2 - torbreit / 10;
  //
  translate([ 0, 5, rundungdm * 4 ]) {
    union() {
      rotate([ 90, 0, 0 ]) {
        linear_extrude(6) { _toroeffnung2d(1, "auf"); }
      }
    }
  }
}

module _spitzbogen() {
  torhoch = hoehe / 3 - (hoehe / 30);
  translate([ -.5, 5, torhoch + 3 ]) {
    union() {
      rotate([ 90, 0, 0 ]) {
        linear_extrude(6) { _toroeffnung2d(2, "auf"); }
      }
    }
  }
}

module _toroeffnung2d(type, woher) {
  echo("fasche1", woher, type);
  if (type == 1) {
    $fn = 8;
    torbreit = seite - seite / 5;
    rundungdm = torbreit / 2 - torbreit / 10;
    move(y = -1) rotate([ 0, 0, 135 ]) circle(rundungdm - 1);
    move(0, -rundungdm * 2)
        square([ rundungdm * 1.8, (rundungdm * 4) - 3 ], center = true);
  }
  if (type == 2) {
    $fn = 20;
    echo("fasche2", woher);
    torbreit = seite - seite / 3;
    torhoch = hoehe / 3 - (hoehe / 30);
    difference() {
      move(y = -4) ellipse(torbreit, torbreit * 2);
      move(y = -torhoch - 3) square(size = [ torbreit, 5 ], center = true);
    }
    move(y = -10) square(size = [ torbreit, torbreit ], center = true);
  }
}