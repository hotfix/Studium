/* Gibt Matrizen als Graustufenbilder mit Hilfe von OpenGL auf dem Bildschirm aus */


#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "float.h"
#include <GL/glut.h>
#include "glAusgabe.h"
#include "Matrix3.h"


GLuint* textureIDs;
int nquads;
Rect rects[12];



/* ---------------------------------------------------------------------
 * FUNKTION : init
 * AUFGABE  : Initialisierung des OpenGL-Systems
 * BESCHR.  : Setzt Hintergrund- und Zeichenfarbe
 * ------------------------------------------------------------------ */
int init(void)
{
	/* Setzen der Hintergrundfarbe */
	glClearColor(0.0f, 0.0f, 0.6f, 0.0f);

	/* Setzen der Viewattribute */
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-1.0f, 1.0f, -0.75f, 0.75f, -1.0f, 1.0f);
	glMatrixMode(GL_MODELVIEW);

	/* Alles in Ordnung? */
	return (glGetError() == GL_NO_ERROR);
}



/* ---------------------------------------------------------------------
 * FUNKTION : keyboard
 * AUFGABE  : Callback fuer Tastendruck
 * BESCHR.  : Ausgabe der gedrueckten Taste
 *            Programmende, wenn ESC gedrueckt
 *
 * Parameter :
 *   key  : In : betroffene Taste
 *   x, y : In : Position der Maus zur Zeit des Tastendrucks
 * ------------------------------------------------------------------ */
void keyboard(unsigned char key, int x, int y)
{
	/* Programm beenden, wenn Escape oder Space gedrueckt wurde */
	if (key==27 || key==32) exit(0);
}



/* ------------------------------------------------------------------
 * FUNKTION : drawRect
 * AUFGABE  : zeichnet ein texturiertes Rechteck
 * BESCHR.  : die Ausmasse des Rechtecks werden dem globalen Array entnommen
 *
 * Parameter :
 *   nr : In : Nummer des Rechtecks
 * ------------------------------------------------------------------ */
void drawRect(int nr)
{
	/* Textur laden */
	glBindTexture(GL_TEXTURE_2D,textureIDs[nr]);

	/* Zeichnen eines einfachen Rechteckpolygons */
	glPushMatrix();
	glBegin(GL_QUADS);

   	glTexCoord2f(0.0f,0.0f);
	glVertex3f(rects[nr].x,rects[nr].y,0.0f);

   	glTexCoord2f(rects[nr].xTexAspect,0.0f);
	glVertex3f(rects[nr].x+rects[nr].width,rects[nr].y,0.0f);

   	glTexCoord2f(rects[nr].xTexAspect,rects[nr].yTexAspect);
	glVertex3f(rects[nr].x+rects[nr].width,rects[nr].y-rects[nr].height,0.0f);

   	glTexCoord2f(0.0f,rects[nr].yTexAspect);
	glVertex3f(rects[nr].x,rects[nr].y-rects[nr].height,0.0f);

	glEnd();
	glPopMatrix();
}



/* ---------------------------------------------------------------------
 * FUNKTION : display
 * AUFGABE  : Zeichen-Callback
 * BESCHR.  : Ausgabe der Matrizen
 * ------------------------------------------------------------------ */
void display(void)
{
	int i;

	/* Buffer zuruecksetzen */
	glClear(GL_COLOR_BUFFER_BIT);

	/* Matrizen anzeigen */
	glEnable(GL_TEXTURE_2D);
	for (i=0; i<nquads; i++) drawRect(i);
	glDisable(GL_TEXTURE_2D);

	/* Bild anzeigen */
	glutSwapBuffers();
}



/* ---------------------------------------------------------------------
 * FUNKTION : registerCallbacks
 * AUFGABE  : Registrierung der Callback-Routinen
 * BESCHR.  : Setzt Callback-Routinen
 * ------------------------------------------------------------------ */
int registerCallbacks(void)
{
	/* Display-Callback (zeichnen der Szene) */
	glutDisplayFunc(display);

	/* Tasten-Druck-Callback (wird ausfuehrt, wenn eine Taste gedrueckt wird) */
	glutKeyboardFunc(keyboard);

	/* Alles in Ordnung? */
	return (glGetError() == GL_NO_ERROR);
}



/* ---------------------------------------------------------------------
 * FUNKTION : makeGLTextureSize
 * AUFGABE  : Rundet die Texturegroesse auf eine Potenz von 2 auf,
 *            mindestens aber auf 64
 *
 * Parameter :
 *   orgsize : In  : Originalgroesse der Textur
 *             Out : Texturgroesse fuer GL
 * ------------------------------------------------------------------ */
int makeGLTextureSize(int orgsize)
{
	int s=64;

	while (s<orgsize) s*=2;
	return s;
}



/* ---------------------------------------------------------------------
 * FUNKTION : matrixToTexture
 * AUFGABE  : Konvertiert eine double-Matrix in eine GLfloat-Textur
 *
 * Parameter :
 *   matrix  : In  : zu konvertierende Matrix
 *   texture : Out : erzeugte Textur
 * ------------------------------------------------------------------ */
void matrixToTexture(Matrix matrix, TTexture* texture)
{
	int i,j;
	int wd,hg,glwd,glhg;
	double d;
	GLfloat* p;

	/* Breite und Hoehe bestimmen und GL-konform machen */
	wd=matrix->width;
	if (wd>256) wd=256;
	glwd=makeGLTextureSize(wd);
	hg=matrix->height;
	if (hg>256) hg=256;
	glhg=makeGLTextureSize(hg);

	/* Breite und Hoehe in die Textur eintragen */
	texture->width=glwd;
	texture->height=glhg;
	texture->orgwidth=wd;
	texture->orgheight=hg;

	/* Pixel konvertieren und kopieren */
	p=texture->pixel;
	for (j=0; j<hg; j++)
	{
		for (i=0; i<wd; i++)
		{
			d=matrix->rows[j][i];
			if (fabs(d-1.0)<DBL_EPSILON) *p++=(GLfloat) 1.0f; else *p++=(GLfloat)(d-floor(d));
		}
		p+=(glwd-wd);
	}
}



/* ---------------------------------------------------------------------
 * FUNKTION : bindTexture
 * AUFGABE  : Bindet eine Textur in die Hardware ein
 *
 * Parameter :
 *   tnr     : In : Nummer der Textur
 *   texture : In : Matrix mit den Pixeldaten
 * ------------------------------------------------------------------ */
void bindTexture(int tnr, TTexture texture)
{
	/* Textur binden */
	glBindTexture(GL_TEXTURE_2D,textureIDs[tnr]);
	glTexImage2D(GL_TEXTURE_2D,0,GL_LUMINANCE,texture.width,texture.height,0,GL_LUMINANCE,GL_FLOAT,texture.pixel);
	glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

	/* pruefen, ob Textur erfolgreich gebunden wurde */
	if (glGetError()!=GL_NO_ERROR)
	{
		printf("Cannot bind texture #%d %dx%d (error %d).\n",tnr,texture.width,texture.height,glGetError());
	}
}



void zeigeMatrizen(Matrix* matrizen, int n)
{
	int i;
	GLfloat x,y;
	TTexture texture;
	char* arg0 = "ueb04";
	int argc = 1;

	/* Anzahl der Matrizen pruefen */
	if (n<0) return;
	if (n>12) n=12;

	/* Initialisieren des Fensters */
	glutInit(&argc,&arg0);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(800,600);
	glutInitWindowPosition(0,0);

	/* Erzeugen des Fensters, Initialisierung v. Anwendung und Callbacks */
	if (!glutCreateWindow("C-Uebung Aufgabe 4 OpenGL-Fenster") || !init() || !registerCallbacks()) return;

	/* Speicher fuer Textur reservieren */
	texture.pixel=malloc(256*256*sizeof(GLfloat));

	/* TextureIDs erzeugen */
	textureIDs=malloc(n*sizeof(GLuint));
	glGenTextures(n,textureIDs);

	/* Matrizen in Texturen konvertieren und anzeigen */
	nquads=n;
	x=-0.9f;
	y=0.7f;
	for (i=0; i<n; i++)
	{
		matrixToTexture(matrizen[i],&texture);
		bindTexture(i,texture);
		rects[i].x=x;
		rects[i].y=y;
		rects[i].width=(GLfloat)texture.orgwidth/256.0f*0.4f;
		rects[i].height=(GLfloat)texture.orgheight/256.0f*0.4f;
		rects[i].xTexAspect=(GLfloat)texture.orgwidth/(GLfloat)texture.width;
		rects[i].yTexAspect=(GLfloat)texture.orgheight/(GLfloat)texture.height;
		x+=(0.4f+0.2f/3.0f);
		if ((i%4)==3)
		{
			x=-0.9f;
			y-=0.5f;
		}
	}

	/* Hauptschleife der Ereignisbehandlung starten */
	glutMainLoop();
}
