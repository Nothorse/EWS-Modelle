/**
 * Schildkröte mit grob gezimmerter Struktur
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 * @todo nagelbalken verwenden
 */
use <geraetebasis.scad>

// Module: kistenkroete
//
//   Schildkröte aus zusammengezimmerten Kisten
//
module kistenkroete() {
  difference() {
    union() {
      difference() {
        color("#cc9966") hexagon_tube(hoehe, gseite, 1);
        for (i = [ 1, 3, 4, 6 ]) {
          for (j = [1:5]) {
            wallmove(y = sideRad - 1.5, x = (gseite / 2) - gseite / 5 * j,
                     z = 0, richtung = i) cube([ .2, 1.7, hoehe ]);
          }
        }
      }
      color("#cc9966") hexagon_prism(1, gseite);
      move(z = hoehe - 1) color("#cc9966") hexagon_prism(1, gseite);
      move(z = -2) for (i = [ 1, 3, 4, 6 ]) {
        wallmove(y = sideRad - 1.2, x = -gseite / 2, z = hoehe - 2.5,
                 richtung = i) color("#ac7339") cube([ gseite, 1.4, 4 ]);
        wallmove(y = sideRad - 1.2, x = -gseite / 2, z = hoehe / 2,
                 richtung = i) color("#ac7339") cube([ gseite, 1.4, 3 ]);
        wallmove(y = sideRad - 1.2, x = -gseite / 2, z = 2.5, richtung = i)
            color("#ac7339") cube([ gseite, 1.4, 4 ]);
        // schrägbalken
        wallmove(y = sideRad - 1.2, x = -4.5, z = hoehe / 2 + 1, richtung = i)
            move(ry = -60) color("#ac7339") cube([ gseite * 1.4, 1.4, 4 ]);
        wallmove(y = sideRad - 1.2, x = -4.5, z = 3.9, richtung = i)
            move(ry = -60) color("#ac7339") cube([ gseite * 1.4, 1.4, 4 ]);
        for (j = [1:5]) {
          union() {
            wallmove(y = sideRad - .5,
                     x = (gseite / 2) - gseite / 5 * j + gseite / 10,
                     z = hoehe - 1, richtung = i) sphere([.4]);
            if (j > 1 && j < 5)
              wallmove(y = sideRad - .5,
                       x = (gseite / 2) - gseite / 5 * j + gseite / 10,
                       z = hoehe - ((hoehe / 8) * (j - 1)), richtung = i)
                  sphere([.4]);
            wallmove(y = sideRad - .5,
                     x = (gseite / 2) - gseite / 5 * j + gseite / 10,
                     z = hoehe / 2 + 1.5, richtung = i) sphere([.4]);
            if (j > 1 && j < 5)
              wallmove(y = sideRad - .5,
                       x = (gseite / 2) - gseite / 5 * j + gseite / 10,
                       z = hoehe / 2 - ((hoehe / 8) * (j - 1.5)), richtung = i)
                  sphere([.4]);
            wallmove(y = sideRad - .5,
                     x = (gseite / 2) - gseite / 5 * j + gseite / 10,
                     z = hoehe / 2 - ((hoehe / 10) * 4), richtung = i)
                sphere([.4]);
          }
        }
      }
    }
    wallmove(y = sideRad - 1, x = -gseite / 2 - 1, z = -1, richtung = 2)
        cube([ gseite + 4, 3, hoehe + 2 ]);
    wallmove(y = sideRad - 1, x = -gseite / 2 - 1, z = -1, richtung = 5)
        cube([ gseite + 4, 3, hoehe + 2 ]);
  }
}