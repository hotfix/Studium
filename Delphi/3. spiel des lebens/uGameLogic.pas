{------------------------------------------------------------------------------
 Unitkopf
  --------------------------------------
 Erweitert/gefüllt am 09.05.07 von Bastian Terfloth und Alexander Albrant
  --------------------------------------
  Diese Unit enthält Funktionen und Prozeduren für die Berechnung des Spiel
  des Lebens.
 ------------------------------------------------------------------------------}
unit uGameLogic;

interface

uses
  uTypes;

procedure initGame(i: integer);
procedure setWidth(newWidth: TGameWidth);
procedure setHeight(newHeight: TGameHeight);
function getWidth: TGameWidth;
function getHeight: TGameHeight;
function getCellState(x: TGameWidth; y: TGameHeight): boolean;
procedure nextGen;
procedure initGlob;

implementation

uses
  uGames;

var
  curGen: TGamefield;
  gameWidth: TGameWidth;
  gameHeight: TGameHeight;

{-------------------------------------------------------------------------
Setzt die globalen Variablen nach dem Programmstart
 ----------------------------------------------------------------------
 globale Zugriffe :
 gameWidth (schreibend): Die aktuelle Spielfeldbreite
 gameHeight (schrebend): Die aktuelle Spielfeldhoehe
 -------------------------------------------------------------------------}
 procedure initGlob;
 begin
   GameHeight := high(TGameHeight);
   GameWidth := high(TGameWidth);
 end;

{-------------------------------------------------------------------------
 Setzt das Spielfeld auf eine neue Breite. Arrayfelder außerhalb des
 Spielfeldes werden geleert.
 ----------------------------------------------------------------------
 newWidth (in): Die neue Breite des Spielfeldes
 ----------------------------------------------------------------------
 globale Zugriffe :
 gameWidth (schreibend): Die aktuelle Spielfeldbreite
 -------------------------------------------------------------------------}
procedure setWidth(newWidth: TGameWidth);
var I : integer;
    J: Integer;

begin
  if (high(TGameWidth) > newWidth) then
  begin
    //Wenn vergrößert/Verkleinert wurde
    for J := newWidth+1 to high(TGameWidth) do
      for I := low(TGameHeight) to high(TGameHeight) do
        curGen[J,I] := FALSE;
  end;
  gameWidth := newWidth;
end;

{-------------------------------------------------------------------------
 Setzt das Spielfeld auf eine neue Höhe. Arrayfelder außerhalb des
 Spielfeldes werden geleert.
 ----------------------------------------------------------------------
 newHeight (in): Die neue Höhe des Spielfeldes
 ----------------------------------------------------------------------
 globale Zugriffe :
 gameHeight (schreibend): Die aktuelle Spielfeldhöhe
 -------------------------------------------------------------------------}
procedure setHeight(newHeight: TGameHeight);
var
  I, J : integer;
begin
  if (high(TGameHeight) > newHeight) then
  begin
    //Wenn vergrößert/Verkleinert wurde
    for I := newHeight+1 to high(TGameHeight) do
      for J := low(TGameWidth) to high(TGameWidth) do
        curGen[J,I] := FALSE;
 end;
  gameHeight := newHeight;
end;

{-------------------------------------------------------------------------
 Ermittelt die aktuelle Spielfeldbreite.
 ----------------------------------------------------------------------
 Rückgabewert (out): Die Spielfeldbreite
 ----------------------------------------------------------------------
 globale Zugriffe :
 gameWidth (lesend): Die aktuelle Spielfeldbreite
 -------------------------------------------------------------------------}
function getWidth: TGameWidth;
begin
  getWidth := gameWidth;
end;

{-------------------------------------------------------------------------
 Ermittelt die aktuelle Spielfeldhцhe.
 ----------------------------------------------------------------------
 Rückgabewert (out): Die Spielfeldhцhe
 ----------------------------------------------------------------------
 globale Zugriffe :
 gameHeight (lesend): Die aktuelle Spielfeldhцhe
 -------------------------------------------------------------------------}
function getHeight: TGameHeight;
begin
  getHeight := gameHeight;
end;

{-------------------------------------------------------------------------
 Initialisiert das Spielfeld mit einem der Spielfelder aus uGames.pas
 ----------------------------------------------------------------------
 initGame (in): Der Index des zu ladenden Spielfedes.
 ----------------------------------------------------------------------
 globale Zugriffe :
 curGen (schreibend): Die interne Darstellung der aktuellen Generation
 -------------------------------------------------------------------------}
procedure initGame(i: integer);

begin
  curGen := getGame(i);
  gameWidth := getWidth();
  gameHeight := getHeight();
  setWidth(GetWidth);
  setHeight(GetHeight);
end;

{-------------------------------------------------------------------------
 Ermittelt, ob ein bestimmtes Feld auf dem Spielfeld belegt ist.
 ----------------------------------------------------------------------
 x (in): Die x-Komponente der Feldkoordinate
 y (in): Die y-Komponente der Feldkoordinate
 ----------------------------------------------------------------------
 Rückgabewert (out): Spielfeld belegt (oder eben nicht)
 ----------------------------------------------------------------------
 globale Zugriffe :
 curGen (lesend): Die interne Darstellung der aktuellen Generation
 gameWidth (lesend): Die aktuelle Spielfeldbreite
 gameHeight (lesend): Die aktuelle Spielfeldhöhe
 -------------------------------------------------------------------------}
function getCellState(x: TGameWidth; y: TGameHeight): boolean;

begin
  //Wenn die Zelle im aktuellen Bereich ist und TRUE, dann TRUE, sonst FALSE
  //CurGen[x,y] := (x <= GameWidth) AND (y <= GameHeight) AND CurGen[x,y];
  getCellState := (x <= GameWidth) AND (y <= GameHeight) AND CurGen[x,y];

end;

{-------------------------------------------------------------------------
 Berechnet die nächste Generation des Spielfeldes.
 ----------------------------------------------------------------------
 globale Zugriffe :
 curGen (schreibend): Die interne Darstellung der aktuellen Generation
 -------------------------------------------------------------------------}
procedure nextGen;

var
 AktHoehe, AktBreite : byte;
 TempGen : TGameField;
 DurchlAbzugH : byte;
 DurchlAbzugW : byte;

  function Nachbarn(x,y:integer) : byte;
  var
    I, J : smallint;
    xred, xexp, yred, yexp : smallint;
    NachbarCount : byte;
  begin
    //Die zu überprüfenden Zellen nach Moore (die 8 umliegenden)
    xred := -1;
    xexp := 1;
    yred := -1;
    yexp := 1;
    //Einschränkungen der MooreNachbarschaftsprüfung an den Ecken und Kanten
    if y  = low(TGameHeight) then yred := 0;
    if y  = high(TGameHeight) then yexp := 0;
    if x  = low(TGameWidth) then xred := 0;
    if x  = high(TGameWidth) then xexp := 0;
    //Überprüfung der Nachbarschaft (im Normalfall die umliegenden 8 Felder)
    //Wenn ein Nachbarfeld TRUE (lebt) ist, dann NachbarCount + 1
    NachbarCount := 0;
    for I := yred to yexp do
    begin
      for J := xred to xexp do
      begin
        if (I <> 0) OR (J <> 0) then
        begin
          if getCellState(x+J,y+I) then NachbarCount := NachbarCount + 1;
        end;
      end;
    end;
  Nachbarn := NachbarCount;
  end;
//------------ Unterfunktionen ende

//Anwendung der Game of Live-Regeln
//Alle Sichtbaren Felder werden entsprechend der Regeln berechnet
begin

  //Grenzt die Anzahl der Schleifendurchläufe aufs Minimum ein
  if high(TGameHeight) = getHeight() then DurchlAbzugH := 0
   else DurchlAbzugH := high(TGameHeight) - getHeight()-1;
  if high(TGameWidth) = getWidth() then DurchlAbzugW := 0
   else DurchlAbzugW := high(TGameWidth) - getWidth()-1;

  for AktHoehe := low(TGameHeight) to high(TGameHeight)-DurchlAbzugH do
  begin
    for AktBreite := low(TGameWidth) to high(TGameWidth)-DurchlAbzugW do
    begin
    TempGen[AktBreite,AktHoehe] := FALSE;
    if (AktHoehe <= getHeight()) AND (AktBreite <= getWidth())  then
    begin
     //Wenn 3 Nachbarn dann TRUE oder Wenn vorher TRUE + 2 Nachbarn dann TRUE
     TempGen[AktBreite,AktHoehe] := (Nachbarn(AktBreite,AktHoehe) = 3) or
     (CurGen[AktBreite,AktHoehe] and (Nachbarn(AktBreite,AktHoehe) = 2));
    end;
    end;
  end;
  curGen := TempGen;
end;

end.

