unit UDaten;

interface
   uses UTypen;


  function GetNewDataCount():word;
  procedure SetNewDataCount(Count : word);
  procedure InitNewDataCount();

  function GetMedium(AktArrayIndex : TArraySize):TSingleMedium;

  procedure DSaveMedium(AktArrayIndex : TArraySize; SingleMedium : TSingleMedium);
  //procedure InitDefault(AktArrayIndex : TArraySize);
   function BubbleSort(SortBy : TSortType):boolean;

implementation


var
  NewDataCount : TArraySize; //Anzahl der bisher angelegten Daten
  Medium : TMedium;

{-----------------------------------------------------------------
Diese Funktion ermittelt die Anzahl der bisher manuell angelegten
neuen Datensätze
-----------------------------------------------------------------}
function GetNewDataCount():word;
begin
  GetNewDataCount := NewDataCount;
end;

{-----------------------------------------------------------------
Diese Funktion setzt die Anzahl der bisher manuell angelegten neuen
Datensätze. Sollte genutzt werden, wenn SaveMedium auf einen
neuen Datensatz angewendet wurde. :(
-----------------------------------------------------------------}
procedure SetNewDataCount(Count : word);
begin
  NewDataCount := Count;
end;

{-----------------------------------------------------------------
Diese Prozedur setzt die Anzahl der bereits angelegten Datensätze
auf 0. Weil am Anfang ja noch kein Datensatz angelegt wurde.
-----------------------------------------------------------------}
procedure InitNewDataCount();
begin
  NewDataCount := 0;
end;

{-----------------------------------------------------------------
SetProzeduren: Speichern die Daten Kategorieabhängig im HauptArray
-----------------------------------------------------------------}
procedure DSaveMedium(AktArrayIndex : TArraySize; SingleMedium : TSingleMedium);
begin
  Medium[AktArrayIndex] := SingleMedium;
end;

{-----------------------------------------------------------------
Übergibt den einen aktuellen Datensatz an die UMAIN
-----------------------------------------------------------------}
function GetMedium(AktArrayIndex : TArraySize):TSingleMedium;
begin
   GetMedium := Medium[AktArrayIndex]
end;

{-----------------------------------------------------------------
Funktion sortiert nach ID wenn mindestens 2 Datensätze vorhanden sind.
Ansonsten wird FALSE zurückgegeben
-----------------------------------------------------------------}
function BubbleSort(SortBy : TSortType):boolean;
var
  Dummy: TSingleMedium;
  i,j : word;
begin

   for i :=low(TArraySize)+1 to GetNewDataCount() do
    for j :=low(TArraySize)+1 to GetNewDataCount()-1 do
    begin
    //---
      case SortBy of
        IDS : begin
            if  GetMedium(j).ID > GetMedium(j + 1).ID then
            begin
              Dummy := GetMedium(j);
              Medium[j] := Medium[j + 1];
              Medium[j + 1] := Dummy;
            end;
             end;
        SName : begin
            if  GetMedium(j).Name > GetMedium(j + 1).Name then
            begin
              Dummy := GetMedium(j);
              Medium[j] := Medium[j + 1];
              Medium[j + 1] := Dummy;
            end;
        end; //name
       end; //ende Case
       //---
       end;
   BubbleSort := TRUE;
end;

//---












end.
