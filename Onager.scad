module move(x=0,y=0,z=0,rx=0,ry=0,rz=0)
{ translate([x,y,z])rotate([rx,ry,rz]) children(); }

$fn=50;
laenge = 12;
breite =7;
cube([2,laenge,1.5]);
translate([breite-1,0,0])cube([2,laenge,1.5]);
translate([0.5,0,0])cube([breite,2,1]);
translate([0.5,laenge -2,0])cube([breite,2,1]);

// Armständer
move(y=laenge/2-.4,z=7.9,ry= 90) cylinder(breite+1, d=1.5);
stuetze();
move(x=breite-.5) stuetze();

move (x=breite/2) trebuchet_arm();



module trebuchet_arm() {
  difference() {
  move(rx=35, z=4, y=1) cube([1.5,15.3, 1.5]);  
    move(rx=35, x=0.75, z=14.5, y=laenge+.4)  sphere(d=3);
  }
  #move(ry=-90, z=1, y=-1.5, x=.1) linear_extrude(1.5) polygon(
  [
    [0,.5],
    [4.5,1.5],
    [4.5,3.5],
    [0,4.5]
  ]
  );
  move(ry=-90, z=1, y=-1.5, x=2.9) linear_extrude(1.5) polygon(
  [
    [0,.5],
    [4.5,1.5],
    [4.5,3.5],
    [0,4.5]
  ]
  );
//  move(y=laenge+.7, z=10, x=.75) cylinder(3,d=1);
  difference() {
  move(y=laenge+.7, z=14, x=.75) sphere(d=4);
  move(rx=35, x=-2, z=12.5, y=laenge-1.5)  cube([5,5,5]);
     move(rx=35, x=0.75, z=14.5, y=laenge+.4)  sphere(d=3);
 }
}




module wurfarm() {
union () {
cube([1,laenge,1]);
difference() {
move(x=.5, y=laenge -.5, z=1) sphere(2);
move(x=1,y=laenge -.5, z=2)  cube([5,5,2], center = true);
}
}

}

module stuetze() {
  move(y=laenge-3, x=0, rx=30) cube([1.5,1.5,8]);
  move(y=1, x=0, rx=-30, z=1) cube([1.5,1.5,8]);
}