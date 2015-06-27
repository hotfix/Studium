/******************************************************************************
 * Uebung 05
 * Bitoperationen
 *           
 * A. Albrant(winf2862) &
 * J.C. Benecke(winf2880)
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include "mengen.h"
#include "sometools.h"

#define  MAX_FILENAME   255
#define  EXTENSION      ".bga"


/*
 * Zaehlt die Bits in der Datei filename und speichert in nullen und einsen
 */
void countbits(char * filename, int * nullen, int * einsen)
{
 FILE    * file;
 int     ch;

 file = fopen(filename, "rb");
 if (file == NULL)
    {
      printf("Fehler beim Öffnen der Datei: %s\n", filename);
      exit(1);
    }
 while ( (ch = fgetc(file) )  >= 0 )            /* lese jeweils ein Zeichen */
    {
      ch = cardinality ( (char) ch );           /* wieviele Bits sind gesetzt ? */
      *einsen += ch;
      *nullen += 8-ch;
    }
 fclose(file);
 return;
}



int ersteByte(int differenz, int flag)
{
 int einsen, i;

 i = differenz % 8;                             /* Differenz des letzten Bytes */
 einsen = flag ? i : 0;                         
 einsen += (8-i) / 2;                           

 return 255 << (8-einsen);                      /* setze alle Bits und schiebe Nullen rein */
}


void schreibeBits(char * filename, int differenz, int flag)
{
 FILE * file;
 int bytes;

 file = fopen(filename, "wb");
 if (file == NULL)
    {
      printf("Fehler beim Öffnen der Datei: %s\n", filename);
      exit(1);
    }

 if (differenz % 8)
   fputc(ersteByte(differenz, flag), file);     /* schreibe erstes Byte */
 bytes = differenz / 8;                         /* wieviele weite Bytes */
 while(bytes)
   {
      fputc(flag ? 255 : 0 , file);             /* fülle mit gesetzten oder leeren Bytes auf */
      --bytes;
   }
 fclose(file);
 return;
}


/*
 * Überprüft ob String "-h" oder "-H" ist
 * 
 * p ist ein Zeiger auf Anfang des Strings
 *           
 * Die Funktion gibt zurück, ob String einer der o. g. ist
 */
int checkparam1 (char * p)
{
 return (strlen(p)==2) && (p[0]=='-') && ( (p[1]=='h') || (p[1]=='H') );
}


/*
 * Gibt die Hilfe aus
 *           
 */
void Hilfe (void)
{
  printf("usage: ueb05 [-h, -H, Datei]\n");
  printf("        -h: Hilfe\n");
}


/*
 * Sorgt für einen Polaritätsausgleich 
 */
int main (int argc, char *argv[])
{
 int nullen=0, einsen=0;
 char str[MAX_FILENAME];


  if (argc != 2)                                /* falsche Parameteranzahl */
    {      
      Hilfe();
      return 1;
    }
  if (checkparam1(argv[1]) != 0)                /* Hilfe gewollt ausgeben(Funktion checkparam aufruf) */
    {
      Hilfe();
      return 0;
    }

  countbits(argv[1], &nullen, &einsen);         /* bits zählen */
  if (nullen == einsen)
   {
      printf("Die Quelldatei ist bereits ausgeglichen!\n");
      exit(0);
   }

  strcpy(str, extractfilename(argv[1]));        
  strcat(str, EXTENSION);
  schreibeBits(str, nullen>einsen ? nullen-einsen : einsen-nullen, nullen>einsen);

  return 0;
}
