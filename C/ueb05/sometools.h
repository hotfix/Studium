#ifndef __SOMETOOLS_H__
#define __SOMETOOLS_H__ 

#include <stdlib.h>
#include <ctype.h>
#include <math.h>


#define WINPATH 1

#ifdef WINPATH
#define  PATH_SEP                '\\'
#else
#define  PATH_SEP                '/'
#endif

extern int     strcicmp(char *str1, char * str2);
extern char *  extractfilename(char * p);
extern double  RoundTwo(double num);


#endif

