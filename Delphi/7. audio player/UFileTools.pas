unit UFileTools;
//Dateiroutinen, die in verschiedenen Projekten nьtzlich sein kцnnten

interface
  function IsStillReadOnly (FileName: string): boolean;
  // prьft, ob Schreibschutz besteht, wenn Benutzer dies wьnscht, hebt er ihn auf
  // Rьck: True, wenn hinterher noch Schreibschutz besteht
  function StillReadOnlySave(FileName : string) : boolean;

  function IsCorrectFileSize (FileName : String; Recordgroesse : Integer)  :Boolean;
  //  Prьft, ob eine Datei eine gьltige GrцЯe hat

  function CorrectFileName(FileName : string; FileTyp : string): boolean;

implementation
uses
  SysUtils, Dialogs, Controls, windows;

function IsStillReadOnly (FileName: string): boolean;
// prьft, ob Schreibschutz besteht, wenn Benutzer dies wьnscht, hebt er ihn auf
// Rьck: True, wenn hinterher noch Schreibschutz besteht
begin
  if FileExists(FileName) then
  begin
    if (FileIsReadOnly(FileName)) then
      if (MessageDlg ('Datei ist schreibgeschützt, soll der Schreibschutz entfernt werden ?',
               mtInformation, [mbYes, mbNo], 0) = mrYes) then
      begin
        FileSetReadOnly(FileName,false); //Setze Attribut auf schreibbar
        IsStillReadOnly := false;
      end
      else
        IsStillReadOnly := true;
  end;
end;

function StillReadOnlySave(FileName : string) : boolean;
begin
  if (FileIsReadOnly(FileName)) then
    if (MessageDlg ('Datei ist schreibgeschützt, soll der Schreibschutz entfernt werden ?',
             mtInformation, [mbYes, mbNo], 0) = mrYes) then
    begin
      FileSetReadOnly(FileName,false); //Setze Attribut auf schreibbar
      StillReadOnlySave := false;
    end
    else
      StillReadOnlySave := true;
end;

{Prьft, ob eine Datei eine gьltige GrцЯe hat
GrцЯe ist gьltig, wenn die FileSize ein Vielfaches der GrцЯe der zu speichern-
den Elemente ist
IN: Dateiname: Der Name der zu prьfenden Datei
    Recordgroesse: Die GrцЯe einer zu speicherbaren Figur}
function IsCorrectFileSize (FileName : String; Recordgroesse : Integer)  :Boolean;
var
  CheckDatei : file of byte;
begin
  //IsCorrectFileSize := TRUE;
  try
    System.FileMode := fmOpenRead;
    AssignFile (CheckDatei, FileName);
    Reset(CheckDatei);
    System.FileMode := fmOpenReadWrite;
    IsCorrectFileSize := ((FileSize(CheckDatei) Mod Recordgroesse) = 0) AND
                          (FileSize(CheckDatei) > 0);
    Close(CheckDatei);
  except
    IsCorrectFileSize := FALSE;
  end;
end; //IsCorrectFileSize




function CorrectFileName(FileName : string; FileTyp : string): boolean;
begin
    CorrectFileName := (Filename <> '') AND
                       (pos (FileTyp, AnsiUpperCase(FileName)) =
                                                          length(FileName) - 3);
end;


end.
