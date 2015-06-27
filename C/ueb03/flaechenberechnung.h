/*
C-Uebung03

Flaechenberechnung von Kreisen,Dreiecken und/oder Trapezen

flaechenberechnung.h:definiert die Schnittstellen fuer die Flaechenberechnung
*/


#ifndef __FLAECHENBERECHNUNG_H__
#define __FLAECHENBERECHNUNG__ 1

#define PI 3.1415926536


/* Berechnet die Flaeche eines Kreises
   r ist der Radius des Kreises */
double flaecheKreis(double r);

/* Berechnet die Flaeche eines Dreiecks
   g ist die Grundseite des Dreiecks, h die Hoehe */
double flaecheDreieck(double g, double h);

/* Berechnet die Flaeche eines Trapezes
   h ist die Hoehe des Trapezes, a und c die parallelen Seiten */
double flaecheTrapez(double h, double a, double c);

#endif
