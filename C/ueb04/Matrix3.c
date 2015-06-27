/**
  * Copyright (c): Uwe Schmidt, FH Wedel
  *
  * You may study, modify and distribute this source code
  * FOR NON-COMMERCIAL PURPOSES ONLY.
  * This copyright message has to remain unchanged.
  *
  * Note that this document is provided 'as is',
  * WITHOUT WARRANTY of any kind either expressed or implied.
  */

#include "Matrix3.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

/*--------------------*/

Matrix
newMatrix (int w, int h)
{
  Matrix res = malloc (sizeof (*res));

  if (res)
    {
      res->rows = malloc (h * sizeof (Row));
      res->elems = malloc (h * w * sizeof (Element));
      res->width = w;
      res->height = h;

      {
	Rows rs = res->rows;
	Row r = res->elems;

	if (rs && r)
	  {
	    while (h--)
	      {
		*rs++ = r;
		r += w;
	      }

	    return res;
	  }
      }
    }

  /* heap overflow */
  perror ("newMatrix: can't allocate matix");
  exit (1);
}

/*--------------------*/

void
freeMatrix (Matrix m)
{
  free (m->elems);
  free (m->rows);
  free (m);
}

/*--------------------*/

Matrix
zeroMatrix (int w, int h)
{
  Matrix res = newMatrix (w, h);
  Element *p = res->elems;

  int len = w * h;
  while (len--)
    {
      *p++ = 0.0;
    }

  return res;
}

/*--------------------*/

Matrix
unitMatrix (int w, int h)
{
  Matrix res = zeroMatrix (w, h);
  Rows r = res->rows;

  int i;
  for (i = 0; i < w && i < h; ++i)
    {
      r[i][i] = 1.0;
    }

  return res;
}

/*--------------------*/

Matrix
addMatrix (Matrix m1, Matrix m2)
{
  int w = m1->width;
  int h = m1->height;

  assert (w == m2->width && h == m2->height);

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
	    r[j][i] = r1[j][i] + r2[j][i];
	  }
      }
    return res;
  }
}

/*--------------------*/

Matrix
transposeMatrix (Matrix m)
{
  int w = m->width;
  int h = m->height;

  Matrix res = newMatrix (h, w);
  Rows r = res->rows;
  Rows r1 = m->rows;

  int j;
  for (j = 0; j < h; ++j)
    {
      int i;
      for (i = 0; i < w; ++i)
	{
	  r[i][j] = r1[j][i];
	}
    }
  return res;
}

/*--------------------*/

Element
at (Matrix m, int i, int j)
{
  assert (i < m->width && j < m->height);
  return m->rows[j][i];
}

Matrix
setAt (Matrix m, int i, int j, Element v)
{
  assert (i < m->width && j < m->height);
  m->rows[j][i] = v;
  return m;
}

/*--------------------*/
