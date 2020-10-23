use <MCAD/regular_shapes.scad>

// Setup
// höhe, seite, array durchgänge, array tore
hoehe = 50;
radius = 18.5;
seite = 18.5;
tore = [];
durchgaenge = [3,4];

// Berechnete größen

sideRad = seite * sqrt(3)/2;


module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }

module wallmove(x=0, y=0, z=0, richtung=0) {
  rotate([0,0,richtung*60]) translate([x,y,z]) children();
}

function flatten(l) = [ for (a = l) for (b = a) b ] ;

zinnenkranz();
/* move(30,sideRad+10,1, 0, 0, 0) zinnenkranz();
turm(); */

module turm() {
  difference() {
    // turmkörper
    union() {
      hexagon_tube(hoehe, radius, 1);
      hexagon_prism(2,radius);
      for (i = tore) {
        //wallmove(0, sideRad-.1, 0, i)
        //tor();
        wallmove(richtung=i,y=.4, x=.5) drehtorangeln();
      }
        mauerstruktur();
    }
    for (i = flatten([durchgaenge, tore])) {
      wallmove(0, sideRad-2, 1, i)
       toroeffnung();
    }
    for (i = [1:6]) {
      wallmove(0, sideRad-2, 7, i)
       fenster();
    }
    //move(0,0,1) cylinder_tube(5, sideRad-2, radius);
  }
}

module zinnenkranz() {
move(0, 0, -1)
  difference() {
    union() {
    difference() {
      translate([0,0,0]) hexagon_tube(12,radius +3.5,2);
        zinnen();
    }
    move(0,0,3) hexagon_prism(1, radius +1.5);
    move(0,0,0) hexagon_prism(3, radius -1.2);
    }
    for(i = durchgaenge) {
    rotate([0,0,i*60]) translate([0, sideRad+2.2, 4]) cube([radius*2,4,radius +1.5], center = true);
    }
  }
}

module tor() {
  torbreit = seite;
  torhoch = torbreit*1.8;
  color("Green") {
    move(0,0, torhoch/2) cube([torbreit, 1.2, torhoch], center = true);
    move(0,1, torhoch/2) difference() {
      cube([torbreit, 1.5, torhoch], center=true);
      move(0,0,2) cube([torbreit-3, 1, torhoch + 3], center=true);
    }
  }
}

module toroeffnung() {
  $fn = 8;
  torbreit = seite - seite/5;
  torhoch = hoehe/3 - (hoehe/30);
  rundungdm = torbreit/2 -torbreit/10;
  //
  translate([0,5,rundungdm*4]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(6) {
          circle(rundungdm);
          move(0, -rundungdm*2) square([rundungdm*1.8, (rundungdm*4)-3], center=true);
        }
      }
    }
  }
}

module fenster() {
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

module mauerstruktur() {
  for (i = [1:6]) {
    move(rz=i*60)
    move(x=-sideRad/2-.5,y=-sideRad+0.1, rx=90) {
        scale([radius / 72, (hoehe-2) / 108, 0.9/ 256])
        surface(file = "mauer2.png", convexity = 3);
    }
  }
}


module solomauer() {
  cube([seite, 1, hoehe]);
  move(x=0,y=0, rx=90) {
    scale([radius / 72, (hoehe-2) / 108, 0.9/ 256])
    surface(file = "mauer2.png", convexity = 3);
  }
}


module zinnen() {
  zinB = seite/8;
  zinVers = seite/6 * 1.8;
  echo(zinB);
  for (i = [1:6]) {
    rotate([0,0,i*60]) {
      color("Blue") {
        translate([0, sideRad, 7]) {
          translate([-zinVers,0,5]) cube([zinB,7,12], center= true);
          translate([0,0,5]) cube([zinB,7,12], center= true);
          translate([zinVers,0,5]) cube([zinB,7,12], center= true);
          move(x=0.5,y=4) schwalbenschwanz();
          move(x=zinVers+.5,y=4) schwalbenschwanz();
          move(x=-zinVers+.5,y=4) schwalbenschwanz();
          move(x=-(zinVers)*2,y=4) schwalbenschwanz();
        }
      }
    }
  }
}

module schwalbenschwanz() {
  $fn=50;
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

module drehtor() {
  $fn = 50;
  torbreit = seite-1;
  torhoch = torbreit*1.8;
  intersection() {
    union() {
      difference() {
        cube([torbreit-3.5, 1, torhoch]);
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
    move(x=seite/2-1,y=-3) scale(v=[1.2,1.2,1]) toroeffnung();
  }
  move(x=torbreit-3.5, z=1.5) cube([2,1,torhoch-3.2]);
  move(x=torbreit-1.5, y=-1, z=torhoch/2)
  difference() {
  cylinder(torhoch-3.2, r=2, center=true);
  cylinder(torhoch*2, r=.9, center = true);
  }
}

module drehtorangeln() {
  $fn = 50;
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

module bergfried() {
  turm();
  move(0,0,-2.5) hexagon_prism(3, radius -1.2);
}
