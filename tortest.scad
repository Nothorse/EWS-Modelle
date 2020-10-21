use <neuturm.scad>
hoehe = 50;
radius = 18.5;
seite = 18.5;
tore = [4];
durchgaenge = [];

difference() {
union() {
solomauer();
move(x=18.5/2, y=-1.9) schiebetor();
}
move(x=18.5/2, y=-3) toroeffnung();
}

move(x=seite+5, rx=90) einschub();

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
  cube([torbreit-3.4, 1, torhoch + 3]);
  cube([torbreit-3.4,3,4]);
}
