$fn=10;
turm(11, 30);


module turm(breit, hoch) {
  $fn = 6;
  seite2seite = sqrt(3) * breit;
  eck2eck = breit*2;
  echo (seite2seite, eck2eck);
  seite=breit;
  torbreit = breit - (breit/5);
  torhoch = hoch/2;
  boden = 1;
  difference() {
    union() {
      turmkoerper(breit, hoch, boden);
      translate([seite2seite/2 -1,-torbreit/2,0]) {
        tor(torbreit, torhoch +boden);
      }
      rotate([0,0,30]) {
        translate([-breit/2,(-seite2seite/2)+0.2,0]) {
          mauerstruktur(breit, hoch);
        }
      }
      rotate([0,0,90]) {
        translate([-breit/2,(-seite2seite/2)+0.2,0]) {
          mauerstruktur(breit, hoch);
        }
      }
      rotate([0,0,150]) {
        translate([-breit/2,(-seite2seite/2)+0.2,0]) {
          mauerstruktur(breit, hoch);
        }
      }
      rotate([0,0,210]) {
        translate([-breit/2,(-seite2seite/2)+0.2,0]) {
          mauerstruktur(breit, hoch);
        }
      }
      rotate([0,0,270]) {
        translate([-breit/2,(-seite2seite/2)+0.2,0]) {
          mauerstruktur(breit, hoch);
        }
      }
      rotate([0,0,330]) {
        translate([-breit/2,(-seite2seite/2)+0.2,0]) {
          mauerstruktur(breit, hoch);
        }
      }
    }
    translate([seite2seite/2 -2,0,boden]) {
      toroeffnung(torbreit, torhoch);
    }
  }
  // Mauer
}

module turmkoerper(breit, hoch, boden) {
  difference() {
    //surface("mauer.png", convexity=2) {
    linear_extrude(hoch) {
      rotate([0,0,30]) {
      circle(breit);
      }
    }
  //}
    translate([0,0,boden]) {
      linear_extrude(hoch + boden) {
        rotate([0,0,30]) {
          circle(breit - 1);
        }
      }
    }
  }
}

module tor(torbreit, torhoch) {
  color("Red"){
    translate([0,0,0]) {
      difference() {
        union() {
          cube([1.5, torbreit, torhoch]);
          translate([0,0,torhoch]) {
            cube([3, torbreit, torhoch/10]);
          }
        }
        translate([1.5,1,torhoch -2 ]) {
          cube([1, torbreit-2, (torhoch/10)+4]);
        }
    }
  }
}
}

module toroeffnung(torbreit, torhoch) {
  $fn = 50;
  rundungdm = torbreit/2 -torbreit/10;
  translate([0,0,torhoch-rundungdm]) {
    rotate([0, 90, 0]) {
      linear_extrude(4) {
        circle(rundungdm);
      }
    }
    translate([0,-rundungdm,-torhoch + rundungdm]) {
      cube([4, rundungdm*2, torhoch-rundungdm]);
    }
  } 
}


module mauerstruktur(breit, hoch) {
rotate([90,0,0]) {
  mirror([0, 0, 0]) {
    scale([breit / 72, hoch / 108, 1 / 256])
    surface(file = "mauer2.png", convexity = 3);
  }
}


}
