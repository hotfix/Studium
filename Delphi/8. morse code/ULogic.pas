/////////////////////////////////////////////////////////////////////
///  Unit Logic.pas
///
///  ULogic führt von UMain angeforderte Funktionalität aus und hat Zugriff
///  auf die Unit UBinTree
///
/// Erstellt von: Bastian T. und Alexander A. am 01.07.07
/// Letztes Update: 01.07.07 Vers. 1.01
/////////////////////////////////////////////////////////////////////
unit ULogic;

interface
  uses UBinTree, UTypes, UConst, SysUtils;

  function TextToCode(Quellwort : TStringWortK): TStringWortM;
  function CodeToText(Quellwort : TStringWortM): TStringWortK;
  function InputfilterK(var Eingabe : string; Filter : TEingabe) : boolean;
  function InputFilterM(var Eingabe : string) : boolean;

implementation

//------------------------------Filter------------------------------
/////////////////////////////////////////////////////////////////////
// InputFilterK:
// Filtert in abhängigkeit von IN: Filter verschiedene Zeichen
// aus IN: Eingabe
/////////////////////////////////////////////////////////////////////
// IN: Eingabe: String der gefiltert werden soll
// IN: Filter: Menge von Zeichen die gefiltert werden sollen
// OUT: InputfilterK gibt TRUE zurück wenn nichts geändert wurde
/////////////////////////////////////////////////////////////////////
function InputfilterK(var Eingabe : string; Filter : TEingabe) : boolean;
var
  i : byte;
  countdeleted : byte;
  notchanged : boolean;
  Ursprungslaenge : byte;
begin
  countdeleted := 0;
  notchanged := TRUE;
  Ursprungslaenge := Length(Eingabe);
  i := 1;
  while (i <= (Ursprungslaenge - countdeleted)) do
  begin
    if Eingabe[i] in Filter then
      inc(i)
    else
    begin
      delete(Eingabe,i,1);
      inc(countdeleted);
      notchanged := notchanged AND FALSE;
    end;
  end;
  InputFilterK := notchanged;
end;

function InputFilterM(var Eingabe : string) : boolean;
var
  LetterCount : integer;
  MorseWort : string;
  EinWort : TWortM;
  Anzahl : byte;
  MaxAnzahl : byte;
  usedFilter : boolean;
begin
  //-------------StringToArray
  MorseWort := '';
  LetterCount := 1;
  Anzahl := 1;
  usedFilter  := FALSE;
  while (LetterCount <= length(Eingabe)) do
  begin
    if Eingabe[Lettercount] <> ' ' then
    begin
      MorseWort := MorseWort + Eingabe[Lettercount];
      inc(Lettercount);
    end
    else
    begin
      EinWort[Anzahl] := MorseWort;
      MorseWort := '';
      inc(Lettercount);
      inc(Anzahl);
    end;
  end;
  EinWort[Anzahl] := MorseWort;
  //-------------StringToArray ENDE
  MaxAnzahl := Anzahl;
  Anzahl := 1;
  while (Anzahl <= MaxAnzahl) do
  begin
    //MÖÖP
    if NOT(IsInMorseWort(EinWort[Anzahl])) then
    begin
      Delete(Eingabe,Pos(EinWort[Anzahl],Eingabe),length(EinWort[Anzahl])+1);

      usedFilter := TRUE;
    end;
  inc(Anzahl);
  end;
  InputFilterM := usedFilter;
end;

//------------------------------Codierung------------------------------

/////////////////////////////////////////////////////////////////////
// TextToCode:
// Wandelt mit Hilfe der Arraykonstante einen string aus dem Quellwort(Klartext)
// in das Zielwort (Morsecode um)
/////////////////////////////////////////////////////////////////////
// IN: Quellwort (Klartext)
// OUT: Zielwort (MorseCode)
/////////////////////////////////////////////////////////////////////
function TextToCode(Quellwort : TStringWortK): TStringWortM;
var   
  i : byte;
  TempZielwort : TStringWortM;
begin
  Quellwort := UpperCase(Quellwort);

  TempZielwort := '';
  for i := 1 to length(Quellwort) do
  begin
    if Quellwort[i] = ' ' then
      TempZielwort := TempZielwort + ' '
    else
      TempZielwort := TempZielwort + ' ' + CCodeWord[Quellwort[i]];
  end;
  if length(Quellwort) >= 1 then
    delete(TempZielwort,1,1);
  TextToCode := TempZielwort;
end;

//------------------------------Decodierung------------------------------

//schoener machen :)
function CodeToText(Quellwort : TStringWortM): TStringWortK;
var
  TempQuellwort : TStringWortM;
  QuellArray    : TWortM;
  j : byte;
  LetterCount : Byte;
  Wort : string;
begin

  //Umwandlung des Strings in ein Array
  //erfordert, dass mindestens 1 BuchstabeM drinsteht
  TempQuellwort := '';
  LetterCount := 1;

  //Init Array
  for j := 1 to high(Quellarray) do
      Quellarray[j] := '';

  //Laufe bis Quellword laenge
  repeat
      Wort := '';

      //-----------------
      //-----------------

      //Teile das Morse Code in einzelne Buchstaben
      while (Quellwort[LetterCount] <> ' ')
          AND (LetterCount <= length(Quellwort)) do
      begin
        Wort := Wort + Quellwort[LetterCount];
        inc(LetterCount);
      end;
      inc(LetterCount);
      // Wenn grosse des Zeichens ueberschritten dann springe raus
      // und liefere leeren string
      if Length(Wort) <= 4 then
        TempQuellwort := TempQuellwort + DecodeWort(Wort)
      else
      begin
        LetterCount := length(Quellwort)+1;
      end;

  until LetterCount > length(Quellwort);

  CodeToText := TempQuellwort;
end;
end.
