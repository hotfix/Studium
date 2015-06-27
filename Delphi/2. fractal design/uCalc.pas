 //------------------------------------------------------
 //   uCalculate enthält 4 Funktionen zur Berechnung
 // getRe : berechnet aus der X-Bildkoordinate den realen Anteil im
 //         Koordinatensystem.
 // getIm :  berechnet aus der y-Bildkoordinate den imaginдren Anteil im
 //          Koordinatensystem.
 //  mandel :  berechnet rekursiv die Farbe fьr einen ihr ьbergebenen
 //            Bildpunkt fьr das Apfelmдnnchen.
 //  julia :   berechnet rekursiv die Farbe fьr einen ihr ьbergebenen
 //            Bildpunkt fьr eine Juliamenge.
 //
 // Erstellt von : Bastian Terfloth(WInf 8196)
 //                   und
 //                Alexander Albrant (winf2862)
 // am : 29.04.2007
 // version : 0.1
 //------------------------------------------------------


unit uCalc;

interface
  uses 
      Graphics;

  // berechnet aus der X-Bildkoordinate den realen Anteil im
  // Koordinatensystem.
  function getRe(const x:integer; ReMin,ReMax:real; Breite: integer) : real;

  // berechnet aus der y-Bildkoordinate den imaginдren Anteil im
  // Koordinatensystem.
  function getIm(const y:integer; ImMax,ImMin:real; Hoehe: integer) : real;

  // berechnet rekursiv die Farbe fьr einen ihr ьbergebenen
  // Bildpunkt fьr das Apfelmдnnchen.
  function mandel (depth:integer; re,im:real; const re0, im0:real) : TColor;

  // berechnet rekursiv die Farbe fьr einen ihr ьbergebenen
  //Bildpunkt fьr eine Juliamenge.
  function julia (depth:integer; re,im:real; const re0, im0,
                      jre, jim:real) : TColor;


implementation

const Juliacolor = 1985476;
      mandelColor = 10;

// berechnet aus der X-Bildkoordinate den realen Anteil im
// Koordinatensystem.
function getRe(const x:integer; ReMin,ReMax:real; Breite: integer) : real;
var
  dx : real;   // Anzahl der Px in einer Einheit (x-Achse)
begin
  dx := (ReMax - ReMin) / Breite;
  GetRe := ReMin + x * dx;
end;

// berechnet aus der y-Bildkoordinate den imaginдren Anteil im
// Koordinatensystem.
function getIm(const y:integer; ImMax,ImMin:real; Hoehe: integer) : real;
var
  dy : real;   // Anzahl der Px in einer Einheit (y-Achse)
begin
  dy := (ImMax - ImMin) / Hoehe;
  getIm := ImMax - y * dy;
end;

// berechnet rekursiv die Farbe fьr einen ihr ьbergebenen
// Bildpunkt fьr das Apfelmдnnchen.
function mandel (depth:integer; re,im:real; const re0, im0:real) : TColor;
var
  neuRe : real;
begin
{  if (depth = 0) OR ((Re*Re+Im*Im)>=100) then
  begin
    if (depth = 0) then
      mandel := TColor(clBlack);
    if (Re*Re+Im*Im) >= 100 then
      mandel := TColor(mandelcolor * depth);//in der Menge
  end
}
    if (depth = 0) then
      mandel := TColor(clBlack)
    else if (Re*Re+Im*Im) >= 100 then
      mandel := TColor(mandelcolor * depth)//in der Menge
   else
    begin
      neuRe := Re;
      Re := Re * Re - Im * Im + re0;
      Im := 2 * neuRe * Im + im0;
      mandel := mandel((depth-1),Re,Im,re0,im0);
    end

end;

// berechnet rekursiv die Farbe fьr einen ihr ьbergebenen
//Bildpunkt fьr eine Juliamenge.
function julia (depth:integer; re,im:real; const re0, im0,
                      jre, jim:real) : TColor;
var
 TempRe : real;
begin
//Depth zu ende oder Grenze ьberschritten, nicht weiter rendern
//... sondern depth = 0 -> Black
//... sonst (wenn grenze ьberschritten) BUNT
  if (depth = 0) OR ((Re*Re+Im*Im)>=100) then
  begin
    if (depth = 0) then
      Julia := TColor(clBlack);
    if ((Re*Re+Im*Im) >= 100) and (depth <>0)then
      Julia := TColor(Juliacolor div depth);//in der Menge
  end
 else
  begin
   TempRe := Re * Re - Im * Im + jre;
   Im := 2*Re * Im + jim;
   Re := TempRe;
   Julia := Julia((depth-1),Re,Im,re0,im0,jre,jim);
  end;//ende else Teil
end;
end.
