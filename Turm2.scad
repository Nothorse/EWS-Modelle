/**
 * Turm für Armageddon, parametrisierbar anpassbar für alle Platten.
 * @type {[type]}
 */
use <MCAD/regular_shapes.scad>


height = 40;
diameter = 22;
durchgang = [2];
tor = [3];

turm(height, diameter);

translate([0,0,22]) {
  color("#0000ff") turm(5, diameter+2.4, 2, true);
}

module turm(height, diameter,raiseFloor=0, zinnen=false) {
  side = diameter/2;
  radToSide = sqrt(3) * side / 2;
  union() {
    for(i = tor) {
      rotate([0, 0, 360-(i * 60)]) {
        difference() {
          union() {
            translate([0, -radToSide+.5, 0]) {
              seitenwand(height, side, zinnen, tor, durchgang);
            }
            translate([0,0,(-height/2)+raiseFloor]) {
              hexagon_prism(1, side);
              boden(side, radToSide);
            }
          }
          if (durchgang && zinnen) {
            cutbreite = side+10;
            translate([0, -radToSide+.5, 0]) {
              rotate([0, 0, 0]) {
              #cube([cutbreite,3, 6], center=true);
            }
          }}
        }
      }
    }
  }
}


module seitenwand(hoehe, breite, zinnen=false, tor=false, durchgang=false) {
  difference() {
    union() {
      cube([breite, 1, hoehe], center=true);
      if (tor && !zinnen) {
        translate([0,0,-hoehe/2]) tor(hoehe, breite);
      }
    }
    if (zinnen) {
      for (i=[-4,-1,2]) {
        translate([i,-2,1]) cube([1.5,3,2]);
      }
    }
    if (tor && !zinnen) {
      toroeffnung(hoehe, breite);
    }
    if (durchgang && !zinnen) {
      toroeffnung(hoehe, breite);
    }
  }
}

module tor(hoehe, breite) {
  color("Red"){
    torbreit = breite - breite/5;
    union() {
      translate([-torbreit/2,-1,0]) {
        cube([torbreit, 2, hoehe/3]);
      }
      difference() {
        translate([-torbreit/2,-2.5,hoehe/3]) {
          cube([torbreit, 3, hoehe/30]);
        }
        translate([-torbreit/2+1,-2,hoehe/3 -1]) {
          cube([torbreit-2, 1, hoehe/10]);
        }
      }
    }
  }
}

module toroeffnung(hoehe, breite) {
  $fn = 50;
  torbreit = breite - breite/5;
  torhoch = hoehe/3 - (hoehe/30);
  rundungdm = torbreit/2 -torbreit/10;
  //
  translate([0,2,-(torhoch)+1]) {
    union() {
      rotate([90,0,0]) {
        linear_extrude(4) {
          circle(rundungdm);
        }
      }
      translate([0,-2,-(torhoch-rundungdm)/2]) {
        cube([rundungdm*2, 4, torhoch-rundungdm], center=true);
      }
    }
  }

}



module boden(side, radToSide) {
  linear_extrude(1){
  polygon([
    [0,0],
    [side, 0],
    [radToSide/2,radToSide]
    ]);
  }
}
