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

#ifndef Matrix3__
#define Matrix3__ 1

typedef double Element;

typedef Element *Row;
typedef Row *Rows;

typedef struct
{
  Rows rows;
  Element *elems;
  int width;
  int height;
} *Matrix;

/* constructor functions */

extern Matrix newMatrix (int w, int h);
extern Matrix zeroMatrix (int w, int h);
extern Matrix unitMatrix (int w, int h);

/* destructor */

extern void freeMatrix (Matrix m);

/* matrix ops */

extern Matrix addMatrix (Matrix m1, Matrix m2);
extern Matrix transposeMatrix (Matrix m);

/* element access ops */

extern Element at (Matrix m, int i, int j);
extern Matrix setAt (Matrix m, int i, int j, Element v);

#endif
