{------------------------------------------------------------------------------
 Konstantenunit

 Autor: Philip Lehmann-Böhm, 22.03.2007
 ------------------------------------------------------------------------------}
unit uConst;

interface

uses
  uTypes;

const

  // Anzahl der Karten
  cCardCount = 32;

  // Kosten pro Karte
  cCardCost = 15;

  // Startvermögen
  cStartMoney = 64;

  // Die Kartennamen
  cCardNames: array [0..31] of TCardStr =
               ('Karo 7', 'Karo 8', 'Karo 9', 'Karo Bube', 'Karo Dame', 'Karo König', 'Karo 10', 'Karo Ass',
                'Herz 7', 'Herz 8', 'Herz 9', 'Herz Bube', 'Herz Dame', 'Herz König', 'Herz 10', 'Herz Ass',
                'Pik 7', 'Pik 8', 'Pik 9', 'Pik Bube', 'Pik Dame', 'Pik König', 'Pik 10', 'Pik Ass',
                'Kreuz 7', 'Kreuz 8', 'Kreuz 9', 'Kreuz Bube', 'Kreuz Dame', 'Kreuz König', 'Kreuz 10', 'Kreuz Ass');

  // Die Gewinnfaktoren
  cWinFactors: array [0..4] of TWinFactor = (1,2,3,4,9);

implementation

end.
