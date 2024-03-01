/**
 * Allgemeine Funktionen für alle EWS Dateien.
 * TH (T!osh) <th@grendel.at>
 * remix erwünscht
 * module mit _name sind privat
 */

/**
 * Bewegen mit Rotation
 */
module move(x=0,y=0,z=0,rx=0,ry=0,rz=0) { 
   translate([x,y,z])rotate([rx,ry,rz]) children();
}

/**
 * Objekt in einer der Windrichtungen positionieren.
 */
module wallmove(x=0, y=0, z=0, richtung=0) {
   rotate([0,0,richtung*60]) translate([x,y,z]) children();
}
