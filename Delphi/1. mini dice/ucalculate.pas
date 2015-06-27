//-------------------------------------------------------------
// Berechnungsunit
// Dient zur logischen Berechnung der Aufgabe
// erstellt von: Alexander Albrant(winf2862)
// am: 17.04.2007
//-------------------------------------------------------------
unit uCalculate;

interface
  //berechnet dasVermögen für Single Variante
  function CalcSingle(AnzahlWerte : byte; betrag, vermoegen : string) : string;
  //berechnet dasVermögen für Field Variante
  function CalcField (treffer : boolean; betrag, vermoegen: string):string;
implementation

uses SysUtils;

//berechnet dasVermögen für Single Variante
// in: AnzahlWerte:  Anzahl der Treffer
//     betrag:     Eingesetzter betrag
//     vermoegen :  Vermögen
// out: neuer Vermögen
function CalcSingle(AnzahlWerte : byte; betrag, vermoegen : string) : string;

begin
   if AnzahlWerte=1 then
    CalcSingle := IntToStr(StrToInt(vermoegen)+ StrToInt(betrag));
  if AnzahlWerte=2 then
    CalcSingle := IntToStr(StrToInt(vermoegen)+ (StrToInt(betrag)*2));
  if AnzahlWerte=3 then
    CalcSingle := IntToStr(StrToInt(vermoegen)+ (StrToInt(betrag)*12));
  if AnzahlWerte=0 then
    CalcSingle := IntToStr(StrToInt(vermoegen)- StrToInt(betrag));
end;

//berechnet dasVermögen für Field Variante
//in: treffer:   Ob die summe ein treffer war j/n
//     betrag:     Eingesetzter betrag
//     vermoegen :  Vermögen
//out:
function CalcField (treffer : boolean; betrag, vermoegen: string):string;

begin
  if treffer then
    CalcField := IntToStr(StrToInt(vermoegen) + StrToInt(betrag))
  else
    CalcField := IntToStr(StrToInt(vermoegen) - StrToInt(betrag));
end;
end.
