#include "sometools.h"


/*
 * Vergleich zweier Strings
 * liefert true 1   = strings sind gleich
 *        false 0   = strings unterschiedlich
 */
int strcicmp(char *str1, char * str2)
{
 int ret = 1;

 while(*str1 && ret)                                  /* solange Zeichen ungleich \0 und beide Strings gleich */
    ret = tolower(*str1++) == tolower(*str2++);       /* vergleiche die beiden Zeichen und speicher ob gleich */

 return ret && (*str1 == *str2);                      /* das letzte Zeichen muss noch mit in die Prüfung gehen */
}



char * extractfilename(char * p)
{
 char * ret = p;
 while(*p)
   {
      if ( *p == PATH_SEP )
         ret = p+1;
      ++p;
   }
 return ret;
}


/*
 * Rundet eine Zahl auf zwei Nachkommastellen
 *
 */
double RoundTwo(double num)
{
 double tmp = num;
 
 tmp *= 100;                                          /* berchne erstmal abgerundete Zahl */
 tmp = floor(tmp);
 tmp /= 100;
 
 if ( (num - tmp) >= .005)                            /* wenn Nachkommstellen groß genug */
   tmp += 0.01;                                       /* aufrunden */

 return tmp;
}