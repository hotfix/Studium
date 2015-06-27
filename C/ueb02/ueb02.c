#include <stdio.h>


/* implementierung der Collatz-Funktion */
/* Rückgabewert = Anzahl der Duchläufe  */
/* oder -1 bei Überlauf                 */
int collatz (int wert) {
	int anzahl = 0;
	
	while (wert > 1) 
	
	{
	
	++anzahl;
		
	if (wert % 2 == 0)
	
	wert /= 2;
	
	else 
	
	wert = (wert * 3) + 1;
	if (wert < 0)
	{
		return -1;
		break;
	}
	
	
	}
	return anzahl;
	
}



/*hauptprogram*/
int main (void) {
	
	char eingabepuffer[100];
	int obergrenze, i, ergebnis, maximum, mwert;
	obergrenze = 0;
	printf ("Obergrenze: ");
	fgets(eingabepuffer,100,stdin);
	sscanf (eingabepuffer,"%d",&obergrenze);
	maximum = 0;
	
	if (obergrenze < 1) 
	{
	printf("Eingabefehler: Die Obergrenze muss mindestens 1 sein. \n");
	return 1;
	}
		
	else
	{
	for (i = 1; i <= obergrenze; ++i)
	{
		ergebnis = collatz(i);
		if (ergebnis == -1)
			printf("Ueberlauf bei Wert %d \n",i);
		
		if (maximum <= ergebnis)
		{
		maximum = ergebnis;
		mwert = i;
		}
		if ((ergebnis <= 10) & (ergebnis >= 0)) 
		{
		printf("%d: %d Schritte \n",i,ergebnis);
		}
		
	}
	printf("Maximale Anzahl von Schritten sind %d fuer den Wert %d \n",maximum,mwert);
	return 0;
	}
	
	
}


