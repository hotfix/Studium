

# include <stdio.h>
# include <float.h>
# include "flaechenberechnung.h"

/*
__VARIABLENDEKLARATION__
*/

double radius,
  grundseite,
  hoehe,
  seite_a,
  hoehe_trapez,
  seite_c;
int kreiscount=0,
  dreieckcount=0,
  trapezcount=0,
  zaehlschleifenVar=1,
  fehler=999,
  fehler_grundseite=999,
  fehler_seite_a=999,
  fehler_seite_c=999,
  fehler_hoehe_trapez=999,
  fehler_hoehe,
  counter=1,
  kreis_ok=0,
  dreieck_ok=0,
  trapez_ok=0;
char tmp;

/*
Funktion, um zu bestimmen, ob nach dem Parameter "-k" noch ein gö ltiger Zahlenwert kommt
Liefert "0" wenn alles ok ist
Liefert "1" wenn ein Fehler aufgetreten ist
*/
int korrekter_kreis (char **argv)
{
 
 fehler = (sscanf(argv[counter],"%lf%c",&radius,&tmp)==2);
 if ( fehler == 0 && (radius > 0) )
  return 0;
 else
  return 1;
}


/*
Funktion, um zu bestimmen, ob nach dem Parameter "-d" noch 3 gö ltige Zahlenwerte kommen
Liefert "0" wenn alles ok ist
Liefert "1" wenn ein Fehler aufgetreten ist
*/
int korrektes_dreieck (char **argv)
{
 int fehler_grundseite,
 fehler_hoehe;
 
 fehler_grundseite = (sscanf(argv[counter],"%lf%c",&grundseite,&tmp)==2);
 counter++;
 fehler_hoehe = (sscanf(argv[counter],"%lf%c",&hoehe,&tmp)==2);
 if ( (fehler_grundseite == 0) && (fehler_hoehe == 0) && (grundseite > 0) && (hoehe > 0) )
  return 0;
 else
  return 1;
}


/*
Funktion, um zu bestimmen, ob nach dem Parameter "-t" noch zwei gö ltige Zahlenwerte kommen
Liefert "0" wenn alles ok ist
Liefert "1" wenn ein Fehler aufgetreten ist
*/
int korrektes_trapez (char **argv)
{
 int fehler_seite_a,
 fehler_seite_c,
 fehler_hoehe_trapez;
 
 fehler_seite_a = (sscanf(argv[counter],"%lf%c",&seite_a,&tmp)==2);
 counter++;
 fehler_seite_c = (sscanf(argv[counter],"%lf%c",&seite_c,&tmp)==2);
 counter++;
 fehler_hoehe_trapez = (sscanf(argv[counter],"%lf%c",&hoehe_trapez,&tmp)==2);
 if ( (fehler_seite_a==0) && (fehler_seite_c==0) && (fehler_hoehe_trapez==0) 
       && (hoehe_trapez > 0) && (seite_a > 0) && (seite_c > 0) )
  return 0;
 else
  return 1;
}


/*
Funktion, um zu bestimmen, ob die richtigen Buchstaben verwendet wurden
Ruft die weiteren Funktionen der Figuren auf, um die Zahlenwerte dahinter zu testen
Liefert "0" wenn alles ok ist
Liefert "1" wenn ein Fehler aufgetreten ist
*/
int korrekte_eingabe(int argc, char **argv)
{
 while (counter < argc-1)
 {
  switch ( argv[counter][1] )
  {
   case 'k' :
    counter++;
    if ( (korrekter_kreis(argv) ) == 0)
    {
     kreis_ok=0;
     counter++;
    }
    else
    {
     kreis_ok=1;
     return 1;
    }
    break;
  
   case 'd' :
    counter++;
    if ( (korrektes_dreieck(argv) ) == 0)
    {
     dreieck_ok=0;
     counter++;
    }
    else
    {
     dreieck_ok=1;
     return 1;
    }
    break;
      
   case 't' :
    counter++;
    if ( (korrektes_trapez(argv) ) == 0)
    {
     trapez_ok=0;
     counter++;
    }
    else
    {
     trapez_ok=1;
     return 1;
    }
    break;
   default: 
    return 1;
  }
 }
 
 if ( (kreis_ok == 0) && (dreieck_ok == 0) && (trapez_ok == 0) && (argc > 2))
  return 0;
 else
  return 1;
}


/* Hauptprogramm, wo die zur Figur gehoerende Parameter ausgelesen werden. 
   
   Was fö r Funktionalitö ten sind bei dem Abfangen der Fehler getestet:

1.) Man kann nicht -k 5a aufrufen
2.) Man kann nicht -d 1 aufrufen
3.) Man kann nicht -d a aufrufen
4.) Man kann nicht -t a aufrufen
5.) Man kann nicht -t 1 2 aufrufen
6.) Man kann nicht - 1 aufrufen
7.) Man kann nicht " " (Leerstring) aufrufen
8.) Man kann nicht - - aufrufen
   
   In der Funktion Flaechenberechnung werden alle Berechnungen gemacht und die Flaechen anschliessend ausgegeben */


int main (int argc, char **argv)
{ 
 /*
 PRUEFUNG OB ALLE PARAMETER GUELTIG SIND
 */
 if ( korrekte_eingabe(argc, argv) == 0)
 { 
 /*
  WENN ALLE PARAMETER GUELTIG; DANN STARTE DIE BERECHNUNG UND AUSGABE
 */
  while ( zaehlschleifenVar < argc )
  {
 /*
 SO LANGE NOCH PARAMETER GELESEN WERDEN KOENNEN...
 */
   switch ( argv[zaehlschleifenVar][1] )
   {
 /*
 WAEHLE ZWISCHEN...
 */ 
    case 'k' :
 /*
 ...KREIS
 */ 
     zaehlschleifenVar++;
     kreiscount++;
     sscanf(argv[zaehlschleifenVar],"%lf",&radius);
     printf("Kreis%d: %.3f\n",kreiscount, flaecheKreis(radius));
     zaehlschleifenVar++;
    break;

    case 'd' :
 /*
 ...DREIECK
 */ 
     dreieckcount++;
     zaehlschleifenVar++;
     sscanf(argv[zaehlschleifenVar],"%lf",&grundseite);
     zaehlschleifenVar++;
     sscanf(argv[zaehlschleifenVar],"%lf",&hoehe);
     zaehlschleifenVar++;
     printf("Dreieck%d: %.3f\n", dreieckcount, flaecheDreieck(grundseite,hoehe));
    break;

    case 't' :
 /*
 ... UND TRAPEZ
 */ 
     trapezcount++;
     zaehlschleifenVar++;
     sscanf(argv[zaehlschleifenVar],"%lf",&hoehe);
     zaehlschleifenVar++;
     sscanf(argv[zaehlschleifenVar],"%lf",&seite_a);
     zaehlschleifenVar++;
     sscanf(argv[zaehlschleifenVar],"%lf",&seite_c);
     zaehlschleifenVar++;
     printf("Trapez%d: %.3f \n", trapezcount, flaecheTrapez(hoehe,seite_a,seite_c));
    break;
   }
  }
  return 0;
 }
 else
 /*
 SOLLTE EINE FALSCHE EINGABE GETAETIGT WORDEN SEIN,
 GEBE DIE HILFE AUS UND BEENDE MIT RETURNCODE 1
 */
 {
  printf("Usage: ueb03 [-k <r> | -d <g> <h> | -t <h> <a> <c>]\n");
  return 1;
 }
}