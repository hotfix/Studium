/////////////////////////////////////////////////////////////////////
///  Unit UTypes.pas
///
///  Behinhaltet Typen die für die Codierung/Decodierung benötigt werden
///
/// Erstellt von: Bastian T. und Alexander A. am 01.07.07
/// Letztes Update: 01.07.07 Vers. 1.01
/////////////////////////////////////////////////////////////////////

unit UTypes;

interface

type
  TBuchstabeK = 'A'..'Z';       //EinBuchstabe in Klartext
  TBuchstabeM  = string[4];     //Ein Buchstabe in Morse als String[4]
  TStringWortK  = string[40];   //Ein Wort im Klartext als String
  TStringWortM  = string[160];  //Ein Wort in Morse als String
  TWortM       = array[1..40] of string; //Ein Wort von Morsecode

  TEingabe = set of char; //Menge die für die Eingaberestiktionen benötigt wird
implementation

end.
