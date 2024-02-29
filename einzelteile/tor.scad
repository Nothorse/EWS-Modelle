

module tor(tortyp) {
  $fn = 20;
  torbreit = seite - 1;
  torhoch = torbreit * 1.8;
  intersection() {
    _torkorpus(torbreit, torhoch);
    if (tortyp == 1) {
      move(x = seite / 2 - 1, y = -3) scale(v = [ 1.2, 1.2, 1.2 ])
          _toroeffnung();
    } else {
      move(x = seite / 2 - 1, y = -3) scale(v = [ 0.9, 1, 0.9 ]) _toroeffnung();
    }
  }
  if (tortyp == 1) {
    move(x = torbreit - 3.5, z = 1.5) cube([ 2, 1, torhoch - 3.2 ]);
    move(x = torbreit - 1.5, y = -1, z = torhoch / 2) difference() {
      cylinder(torhoch - 3.2, r = 2, center = true);
      cylinder(torhoch * 2, r = .9, center = true);
    }
  } else {
    move(x = -.5, rx = 90, y = 2, z = 2) cube([ torbreit - 1, torhoch - 5, 1 ]);
  }
}

module _torkorpus(torbreit, torhoch) {
  union() {
    difference() {
      cube([ torbreit, 1, torhoch ]);
      for (rille = [1:5]) {
        move(x = rille * 2.5, y = -.8) cube([ .2, 1, torhoch ]);
      }
    }
    for (querbrett = [ torhoch / 3, (torhoch / 3) * 2 ]) {
      move(z = querbrett, y = -.3) cube([ torbreit, 1, 2 ]);
      for (nagel = [1:6])
        move(z = querbrett + 1, y = -.3, x = (nagel * 2) + 1) sphere(d = 1);
    }
  }
}

module _drehtorangeln() {
  $fn = 30;
  torbreit = seite - 1;
  torhoch = torbreit * 1.8;
  move(x = -seite / 2 + 1.5, y = sideRad + 2, rz = 0) {
    difference() {
      union() {
        move(x = -2, y = -2.5) cube([ 3, 2.5, 1.5 ]);
        move(x = 0) cylinder(1.5, r = 2);
        move(x = -2, y = -2.5, z = torhoch - .6) cube([ 3, 2.5, 1.5 ]);
        move(x = 0, z = torhoch - .6) cylinder(1.5, r = 2);
      }
      move(x = 0, z = -4) cylinder(torhoch * 2, r = 1);
    }
  }
}

module drehtordorn() {
  move(rx = -90, z = 1, y = -1) union() {
    cylinder(d = 1.2, 33);
    cylinder(d = 2, 1);
  }
}