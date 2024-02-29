/**
 * Basismodule für Geräte.
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */

module _bretterwaende(seiten, schief) {
  difference() {
    color("#86592d") union() {
      hexagon_tube(hoehe, gseite, 1);
      hexagon_prism(1, gseite);
      move(z = hoehe - 12) hexagon_prism(1, gseite);
    }
    for (i = seiten) {
      bretterschlitze([1:5], schief, i);
    }
  }
  for (i = seiten) {
    color("#ac7339") _querbalken(schief, i);
  }
}

module _querbalken(schief, windrichtung) {
  wallmove(y = sideRad - 1, x = -gseite / 2, z = hoehe - 4.5,
           richtung = windrichtung) nagelbalken(gseite, -1);
  wallmove(y = sideRad - 1, x = -gseite / 2, z = hoehe / 3,
           richtung = windrichtung)
      nagelbalken(gseite, schief[20 + windrichtung]);
  wallmove(y = sideRad - 1, x = -gseite / 2, z = (hoehe / 3) * 2,
           richtung = windrichtung)
      nagelbalken(gseite, schief[27 + windrichtung]);
  wallmove(y = sideRad - 1, x = -gseite / 2, z = 1, richtung = windrichtung)
      nagelbalken(gseite, 0);
}

module bretterschlitze(menge, schief, windrichtung) {
  for (j = menge) {
    wallmove(y = sideRad - 1.5, x = (gseite / 2) - gseite / 5 * j, z = 0,
             richtung = windrichtung) move(ry = schief[j] / 2)
        cube([ .2, 1.7, hoehe ]);
  }
}

module nagelbalken(laenge, winkel) {
  nagelzahl = floor(laenge / 4);
  nagelabstand = laenge / (nagelzahl);
  move(ry = winkel) {
    color("#cc6600") cube([ laenge, 1.2, 4 ]);
    move(x = -nagelabstand / 2) union() {
      for (i = [1:nagelzahl]) {
        move(x = nagelabstand * i, y = .6, z = 2) color("black")
            sphere(r = 1.4, $fa = 5, $fn = 5);
      }
    }
  }
}