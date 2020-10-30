use <MCAD/regular_shapes.scad>
$fn=50;
seite = 18.5;
hoehe = 50;

sideRad = seite * sqrt(3)/2;


module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }

module wallmove(x=0, y=0, z=0, richtung=0) {
  rotate([0,0,richtung*60]) translate([x,y,z]) children();
}


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
