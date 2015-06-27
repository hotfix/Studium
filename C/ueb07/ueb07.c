/***********************************************************************
*
*Uebung 07/String Bibliotheken
*A. Albrant winf2862
*J.C. Benecke winf2880
*
**********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "bstring.h" 

int test(char *in) {
  char *t  = malloc(strlen(in)+1);
  
  int ret  = 0;
  printf("==============================\n");
  printf("New Test: \"%s\"\n",in);
  printf("==============================\n");

  strcpy(t,in);
  bsFree(t);
  printf("bsFree  : \"%s\"\n",t);

  strcpy(t,in);
  bsLen(t);
  printf("bsLen  : \"%s\"\n",t);

  strcpy(t,in);
  bsConcat(t);
  printf("bsConcat    : \"%s\"\n",t);

  strcpy(t,in);
  bsPrint(t);
  printf("bsPrint  : \"%s\"\n",t);

  strcpy(t,in);
  bsPrintLn(t);
  printf("bsPrintLn     : \"%s\"\n",t);
  
  strcpy(t,in);
  bsMid(t);
  printf("bsMid: \"%s\"\n",t);

  strcpy(t,in);
  bsUcase(t);
  printf("bsUcase     : \"%s\"\n",t);

  strcpy(t,in);
  bsCompare(t);
  printf("bsCompare     : \"%s\"\n",t);

  strcpy(t,in);
  bsInstr(t);
  printf("bsPrintLn     : \"%s\"\n",t);

  free(t);
  return 1;
}

int main(int argc, char *argv[]) {
  if (argc > 1) test(argv[1]);
  return 0;
}


