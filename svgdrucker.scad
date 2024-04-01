/*
 * Simpler SVG extruder
 */

// [Name der SVG Datei im selben Ordner oder absoluter Pfad]
svg = "datei.svg";

// [Höhe in mm]
hoehe = 1;

// [Skalierfaktor]
skalierfaktor = 1;

// [Element Id]
element = 0;

linear_extrude(height = hoehe, convexity = 10) scale(skalierfaktor)
    import(svg, center = true, dpi = 300, $fn = 50, id = element);