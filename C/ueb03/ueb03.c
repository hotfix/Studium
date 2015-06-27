#include <math.h>
#include <stdio.h>
#include "flaechenberechnung.h"


int main(int argc, char* argv[])

{
int i, kreisc = 0, trapezc = 0, dreieckc = 0, fehler = 0;
double r = 0,g = 0,h = 0,a = 0,c = 0;
char chr;
	

for (i = 1; i < argc; i++) {
	
	
	if (argv[i][0] == '-') {
	
	   
	
	switch (argv[i][1]) {

		case 'k':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&r,&chr) == 1) && 
				(r > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb03 [-k <r> | -d <g> <h> | -t <h> <a> <c>] \n");
					fehler = 1;					
					return 1;
					break;
					}
				

		case 'd':	
				if 
				((fehler == 0) && 
				(argc > 3) && 
				(sscanf (argv[i+1],"%lf%c",&g,&chr) == 1) && 
				(sscanf (argv[i+2],"%lf%c",&h,&chr)== 1) && 
				(g > 0 ) && 
				(h > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb03 [-k <r> | -d <g> <h> | -t <h> <a> <c>] \n");
					fehler = 1;					
					return 1;
					break;
					}
				


		case 't':	
				if 
				((fehler == 0) && 
				(argc > 4) && 
				(sscanf (argv[i+1],"%lf%c",&h,&chr) == 1) && 
				(sscanf (argv[i+2],"%lf%c",&a,&chr)== 1) && 
				(sscanf (argv[i+3],"%lf%c",&c,&chr) == 1) && 
				(h > 0 ) && 
				(a > 0 ) && 
				(c > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb03 [-k <r> | -d <g> <h> | -t <h> <a> <c>] \n");
					fehler = 1;					
					return 1;
					break;
					}
				

		default : 		printf("Usage: ueb03 [-k <r> | -d <g> <h> | -t <h> <a> <c>] \n");
					fehler = 1;					
					return 1;
					break;
	    }
	}  
}

 

if (fehler == 0) {
		for (i = 1; i < argc; i++) {
	
	
		if (argv[i][0] == '-') {
	
	   
	
		switch (argv[i][1]) {

		case 'k':	kreisc++;
				sscanf (argv[i+1],"%lf",&r);
				printf("Kreis%d: %.3f \n",kreisc,flaecheKreis(r));
				break;

		case 'd':	dreieckc++;
				sscanf (argv[i+1],"%lf",&g);
				sscanf (argv[i+2],"%lf",&h);
				printf("Dreieck%d: %.3f \n",dreieckc,flaecheDreieck(g,h));
				break;

		case 't':	trapezc++;
				sscanf (argv[i+1],"%lf",&h);
				sscanf (argv[i+2],"%lf",&a);
				sscanf (argv[i+3],"%lf",&c);
				printf("Trapez%d: %.3f \n",trapezc,flaecheTrapez(h,a,c));
				break;

	
	    }
	}
}
}  

return 0;
}

