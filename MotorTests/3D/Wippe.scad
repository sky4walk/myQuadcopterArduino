dreieck_hoehe  = 100;
dreieck_breite = 100;
dreieck_abstand = 50;
dreieck_dicke = 5;
dreieck_halterung = 3;
wippe_laenge = 200;
$fn = 128;

module Dreieck(hoehe, breite, tiefe)
{
    points2 = [
        [0, 0],             // Punkt A (0, 0)
        [breite/2, -hoehe], // Punkt B (10, 0)
        [breite, 0]         // Punkt C (5, 8.66)
    ];

    // Dreieck extrudieren
    linear_extrude(tiefe) {
        polygon(points2);
    }
}

difference() {
    union(){
        Dreieck(dreieck_hoehe,dreieck_breite,dreieck_dicke);
        translate([0,0,dreieck_abstand])
            Dreieck(dreieck_hoehe,dreieck_breite,dreieck_dicke);
        cube([dreieck_breite,dreieck_dicke,dreieck_abstand+dreieck_dicke]);
    }
    translate([dreieck_breite/2,-dreieck_hoehe+8*dreieck_halterung,-.1])
        cylinder(r=dreieck_halterung, h=dreieck_abstand+dreieck_dicke+.1);            
}

translate([0,0,-dreieck_abstand])
    cube([wippe_laenge,dreieck_dicke,dreieck_abstand-dreieck_dicke]);
translate([wippe_laenge/2,dreieck_halterung/2,-dreieck_abstand-dreieck_dicke-1])
    cylinder(r=dreieck_halterung, h=dreieck_abstand+dreieck_dicke+.1);
