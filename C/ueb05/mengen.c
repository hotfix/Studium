#include <stdio.h>

  #include "mengen.h"


  /*----------------------------------------*/

  int
  cardinality (SET x)
  {
    int count = 0;

    while (x != emptyset)
      {
        
        x ^= (x & -x);
        ++count;
      }

    return count;
  }

  /*----------------------------------------*/

  void
  printset (SET s)
  {
    int first = 1;
    int e;

    forallelems (e, s)
    {
      printf ("%s%d", (first) ? "{" : ",", e);
      first = 0;
    }

    if (first)
      printf ("{");

    printf ("}");
  }
