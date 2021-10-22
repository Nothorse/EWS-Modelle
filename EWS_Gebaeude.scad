use <MCAD/regular_shapes.scad>
use <lib/math.scad>
use <lib/transforms.scad>
use <commonfunctions.scad>
/**
 * Gebäude für EWS
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */

// Setup für Customizer
/* [Maße] */
// Höhe in mm
hoehe = 50;
// Seitenbreite
seite = 18.5;
/* [Gebäudeauswahl] */
// Turm
turm_zeigen = true;
// Bergfried oberer Turmteil
bergfried_zeigen = true;
// Tor mit Dorn
tor_zeigen = true;
// Zinnenkranz
zinnen_zeigen = true;
// Einzelmauer
Mauer_zeigen = true;
/* [Tore und Durchgänge] */
// Tore für Turm (Erdgeschoss BF) (Windrichtungen) z.B. [1]
tore = [];
// Durchgänge im Erdgeschoß (Windrichtungen)
durchgaenge = [];
// Durchgänge im Obergeschoß eines Bergfrieds (Windrichtungen)  z.B. [3,5]
bf_durchgaenge = [];
// Bei Zinnenkranz ausgesparte Seiten z.B. [3,5]
zinnen_durchgaenge = [];
/* [Dekoration] */
// Mauerstruktur
mauerwerk = true;
// Strukturauswahl
mauer_map = "mauer2.png"; //  ["mauer1.png":"Grob", "mauer2.png":"Mittel", "mauer3.png":"Fein", "mauer4.png":"Bögen"]
// Gesimse und andere Mauerfeatures
gesimse = 0; // [0:Kein Gesims,1:Rechtwinklig,2:Faschen]
// Zinnenform
zinnentyp = 1; // [1:Rechteck, 2:Schwalbenschwanz, 3:Bogen]
// Fenstertyp
fenster = 1; // [1:"schmal", 2:"doppelbogen"]
// Tortyp
tortyp = 1; // [1:"Drehangel", 2:"Offen"]
// Torform
torform = 1; // [1:"8eck oben", 2:"Spitzbogen"]

// Berechnete größen

sideRad = seite * sqrt(3)/2;


function flatten(l) = [ for (a = l) for (b = a) b ];

function intersect(l) = [ for (c = l) for (d = c) d ];

x = intersect([[1:2],[1,3]]);
echo(x);

if (zinnen_zeigen) {
  move(z=1) zinnenkranz(zinnen_durchgaenge, zinnentyp);
}

if (turm_zeigen) {
  move(x=sideRad*3) turm(tore, durchgaenge, mauerwerk, fenster, torform);
}

if (bergfried_zeigen) {
  move(x=sideRad*3,y=sideRad*3, z=2) bergfried(bf_durchgaenge, mauerwerk);
}

if (tor_zeigen) {
  move(x=-sideRad*3,z=1, rx=-90)  tor(tortyp);
  if (tortyp == "1") move(x=-(sideRad*2)+4) drehtordorn();
}

if (Mauer_zeigen) {
  move(y=sideRad*3) solomauer(mauerwerk);
}

module turm(turmtore, turmdurchgaenge, struktur, fenster, torform) {
  alle_durch =  flatten([turmdurchgaenge, turmtore]);
  difference() {
    // turmkörper
    union() {
      hexagon_tube(hoehe, seite, 1);
      hexagon_prism(2,seite);
      for (i = turmtore) {
        //wallmove(0, sideRad-.1, 0, i)
        //tor();
        if (tortyp == 1) {
          wallmove(richtung=i,y=.4, x=.5) _drehtorangeln();
        }
      }
      if (struktur) {
        for (i = [1:6]) {
          move(rz=i*60)
          move(x=-sideRad/2-1,y=-sideRad+0.1, rx=90) {
            _mauerstruktur();
          }
        }
      }
      if (gesimse == 1) {
        for (i = [1:6]) {
          if (!in_list(i, alle_durch))
          move(rz=i*60)
          move(x=-1,y=sideRad)
          cube ([1,.5,hoehe-3]);
          move(rz=i*60)
          move(x=seite/2-1,y=sideRad)
          cube ([1,.5,hoehe-3]);
          move(rz=i*60)
          move(x=-seite/2,y=sideRad)
          cube ([1,.5,hoehe-3]);
          move(rz=i*60)
          move(x=0,y=sideRad+.15, z=(hoehe*2/3 + hoehe/6)-3)
          cube ([seite,.7,hoehe/3],center=true);
        }
        for (i = alle_durch) {
          wallmove(0, sideRad+.5, 1, i)
            move(x=-.4 ,z=18,rx=90) linear_extrude(1) shell2d(1) _toroeffnung2d(torform, "fa");
        }
      }
    }
    for (i = alle_durch) {
      wallmove(0, sideRad-2, 1, i)
       _toroeffnung();
    }
    for (i = [1:6]) {
      wallmove(0, sideRad-2, 7, i)
       _fenster(fenster);
    }
    //move(0,0,1) cylinder_tube(5, sideRad-2, seite);
  }
}

module zinnenkranz(durchbrueche, typ) {
  move(0, 0, -1) {
    difference() {
      union() {
      difference() {
        translate([0,0,0]) hexagon_tube(12,seite +3.5,2);
        _zinnen(typ);
      }
      move(0,0,3) hexagon_prism(1, seite +1.5);
      move(0,0,0) hexagon_prism(3, seite -1.2);
      }
      for(i = durchbrueche) {
        rotate([0,0,i*60]) translate([0, sideRad+2.2, 4]) cube([seite*2,4,seite +1.5], center = true);
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
  torbreit = seite - seite/5;
  torhoch = hoehe/3 - (hoehe/30);
  rundungdm = torbreit/2 -torbreit/10;
  //
  translate([0,5,rundungdm*4]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(6) {
          _toroeffnung2d(1, "auf");
        }
      }
    }
  }
}

module _spitzbogen() {
  torhoch = hoehe/3 - (hoehe/30);
  translate([-.5,5,torhoch+3]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(6) {
          _toroeffnung2d(2, "auf");
        }
      }
    }
  }
}

module _toroeffnung2d(type, woher) {
  echo("fasche1", woher, type);
  if (type == 1) {
    $fn = 8;
    torbreit = seite - seite/5;
    rundungdm = torbreit/2 -torbreit/10;
    move(y=-1)rotate([0,0,135]) circle(rundungdm-1);
    move(0, -rundungdm*2) square([rundungdm*1.8, (rundungdm*4)-3], center=true);
  }
  if (type == 2) {
    $fn=20;
    echo("fasche2", woher);
    torbreit = seite - seite/3;
    torhoch = hoehe/3 - (hoehe/30);
    difference() {
      move(y=-4) ellipse(torbreit, torbreit*2);
      move(y=-torhoch-3) square(size=[torbreit, 5], center=true);
    }
    move(y=-10) square(size=[torbreit, torbreit], center=true);
  }
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
  fensterbreit = seite/5;
  fensterhoch = hoehe;
  fensterdm = fensterbreit/2 -fensterbreit/10;
  //
  translate([0,5,fensterdm*14]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(6) {
          circle(fensterdm);
          move(0, -fensterdm*4) square([fensterdm*1.8, (fensterdm*10)-3], center=true);
        }
      }
    }
  }
}

module _doppelfenster() {
  $fn=20;
  fensterbreit = seite/2 -5;
  fensterhoch = hoehe/3 -7;
  translate([(seite/2-5.5),5,((hoehe/4)*3)+1]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(6) {
          move(y=-6) ellipse(fensterbreit, fensterbreit*2);
          move(y=-10) square(size=[fensterbreit, fensterbreit+3], center=true);
        }
      }
    }
  }
  translate([-(seite/2-4.5),5,((hoehe/4)*3)+1]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(6) {
          move(y=-6) ellipse(fensterbreit, fensterbreit*2);
          move(y=-10) square(size=[fensterbreit, fensterbreit+3], center=true);
        }
      }
    }
  }

}

module _mauerstruktur() {
  scale([seite / 72, (hoehe-2) / 108, 0.9/ 256])
  surface(file = mauer_map, convexity = 3);
}


module solomauer(struktur) {
  intersection() {
    difference() {
      union() {
        cube([seite, 1, hoehe]);
        if (struktur) {
          move(x=0,y=-0.1, rx=90) {
            _mauerstruktur();
          }
        }
        cube([seite, sideRad-5, 2]);
      }
      move(z=7, x=seite/2) _fenster();
      move(x=-1,y=-2, z=hoehe-3.6) cube([seite+5, 4, 4]);
    }
    move(y=4, x=seite/2) triangle_prism(hoehe+10,seite/3*2);
  }
  move(y=-1, x=1) cube([seite-2,1,1]);
}


module _zinnen(typ) {
  zinB = seite/8;
  zinVers = seite/6 * 1.8;
  echo("typ:", typ);
  for (i = [1:6]) {
    rotate([0,0,i*60]) {
      color("Blue") {
        translate([0, sideRad, 7]) {
          translate([-zinVers,0,5]) cube([zinB,7,12], center= true);
          translate([0,0,5]) cube([zinB,7,12], center= true);
          translate([zinVers,0,5]) cube([zinB,7,12], center= true);
          if (typ == 2) {
            move(x=0.5,y=4) _schwalbenschwanz();
            move(x=zinVers+.5,y=4) _schwalbenschwanz();
            move(x=-zinVers+.5,y=4) _schwalbenschwanz();
            move(x=-(zinVers)*2,y=4) _schwalbenschwanz();
          }
          if (typ == 3) {
            move(rx=90,y=4, z=6) linear_extrude(4) ellipse(seite+4, 8);
          }
        }
      }
    }
  }
}

module _schwalbenschwanz() {
  $fn=20;
  move(z=3,rx=90)
  linear_extrude(4) {
    difference() {
      move(x=0) square(4.5);
      union() {
        move() circle(d=4);
        move(x=4.5) circle(d=4);
      }
    }
  }
}

module tor(tortyp) {
  $fn = 20;
  torbreit = seite-1;
  torhoch = torbreit*1.8;
  intersection() {
    _torkorpus(torbreit, torhoch);
    if (tortyp == 1) {
      move(x=seite/2-1,y=-3) scale(v=[1.2,1.2,1.2]) _toroeffnung();
    } else {
      move(x=seite/2-1,y=-3) scale(v=[0.9,1,0.9]) _toroeffnung();
    }
  }
  if (tortyp == 1) {
    move(x=torbreit-3.5, z=1.5) cube([2,1,torhoch-3.2]);
    move(x=torbreit-1.5, y=-1, z=torhoch/2)
    difference() {
    cylinder(torhoch-3.2, r=2, center=true);
    cylinder(torhoch*2, r=.9, center = true);
    }
  } else {
    move(x=-.5,rx=90,y=2, z=2) cube([torbreit-1, torhoch-5, 1]);
  }
}

module _torkorpus(torbreit, torhoch) {
  union() {
    difference() {
      cube([torbreit, 1, torhoch]);
      for(rille = [1:5]) {
        move(x=rille*2.5,y=-.8) cube([.2,1,torhoch]);
      }
    }
    for(querbrett = [torhoch/3, (torhoch/3)*2]) {
      move(z=querbrett, y=-.3) cube([torbreit, 1, 2]);
      for (nagel = [1:6])
      move(z=querbrett+1, y=-.3, x=(nagel*2)+1) sphere(d=1);
    }
  }
}

module _drehtorangeln() {
  $fn = 30;
  torbreit = seite-1;
  torhoch = torbreit*1.8;
  move(x=-seite/2+1.5,y=sideRad+2,rz=0) {
    difference() {
      union() {
        move(x=-2,y=-2.5) cube([3,2.5,1.5]);
        move(x=0) cylinder(1.5, r=2);
        move(x=-2,y=-2.5, z=torhoch-.6) cube([3,2.5,1.5]);
        move(x=0, z=torhoch-.6) cylinder(1.5, r=2);
      }
      move(x=0, z=-4) cylinder(torhoch * 2, r=1);
    }
  }
}

module drehtordorn() {
  move(rx=-90, z=1, y=-1)
  union() {
    cylinder(d=1.2, 33);
    cylinder(d=2, 1);
  }
}

module bergfried(durchgaenge, struktur) {
  turm([], durchgaenge, struktur);
  move(0,0,-2.5) hexagon_prism(3, seite -1.2);
}
