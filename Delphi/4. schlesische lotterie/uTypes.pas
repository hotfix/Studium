{------------------------------------------------------------------------------
 Typenunit.

 Autor: Philip Lehmann-B�hm, 22.03.2007
 ------------------------------------------------------------------------------}
unit uTypes;

interface

type

  // Typ f�r die Kartennamen
  TCardStr = string[11];

  // Ein Ziehungsergebnis
  TGameResult = array[0..8] of TCardStr;

  // Datentyp f�r die Gewinnfaktoren
  TWinFactor = 1..9;

  // Die 32 Spielkarten
  TCards = (k7, k8, k9, kb, kd, kk, k10, ka,
            h7, h8, h9, hb, hd, hk, h10, ha,
            p7, p8, p9, pb, pd, pk, p10, pa,
            kr7, kr8, kr9, krb, krd, krk, kr10, kra);
  
implementation

end.
