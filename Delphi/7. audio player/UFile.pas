unit UFile;
// Dateioperationen zu Übung 8
interface

// Kapselt gesamtes Einlesen der Datei + Anhängen an Liste
function getFileContent(aFile : string) : boolean;

// Holt Daten aus Liste und schreibt sie in die Datei
function setFileContent(aFile : string): boolean;


implementation

uses UTypes, UList, UFileTools, SysUtils, Dialogs, Windows;

type
  TFileType = file of TOneSong;

  // Kapselt gesamtes Einlesen der Datei + Anhängen an Liste
function getFileContent(aFile : string) : boolean;
var
  Playlist : file of TOneSong;
  Temp : TOneSong;
  oldFileMode: Byte;
begin
  getFileContent := FALSE;
  AssignFile(Playlist, aFile);
  if IsCorrectFileSize(aFile, SizeOf(Temp)) then
  begin
    DeInitList();
    oldFileMode := System.FileMode;
    System.FileMode := fmOpenRead;
    Reset(Playlist);
    System.FileMode := oldFileMode;
    while not Eof(Playlist) do
    begin
      read(Playlist, Temp);
      AddElement(Temp);
    end;
    CloseFile(Playlist);
    getFileContent := TRUE;
  end  //correct file size
  else
    GetFileContent := FALSE;
end;


// Holt Daten aus Liste und schreibt sie in die Datei
function setFileContent(aFile : string): boolean;
var
  Playlist : file of TOneSong;
  pos : cardinal;
  temp : TOneSong;
  DoWrite : Boolean;
begin
  try
    DoWrite := False;
    if NOT(FileExists(aFile)) then
    begin
      AssignFile(Playlist,aFile);
      Rewrite(Playlist);
      DoWrite := True;
    end
    else
    begin
      AssignFile(Playlist,aFile);
     // if not FileSetReadOnly(aFile, False) then
     if not IsStillReadOnly(aFile) then

      begin
        Erase(Playlist);
        AssignFile(Playlist, aFile);
        Rewrite(Playlist);
        DoWrite := True;
      end;
    end;

    if DoWrite then
    begin
      for pos := 0 to NumberOfElements()-1 do
      begin
       temp := getInfo(pos+1);
       write(Playlist,temp);
      end;

      Close(Playlist);
    end;
    setFileContent := DoWrite;
  except
    setFileContent := FALSE;
  end;
end; //setFileContent
end.
