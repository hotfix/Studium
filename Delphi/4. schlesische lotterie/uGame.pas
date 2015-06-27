{------------------------------------------------------------------------------
 Spiellogik

 Autor: Philip Lehmann-Böhm, 22.03.2007
 Bearbeitet von: Bastian Terfloth und Alexander Albrant
 ---------------------
 Beinhaltet Funktionen und Prozeduren zur Berechnung der Spiellogik
 ------------------------------------------------------------------------------}
unit uGame;

interface

uses
  uTypes;

function cardToStr(card: TCards): string;
function cardInDeck(card: TCards): boolean;
function playGame(var gewinn: integer): TGameResult;
function getMoney: integer;
function addCardToOwnDeck: boolean;
procedure initGame;
procedure emptyDeck;
procedure decDeckMoney;
function checkDeckMoney: boolean;
//--Eigene Funktionen und Prozeduren
function GetCardCount(): byte;
function CheckDrawPossible(): boolean;
function CalcWinFactor(Card : TCards; ZugPosition : byte): TWinFactor;


procedure setMoney(newMoney:integer);

implementation

uses
  uConst;

type
  // Ein Kartendeck, reprдsentiert entweder einen Kartenstapel oder ein Blatt.
  TCardDeck = set of TCards;

var
  // Das eigene Blatt
  ownDeck: TCardDeck;
  // Das Vermögen
  money: integer;

{-------------------------------------------------------------------------
 Wandelt eine (Enum-)Karte in einen String um.
 ----------------------------------------------------------------------
 x (in): Die Karte
 ----------------------------------------------------------------------
 Rückgabewert (out): Der Kartenname
 ----------------------------------------------------------------------
 globale Zugriffe:
 cCardNames (lesend): Das Konstantenarray mit den Kartennamen
 -------------------------------------------------------------------------}
function cardToStr(card: TCards): string;
begin
  cardToStr := cCardNames[integer(card)];
end;

{-------------------------------------------------------------------------
 Leert das eigene Blatt.
 ----------------------------------------------------------------------
 globale Zugriffe :
 ownDeck (schreibend): Das eigene Blatt
 -------------------------------------------------------------------------}
procedure emptyDeck;
begin
  ownDeck := [];
end;

{-------------------------------------------------------------------------
 Initialisiert das Spiel: Das eigene Blatt leeren und das Vermögen auf den
 Startwert setzen.
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (schreibend): Das eigene Vermögen
 -------------------------------------------------------------------------}
procedure initGame;
begin
  //Das eigene Blatt leeren
  emptyDeck();
  //Vermögen auf Startwert setzen
  Money := cStartMoney;
end;

{-------------------------------------------------------------------------
 Fügt eine Karte dem eigenen Blatt hinzu, wenn noch genügend Geld da ist und
 das Blatt nicht schon aus allen 32 Karten besteht.
 ----------------------------------------------------------------------
 Rückgabewert (out): Das Hinzufügen hat geklappt.
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (lesend/schreibend): Das eigene Vermögen
 ownDeck (lesend/schreibend): Das eigene Blatt
 -------------------------------------------------------------------------}
function addCardToOwnDeck: boolean;
var
  Card : TCards;

begin
  if CheckDrawPossible() then
  begin
    //liefert eine Karte in eigenes Blatt
    repeat
      card := TCards(random(cCardCount));
    until NOT(cardInDeck(card));
    ownDeck := ownDeck + [card]; //fügt die karte hinzu
    addCardToOwnDeck := TRUE;
    money := money - cCardCost;  //verkleiner das vermögen
  end
  else
    addCardToOwnDeck := FALSE;
end;

{-------------------------------------------------------------------------
 Prüft, ob eine Karte in dem eigenen Blatt ist.
 ----------------------------------------------------------------------
 Rückgabewert (out): Ebendies
 ----------------------------------------------------------------------
 globale Zugriffe:
 ownDeck (lesend): Das eigene Blatt
 -------------------------------------------------------------------------}
function cardInDeck(card: TCards): boolean;
begin
  cardInDeck :=  card in ownDeck;
end;

{-------------------------------------------------------------------------
 Liefert das Vermögen.
 ----------------------------------------------------------------------
 Rückgabewert (out): Ebendies
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (lesend): Das eigene Vermögen
 -------------------------------------------------------------------------}
function getMoney: integer;
begin
  getMoney := Money;
end;

{-------------------------------------------------------------------------
 Setzt das Vermögen.
 ----------------------------------------------------------------------
 Rückgabewert (out): Ebendies
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (schreibend): Das eigene Vermögen
 -------------------------------------------------------------------------}
procedure setMoney(newMoney:integer);
begin
  money := newMoney;
end;

{-------------------------------------------------------------------------
 ührt die Ziehung durch und aktualisiert das Vermögen.
 ----------------------------------------------------------------------
 Rückgabewert (out): Die gezogenen Karten
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (schreibend): Das eigene Vermögen
 ownDeck (lesend): Das eigene Blatt
 -------------------------------------------------------------------------}
function playGame(var gewinn: integer): TGameResult;
var
  DealerCards : TCardDeck;
  DrawNr : byte;
  card : TCards;
  SortedDraw : TGameResult;
begin
  DealerCards := [k7, k8, k9, kb, kd, kk, k10, ka,
                  h7, h8, h9, hb, hd, hk, h10, ha,
                  p7, p8, p9, pb, pd, pk, p10, pa,
                  kr7, kr8, kr9, krb, krd, krk, kr10, kra];
  for DrawNr := 0 to 8 do
  begin
    repeat
      card := TCards(random(cCardCount));
    until (card in DealerCards);
    DealerCards := DealerCards - [card];
    //Wenn die vom Dealer gezogene Karte im eigenen Blatt ist, dann
    //wird ein Gewinn ausgeschüttet
    if cardInDeck(card ) then
    begin
      //Gewinn (ausschüttung )
      gewinn := gewinn + CalcWinfactor(Card,DrawNr) * cCardCost;
    end;
    //Die gezogenen Karten werden in einem Array gespeichert -> stringAusgabe
    SortedDraw[DrawNr] := cardToStr(card);
  end;
  playGame := SortedDraw;
end;

{-------------------------------------------------------------------------
 Dekrementiert das Vermögen entsprechend der Anzahl der Karten im Blatt.
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (schreibend): Das eigene Vermögen
 -------------------------------------------------------------------------}
procedure decDeckMoney;
begin
  money := money - GetCardCount() *cCardCost;
end;

{-------------------------------------------------------------------------     t
 Überprüft, ob noch genügend Vermögen da ist, um das momentane Blatt
 nochmal zu setzen.
 ----------------------------------------------------------------------
 Rückgabewert (out): Ebendies
 ----------------------------------------------------------------------
 globale Zugriffe:
 money (lesend): Das eigene Vermögen
 ownDeck (lesend ): Das eigene Blatt
 -------------------------------------------------------------------------}
function checkDeckMoney: boolean;
begin
  checkDeckMoney := (GetCardCount * cCardCost) <= Money;
end;

{-------------------------------------------------------------------------
Gibt die Anzahl der Karten (im Blatt) zurück.
--------------------------------------------------------------------------
Rückgabewert (out):Ebendies
--------------------------------------------------------------------------
globale Zugriffe:
ownDeck (lesend): Das eigene Blatt
--------------------------------------------------------------------------}
function GetCardCount( ): byte;
var
  CardCounter : byte;
  I : TCards;
begin
  CardCounter := 0;
  for I := k7 to kra do
   if I in ownDeck then inc(CardCounter);
  GetCardCount := CardCounter;
end;

{--------------------------------------------------------------------------
CheckDrawPossible
---------------------------------------------------------------------------
Rückgabewert (out): Boolean ob es möglich ist noch eine Karte zu ziehen
---------------------------------------------------------------------------
Wenn das Geld für den Kauf einer Karte reicht und
die Karten kleiner sind als CCardCount dann ist CheckDrawPOossible = TRUE
---------------------------------------------------------------------------}
function CheckDrawPossible(): boolean;
begin
  CheckDrawPossible := (GetCardCount() < cCardCount) AND (money >= cCardCost);
end;

{--------------------------------------------------------------------------
CalcWinFactor
---------------------------------------------------------------------------
Rückgabewert (out): Der WinFaktor
---------------------------------------------------------------------------
Der entsprechende Winfaktor in Abhängigkeit des getroffenen Paars wird übergeben
---------------------------------------------------------------------------}
function CalcWinfactor(Card : TCards; ZugPosition : byte): TWinFactor;
var
  WinFactor : TWinFactor;
begin
  Winfactor := CWinFactors[0];
  case ZugPosition of
   0..1 : WinFactor := CWinFactors[0];
   2..3 : WinFactor := CWinFactors[1];
   4..5 : WinFactor := CWinFactors[2];
   6..7 : WinFactor := CWinFactors[3];
   8    : WinFactor := CWinFactors[4];
  end;
  CalcWinfactor := WinFactor;
end;

initialization
  randomize;

end.
