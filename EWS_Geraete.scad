use <MCAD/regular_shapes.scad>
//$fn=50;
seite = 18.5;
basishoehe = 50;
hoehe = 50-3;

sideRad = seite * sqrt(3)/2;


module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }

module wallmove(x=0, y=0, z=0, richtung=0) {
  rotate([0,0,richtung*60]) translate([x,y,z]) children();
}

/* module kistenkroete() {
  difference() {
    union() {
      difference() {
      hexagon_tube(hoehe, seite,1);
        for (i = [1,3,4,6]) {
          for (j = [1:5]) {
            wallmove(y=sideRad-1.5, x=(seite/2) - seite/5*j, z=0, richtung=i) cube([.2,1.7,hoehe]);
          }
        }
      }
      hexagon_prism(1,seite);
      move(z=hoehe -1) hexagon_prism(1,seite);
      move(z=-2)
      for (i = [1,3,4,6]) {
        wallmove(y=sideRad-1.2,x=-seite/2, z=hoehe-2.5, richtung=i) cube([seite,1.4,4]);
        wallmove(y=sideRad-1.2,x=-seite/2, z=hoehe/2, richtung=i) cube([seite,1.4,3]);
        wallmove(y=sideRad-1.2,x=-seite/2, z=2.5, richtung=i) cube([seite,1.4,4]);
        // schrägbalken
        wallmove(y=sideRad-1.2,x=-4.5, z=hoehe/2+1, richtung=i) move(ry=-60) cube([seite*1.4,1.4,4]);
        wallmove(y=sideRad-1.2,x=-4.5, z=3.9, richtung=i) move(ry=-60) cube([seite*1.4,1.4,4]);
        for (j = [1:5]) {
          union() {
            wallmove(y=sideRad-.5, x=(seite/2) - seite/5*j + seite/10, z=hoehe-1, richtung=i) sphere([.4]);
            if (j>1 && j<5) wallmove(y=sideRad-.5, x=(seite/2) - seite/5*j + seite/10, z=hoehe-((hoehe/8)*(j-1)), richtung=i) sphere([.4]);
            wallmove(y=sideRad-.5, x=(seite/2) - seite/5*j + seite/10, z=hoehe/2+1.5, richtung=i) sphere([.4]);
            if (j>1 && j<5) wallmove(y=sideRad-.5, x=(seite/2) - seite/5*j + seite/10, z=hoehe/2-((hoehe/8)*(j-1.5)), richtung=i) sphere([.4]);
            wallmove(y=sideRad-.5, x=(seite/2) - seite/5*j + seite/10, z=hoehe/2-((hoehe/10)*4), richtung=i) sphere([.4]);
          }
        }
      }
    }
    wallmove(y=sideRad-1, x=-seite/2-1, z=-1, richtung=2) cube([seite+4,3,hoehe+2]);
    wallmove(y=sideRad-1, x=-seite/2-1, z=-1, richtung=5) cube([seite+4,3,hoehe+2]);
  }
} */

module schildkroete() {
  schief = rands(min=-3,max=3,value_count=60);
  difference() {
    union() {
      hexagon_tube(hoehe, seite,1);
      hexagon_prism(1,seite);
      move(z=hoehe -1) hexagon_prism(1,seite);
    }
    for (i = [1,3,4,6]) {
      bretterschlitze([1:5], schief, i);
    }
    wallmove(x=-sideRad*1.5, y=-seite/2,z=1,richtung=3.5) cube([sideRad*4,seite, hoehe-2]);
  }
  for (i=[1,3,4,6]) {
    _bretterwand(schief, i);
  }

}

module bete() {
  schief = rands(min=-3,max=3,value_count=60);
  difference() {
    _bretterwaende([1,3,4,5,6]);
    wallmove(x=0, y=-sideRad*3,z=1,richtung=3.5) cube([sideRad+3,seite*10, hoehe-17]);
    wallmove(x=8, y=-sideRad*3,z=hoehe-17,richtung=3.5) cube([sideRad-4,seite*10, 20]);
  }
  wallmove(y=7, z=hoehe-8, richtung=2) union() {
    //cube([seite*1.5,1,16], center=true);
    move(x=-seite*.75, z=4) nagelbalken(seite*1.5, 0);
    move(x=-seite*.75, z=-7) nagelbalken(seite*1.5, 0);
  }

}

module _bretterwaende(seiten, schief) {
  difference() {
    union() {
      hexagon_tube(hoehe, seite,1);
      hexagon_prism(1,seite);
      move(z=hoehe -12) hexagon_prism(1,seite);
    }
    for (i = seiten) {
      bretterschlitze([1:5], schief, i);
    }

  }
  for (i=seiten) {
    _querbalken(schief, i);
  }
}


module _querbalken(schief, windrichtung) {
  wallmove(y=sideRad-1, x=-seite/2, z=hoehe-4.5, richtung=windrichtung) nagelbalken(seite,0);
  wallmove(y=sideRad-1, x=-seite/2, z=hoehe/3, richtung=windrichtung) nagelbalken(seite,schief[20+windrichtung]);
  wallmove(y=sideRad-1, x=-seite/2, z=(hoehe/3)*2, richtung=windrichtung) nagelbalken(seite,schief[27+windrichtung]);
  wallmove(y=sideRad-1, x=-seite/2, z=1, richtung=windrichtung) nagelbalken(seite,0);

}

module bretterschlitze(menge, schief, windrichtung) {
  for (j = menge) {
    wallmove(y=sideRad-1.5, x=(seite/2) - seite/5*j, z=0, richtung=windrichtung) move(ry=schief[j]/2) cube([.2,1.7,hoehe]);
  }

}

bete();
//nagelbalken(40,0);


module nagelbalken(laenge, winkel) {
  nagelzahl=floor(laenge/4);
  nagelabstand=laenge/(nagelzahl);
  move(ry=winkel) {
    cube([laenge, 1.2, 4]);
    move(x=-nagelabstand/2)
    union() {
      for (i = [1:nagelzahl]) {
        move(x=nagelabstand*i,y=.6, z=2) sphere(r=1.4, $fa=5, $fn=5);
      }
    }
  }
}

module langschiff() {
  difference() {
  _schiffbasis();
  move(z=25)
  hull() {
  move(rx=90) cylinder(r=18, h=60, center=true);
  move(rx=90, x=sideRad*2+3) cylinder(r=18, h=60, center=true);
  }
  }
  move(x=-sideRad, y=-2.5) cube([2,5,20]);
}

module _schiffbasis() {
  difference() {
    union() {
      move(rz=30) union() {
        hexagon_tube(15, seite,1);
        hexagon_prism(1,seite);
      }
      move(x=sideRad, y=-seite/2) cube([3, seite, 15]);
      move(x=sideRad*2+1, rz=30)
      union() {
        hexagon_tube(15, seite,1);
        hexagon_prism(1,seite);
      }
    }
    move(x=sideRad-2, y=-seite/2+0.75, z=1) cube([7, seite-1.25, 15]);
  }
}
