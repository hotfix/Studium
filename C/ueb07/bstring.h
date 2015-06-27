/* Type-Deklaration fuer BStrings */

#ifndef __BSTRING_H__
#define __BSTRING_H__ 1


typedef char* BSTRING;


/* BString-Funktionen */

/*******************************************************************************
 * bsMake
 * Erzeugt einen neuen BString aus einem null-terminierten String
 *
 * Die Laengenangabe ist inklusive des Speicherbedarfs des Laengen-DWORDs
 *
 * Eingabe: s      = Quellstring (null -terminiert)
 *          maxlen = Anzahl zu reservierender Bytes fuer den BSTRING
 * Ausgabe: erzeugter BSTRING
 *******************************************************************************/
BSTRING bsMake(char* s, int maxlen);

/*******************************************************************************
 * bsFree
 * Gibt den Speicherplatz eines BStrings wieder frei
 *
 * Eingabe: s = freizugebender BSTRING
 * Ausgabe: keine
 *******************************************************************************/
void bsFree(BSTRING s);

/*******************************************************************************
 * bsLen
 * Liefert die Laenge eines BStrings
 *
 * Eingabe: s = BSTRING dessen Laenge berechnet werden soll
 * Ausgabe: Laenge des BSTRINGs
 *******************************************************************************/
int bsLen(BSTRING s);

/*******************************************************************************
 * bsConcat
 * Haengt 2 BStrings hintereinander
 *
 * Eingabe: a = vorderer BSTRING
 *          b = hinterer (anzuhaengender) BSTRING
 * Ausgabe: a = zusammengesetzter BSTRING
 *******************************************************************************/
void bsConcat(BSTRING a, BSTRING b);

/*******************************************************************************
 * bsPrint
 * Gibt einen BString aus
 *
 * Eingabe: s = auszugebender BSTRING
 * Ausgabe: keine
 *******************************************************************************/
void bsPrint(BSTRING s);

/*******************************************************************************
 * bsPrintLn
 * Gibt einen BString gefolgt von einem Zeilenumbruch aus
 *
 * Eingabe: s = auszugebender BSTRING
 * Ausgabe: keine
 *******************************************************************************/
void bsPrintLn(BSTRING s);

/*******************************************************************************
 * bsMid
 * Liefert einen Teilstring des BStrings
 *
 * Startpositionen kleiner als 1 sind ungueltig
 * Werden mehr Zeichen gefordert, als der Hauptstring ab der Startposition
 * enthaelt, so werden nur die verfuegbaren Zeichen als Teilstring
 * zurueckgeliefert
 *
 * Eingabe: src   = Hauptstring (aus dem Zeichen herauskopiert werden)
 *          start = Start-Offset in den String (1 bis bsLen(src))
 *          len   = Anzahl zu kopierender Bytes
 * Ausgabe: dest  = Zielvariable fuer den Teilstring
 *******************************************************************************/
void bsMid(BSTRING src, int start, int len, BSTRING dest);

/*******************************************************************************
 * bsUcase
 * Wandelt einen String in Grossbuchstaben um
 *
 * Eingabe: dest = umzuwandelnder String
 * Ausgabe: dest = umgewandelter String
 *******************************************************************************/
void bsUcase(BSTRING dest);

/*******************************************************************************
 * bsCompare
 * Vergleicht 2 BStrings miteinander
 *
 * Eingabe: s1 = erster zu vergleichender BSTRING
 *          s2 = zweiter zu vergleichender BSTRING
 * Ausgabe: TRUE: BSTRINGs sind gleich, FALSE: BSTRINGs sind ungleich
 *******************************************************************************/
int bsCompare(BSTRING s1, BSTRING s2);

/*******************************************************************************
 * bsInstr
 * Sucht einen Teilstring in einem Hauptstring
 *
 * Ein Leerstring wird immer gefunden, so dass das Ergebnis dann 1 lautet
 *
 * Eingabe: smain = Hauptstring
 *          ssub  = zu suchender BSTRING
 * Ausgabe: 0: Teilstring nicht gefunden, ansonsten Startposition des
            Teilstrings im Hauptstring
 *******************************************************************************/
int bsInstr(BSTRING smain, BSTRING ssub);


#endif
