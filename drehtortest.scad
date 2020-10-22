use <neuturm.scad>
hoehe = 50;
radius = 18.5;
seite = 18.5;
tore = [4];
durchgaenge = [];
$fn=50;

move(rx=-90, z=1, y=-1)
union() {
  cylinder(d=1.3, 33);
  cylinder(d=2, 1);
}

move(x=5, y=.5, z=1, rx=-90) drehtor();
//move(x=seite+5, rx=90) einschub();

module schiebetor() {
  torbreit = seite;
  torhoch = torbreit*1.8;
  color("Green") {
    move(0,0.5, torhoch/2) difference() {
      cube([torbreit, 3.2, torhoch], center=true);
      move(0,-0.4,2) cube([torbreit-3, 1.3, torhoch + 3], center=true);
    }
  }
}


module einschub() {
  torbreit = seite;
  torhoch = torbreit*1.8;
  cube([torbreit-3.2, 1, torhoch + 3]);
  cube([torbreit-3.2,3,4]);
}

module drehtor() {
  $fn = 50;
  torbreit = seite-1;
  torhoch = torbreit*1.8;
  intersection() {
    union() {
      cube([torbreit-3.5, 1, torhoch]);
      move(rx=90) scale([torbreit / 512, (torhoch) / 512, 0.9/ 256])
      surface(file = "holz.png", convexity = 3);
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
  difference() {
    union() {
      move(x=-0.5, y=-.5) cube([3,2.5,1.5]);
      move(x=1.5) cylinder(1.5, r=2);
      move(x=-0.5,y=-.5, z=torhoch-.6) cube([3,2.5,1.5]);
      move(x=1.5, z=torhoch-.6) cylinder(1.5, r=2);
    }
    move(x=1.5, z=0.2) cylinder(torhoch * 2, r=1);
  }

}
