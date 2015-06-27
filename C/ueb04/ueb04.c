#include <stdio.h>
#include "glAusgabe.h"
#include <math.h>

Matrix Generator1 (int b, int h) {
 
int i,j;
double hcolorstep, hcolor;

 Matrix m1;
 m1 = newMatrix(b,h);
 Rows r = m1->rows; 
 hcolorstep = 1 / (float) b;
 hcolor = 0;
 
 
 for (j = 0; j < h; j++) {
  
  for (i = 0; i < b; i++) { 
   
   r[i][j] = hcolor;
  }
  hcolor += hcolorstep;
  } 
  
 return m1;
 
   
}

Matrix Generator2 (int b, int h) {
 
int i,j;
double hcolorstep, hcolor;

 Matrix m1;
 m1 = newMatrix(b,h); 
 Rows r = m1->rows; 
 hcolorstep = 1 / (float) b;
 hcolor = 1;
 
 for (j = 0; j < h; j++) {
  for (i = 0; i < b; i++) {    
   hcolor += hcolorstep;	  
   r[i][j] = hcolor;
   r[j][i] = hcolor;
   
  }
  } 

 return m1;
 
   
}


Matrix Generator3 (int b, int h) {
 
int i,j;
double wcolorstep, wcolor;

 Matrix m1;
 m1 = newMatrix(b,h);
 Rows r = m1->rows; 
 wcolorstep = 1 / (float) b;
 wcolor = 0;
 
 for (j = 0; j < h; j++) {
  for (i = 0; i < b; i++) { 
   
   r[j][i] = wcolor;
  }
   wcolor += wcolorstep;
  
  } 
  
 return m1;
   
}

Matrix Generator4 (int b, int h) {
 
int i,j;
double hcolorstep, hcolor;

 Matrix m1;
 m1 = newMatrix(b,h);
 Rows r = m1->rows; 
 hcolorstep = 2 / (float) b;
 hcolor = 0;
 for (j = h/2; j > 0; j--) {
  for (i = 0; i <= b; i++) { 
   r[j][i] = hcolor;
  }
   hcolor -= hcolorstep;  
  } 
  hcolor = 1;
  
  for (j = (h/2); j < h; j++) {
  for (i = 0; i < b; i++) { 
   r[j][i] = hcolor;
  }
   hcolor -= hcolorstep;  
	  }
   
 return m1;
}

Matrix
subbMatrix (Matrix m1, Matrix m2)
{
  int w = m1->width;
  int h = m1->height;

  /*assert (w == m2->width && h == m2->height);*/

  {
    Matrix res = newMatrix (w, h);
    Rows r = res->rows;
    Rows r1 = m1->rows;
    Rows r2 = m2->rows;

    int j;
    for (j = 0; j < h; ++j)
      {
	int i;
	for (i = 0; i < w; ++i)
	  {
	    r[j][i] = r1[j][i] - r2[j][i];
	  }
      }
    return res;
  }
}


Matrix
 multiMatrix(Matrix m1, Matrix m2)
{
  int w = m1->width;
  int h = m1->height;

  /*assert (w == m2->width && h == m2->height);*/

   Matrix res = newMatrix (w, h);
    Rows r = res->rows;
    Rows r1 = m1->rows;
    Rows r2 = m2->rows;

    int j,a,b;
    a=0;
    if (w=h) 
    for (j = 0; j < h-1; ++j)
      {
	int i;
	b=0;
	while (b<=w)
	{ 
	  r[a][b]=0;
	  for (i = 0; i < w-1; ++i)
	  { 
	   r[a][b] = r[a][b] + r2[a][i]*r1[i][b];
	  }
	  b++;
	}
      a++;
      }
    else  printf("ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]*\n");
    return res;
  
}



int main (int argc, char **argv) 
{ 
Matrix genmatr1[5];
Matrix m1;	
int i, fehler = 0;
double weite=0, hoehe=0, generator=0;
double addition=0, subtraktion=0, multiplikation=0;	
char chr;
int w = m1->width;
int h = m1->height;


for (i = 1; i < argc; i++) {
	
	
	if (argv[i][0] == '-') {
	
	   
	
	switch (argv[i][1]) {

		case 't':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&generator,&chr) == 1) && 
				(generator > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]*\n");
					fehler = 1;					
					return 1;
					break;
					}
				

		case 'w':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&weite,&chr) == 1) && 
				(weite > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]* \n");
					fehler = 1;					
					return 1;
					break;
					}
				

		case 'h':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&hoehe,&chr) == 1) && 
				(hoehe > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]*\n");
					fehler = 1;					
					return 1;
					break;
					}
					
		case 'a':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&addition,&chr) == 1) && 
				(addition > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]*\n");
					fehler = 1;					
					return 1;
					break;
					}	
					
		case 's':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&subtraktion,&chr) == 1) && 
				(subtraktion > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]*\n");
					fehler = 1;					
					return 1;
					break;
					}
		case 'm':	
				if 
				((fehler == 0) && 
				(argc > 2) && 
				(sscanf (argv[i+1],"%lf%c",&multiplikation,&chr) == 1) && 
				(multiplikation > 0 )) 
				{
				return 0;
				break;
				}
				else 	{ 
					printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]*\n");
					fehler = 1;					
					return 1;
					break;
					}

		default : 		printf("Usage: ueb -t (1..4) -w <columns> -h <rows> [(-a|-s|-m) -t (1..4) -w <columns> -h <rows>]* \n");
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

		case 't':	sscanf (argv[i+1],"%lf",&generator);				
				break;

		case 'w':	sscanf (argv[i+1],"%lf",&weite);								
				break;

		case 'h':	sscanf (argv[i+1],"%lf",&hoehe);					
				break;
		case 'a':	genmatr1[0] = Generator1(weite, hoehe);	

			break;
		
	
	    }
	}
}
}
	
/*genmatr1[0] = Generator1(200,200);*/
genmatr1[1] = Generator2(200,200);
genmatr1[2] = Generator3(200,200);
genmatr1[3] = Generator4(200,200);
genmatr1[4] = multiMatrix (genmatr1[0], addMatrix (genmatr1[0], genmatr1[0]));
zeigeMatrizen(genmatr1,5);	
}
