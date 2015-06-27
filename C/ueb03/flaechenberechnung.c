/* Hier sind die Funktionen für die Flaechenberechnugen implementiert */
#include <stud.h>
#include <math.h>
#include "flaechenberechnung.h"


double flaecheKreis(double r)
{
    return PI * (r * r);
}

double flaecheDreieck(double g, double h)
{
    return (g * h) / 2;
}

double flaecheTrapez(double h, double a, double c)
{
    return h * ((a + c) / 2);
}
