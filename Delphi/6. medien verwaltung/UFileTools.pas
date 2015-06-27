//-----------------------------------------------------------------
//UFileTools ist eine Unit die erweiterte Prozeduren und Funktionen f�r den
//Umgang mit Dateien zur Verf�gung stellt
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
Funktion �berpr�ft ob die Datei dessen Name �bergeben wurde schreib-
gesch�tzt ist und fragt den Benutzer ggf. ob der Schreibschutz
entfernt werden soll
-----------------------------------------------------------------}
function CheckReadOnly(Dateiname : string):boolean;
var
  ReadOnlyRemoved : boolean;
begin
  if FileIsReadOnly(Dateiname) then
  ReadOnlyRemoved := FileSetReadOnly(Dateiname,
                     MessageDlg('Die Datei ist schreibgesch�tzt '
                                +'Schreibschutz entfernen?',
                                mtInformation, [mbYes, mbNo], 0) = mrNo);
  CheckReadOnly := FileIsReadOnly(Dateiname);
end;


//Ermittle ob filesize(MyDatei) ein Vielfaches von sizeof(TMyDatensatzTyp)
{-----------------------------------------------------------------
Ermittelt ob Die Gr��e der Datei ein Vielfaches der Gr��e eines
Datensatztyps ist und gibt gibt false zur�ck wenns nicht zutrifft
------------------------------------------------------------------
FALSE: Datei ist nicht Kompatibel
TRUE: Datei ist h�chstwarscheinlich kompatibel
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
