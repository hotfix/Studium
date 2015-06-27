//-----------------------------------------------------------------
//UFileTools ist eine Unit die erweiterte Prozeduren und Funktionen für den
//Umgang mit Dateien zur Verfügung stellt
//-----------------------------------------------------------------
// Erstellt von: Bastian Terfloth und Alexander Albrant
//           am: 12.06.07
//      Version: 1.01
//-----------------------------------------------------------------

unit UFileTools;

interface



  function CheckFileSize(Dateiname : string; RecordSize : byte):boolean;
  function CheckReadOnly(Dateiname : string):boolean;

implementation
uses
  SysUtils, Controls, Dialogs, Windows;
{-----------------------------------------------------------------
Funktion überprüft ob die Datei dessen Name übergeben wurde schreib-
geschützt ist und fragt den Benutzer ggf. ob der Schreibschutz
entfernt werden soll
-----------------------------------------------------------------}
function CheckReadOnly(Dateiname : string):boolean;
var
  ReadOnlyRemoved : boolean;
begin
  if FileIsReadOnly(Dateiname) then
  ReadOnlyRemoved := FileSetReadOnly(Dateiname,
                     MessageDlg('Die Datei ist schreibgeschützt '
                                +'Schreibschutz entfernen?',
                                mtInformation, [mbYes, mbNo], 0) = mrNo);
  CheckReadOnly := FileIsReadOnly(Dateiname);
end;


//Ermittle ob filesize(MyDatei) ein Vielfaches von sizeof(TMyDatensatzTyp)
{-----------------------------------------------------------------
Ermittelt ob Die Größe der Datei ein Vielfaches der Größe eines
Datensatztyps ist und gibt gibt false zurück wenns nicht zutrifft
------------------------------------------------------------------
FALSE: Datei ist nicht Kompatibel
TRUE: Datei ist höchstwarscheinlich kompatibel
-----------------------------------------------------------------}
function CheckFileSize(Dateiname:string;RecordSize:byte):boolean;
var
  CheckDatei : file of byte;
begin
  CheckFileSize := TRUE;
  try
    System.FileMode := fmOpenRead;
    AssignFile (CheckDatei, DateiName);
    Reset(CheckDatei);
    System.FileMode := fmOpenReadWrite;
    CheckFileSize := (FileSize(CheckDatei) Mod RecordSize) = 0;
    Close(CheckDatei);
  except
    CheckFileSize := FALSE;
  end;
end;

end.
