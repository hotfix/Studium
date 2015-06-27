//-----------------------------------------------------------------
// UDaten ist eine Unit welche Funktionen und Prozeduren zur Bearbeitung
// von Daten zur Verfügung stellt
//-----------------------------------------------------------------
// Erstellt von: Bastian Terfloth und Alexander Albrant
//           am: 12.06.07
//      Version: 1.01
//-----------------------------------------------------------------

unit UDaten;

interface
   uses UTypen,SysUtils;


  {Neue Funktionen und Prozeduren}
  function BubbleSort(SortBy : TMerkmal):boolean;
  function OeffneDatei(Dateiname : String; schreibgeschuetzt : Boolean) : Boolean;
  function getMedium (Nummer : TNummer) : TMedium;
  function Dateierstellen(Dateiname : String) : Boolean;
  function setMedium (Nummer : TNummer; Medium : TMedium; Add : boolean): boolean;
  function SchliesseDatei : Boolean;
  function GetMaxID():integer;
  procedure InitMaxID;
  function CheckEndOfFile():boolean;
  procedure incMaxID();
  function GetRecordSize():byte;
  function getFuellstand() : Cardinal;

implementation

var
  MaxID : TID;
  Datei : file of TMedium;

{-----------------------------------------------------------------
Ermittelt die größe eines Records
------------------------------------------------------------------}
function GetRecordSize():byte;
begin
  GetRecordSize := SizeOf(TMedium);
end;

{-----------------------------------------------------------------
Offnet die datei und fängt fehler bei schreibschutz ab
------------------------------------------------------------------}
function OeffneDatei(Dateiname : String; schreibgeschuetzt : Boolean) : Boolean;
begin
  OeffneDatei := TRUE;
  try
   if schreibgeschuetzt then
     System.FileMode := fmOpenRead
   else
     System.FileMode := fmOpenReadWrite;

   Assign(Datei,Dateiname);
   if FileExists(Dateiname) then
     Reset(Datei)
   else
     Rewrite(Datei);

   MaxID := FileSize(Datei); //Beim Öffnen die Dateigrösse übergeben
   System.FileMode := fmOpenReadWrite;
  except
   OeffneDatei := FALSE;
  end;
end;

{-----------------------------------------------------------------
ein Medium an einer bestimmten Stelle wird ausgelesen
------------------------------------------------------------------}
function getMedium (Nummer : TNummer) : TMedium;
var
 TempMedium : TMedium;
begin
  seek(Datei,Nummer);
  Read(Datei,TempMedium);
  seek(Datei,Nummer);
  getMedium := TempMedium;
end;

{-----------------------------------------------------------------
Erstellt eine Datei und setzt die MaxID auf 0
------------------------------------------------------------------}
function Dateierstellen(Dateiname : String) : Boolean;
begin
  Dateierstellen := TRUE;
  try
    AssignFile(Datei,Dateiname);
    ReWrite(Datei);
    MaxID := 0;
  except
    Dateierstellen := FALSE;
  end;
end;

{-----------------------------------------------------------------
Datei wird geschlossen
------------------------------------------------------------------}
function SchliesseDatei : Boolean;
begin
  SchliesseDatei := TRUE;
  try
      Close(Datei);
  except
    SchliesseDatei := FALSE;
  end;
end;

{-----------------------------------------------------------------
MaxID wird inkrementiert
------------------------------------------------------------------}
procedure incMaxID();
begin
  MaxID := MaxID + 1;
end;

{-----------------------------------------------------------------
Medium wird gespeichert und ggf wird MaxID erhöht
------------------------------------------------------------------}
{-----------------------------------------------------------------
Medium wird gespeichert und ggf wird MaxID erhöht
------------------------------------------------------------------}
function setMedium (Nummer : TNummer; Medium : TMedium; Add : boolean): boolean;
begin
  SetMedium := TRUE;
  try
    seek(Datei,Nummer);
    write(Datei,Medium);
    seek(Datei,Nummer);
    if Add then
      incMaxID();
  except
    SetMedium := FALSE;
  end;
end;


{-----------------------------------------------------------------
Überprüft ob EOF erreicht wurde
------------------------------------------------------------------}
function CheckEndOfFile():boolean;
begin
  CheckEndOfFile := TRUE;
  try
   CheckEndOfFile := eof(Datei);
  except
   CheckEndOfFile := FALSE;
  end;
end;

{-----------------------------------------------------------------
MaxID wird aus der unitglobalen Variable ausgelesen
------------------------------------------------------------------}
function GetMaxID():integer;
begin
  GetMaxID := MaxID;
end;

{-----------------------------------------------------------------
Die Anzahl der Datensätze wird aus der Datei ausgelesen
------------------------------------------------------------------}
function getFuellstand() : Cardinal;
begin
  getFuellstand := FileSize(Datei);
end;

procedure InitMaxID;
begin
  MaxID := 0;
end;

{-----------------------------------------------------------------
Funktion sortiert nach ID wenn mindestens 2 Datensätze vorhanden sind.
Ansonsten wird FALSE zurückgegeben
-----------------------------------------------------------------}
function BubbleSort(SortBy : TMerkmal):boolean;

     function Tausche(j : word):boolean; //gibt FALSE zurück wenn fehler
     var
       Dummy : TMedium;
       KeinFehler1,KeinFehler2 : boolean;
     begin
      Dummy := GetMedium(j);
      KeinFehler1 := setMedium(j,getMedium(j+1),FALSE);
      KeinFehler2 := setMedium(j+1,Dummy,FALSE);
      Tausche := KeinFehler1 AND KeinFehler2;
     end;

var
  i,j : word;
begin

   for i :=low(TNummer) to getFuellStand()-2 do
    for j :=low(TNummer) to getFuellStand()-2 do
    begin
      case SortBy of
        ID : begin
            if  GetMedium(j).ID > GetMedium(j + 1).ID then
            begin
              BubbleSort := Tausche(j);
            end;
             end;
        N : begin
            if  GetMedium(j).Name > GetMedium(j + 1).Name then
            begin
              BubbleSort := Tausche(j);
            end;
        end; //name
        T : begin
            if  GetMedium(j).Typ > GetMedium(j + 1).Typ then
            begin
              BubbleSort := Tausche(j);
            end;
        end; //name
        K : begin
            if  GetMedium(j).Kategorie > GetMedium(j + 1).Kategorie then
            begin
              BubbleSort := Tausche(j);
            end;
        end; //name
       end; //ende Case
       //---
       end;
   BubbleSort := TRUE;
end;

end.
