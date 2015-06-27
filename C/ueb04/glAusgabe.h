#ifndef __GLAUSGABE_H__
#define __GLAUSGABE_H__ 1

#include <GL/glut.h>
#include "Matrix3.h"


/* Datentyp fuer eine Textur */
typedef struct texture TTexture;
struct texture
{
	int width;
	int height;
	int orgwidth;
	int orgheight;
	GLfloat* pixel;
};

/* Datentyp fuer ein Rechteck */
typedef struct rect Rect;
struct rect
{
	GLfloat x;
	GLfloat y;
	GLfloat width;
	GLfloat height;
	GLfloat xTexAspect;
	GLfloat yTexAspect;
};

/* zeigt die Matrizen als Bitmaps auf dem Bildschirm an
   matrizen : Array mit bis zu 12 Matrizen
   n        : Anzahl Matrizen im Array */
void zeigeMatrizen(Matrix* matrizen, int n);


#endif
