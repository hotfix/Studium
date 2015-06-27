unit ULogic;

interface

uses UTypes, sysutils;

// �ffnet die Datensatzdatei, bei Erfolg = true;
function OpenListFile(listFile : string) : boolean;

// Schlie�t die ge�ffnete Datei und leert die Liste
procedure CloseListFile;

// schlie�t die Datensatzdatei, bei Erfolg = true;
// <- Dateiname : string - zu schreibender Dateiname
procedure SaveListFile(listFile : string);


// liest den Inhalt eines Datensatzes aus der AdressDatei und f�gt diesen
// sortiert in die Liste ein
// procedure ReadList;


// Erstellt ein TOneSong Element
function makeElement(song: TTitle) : TOneSong;


implementation

uses UList, UDatei;

// �ffnet die Datensatzdatei, bei Erfolg = true;
function OpenListFile(listFile : string) : boolean;
begin
  OpenListFile := DatensatzDateiLadenOeffnen(listFile);
end;


// Schlie�t die ge�ffnete Datei und leert die Liste
procedure CloseListFile;
begin
  DatensatzdateiSchliessen;
end;


// schlie�t die Datensatzdatei, bei Erfolg = true;
// <- Dateiname : string - zu schreibender Dateiname
procedure SaveListFile(listFile : string);
var marker : PSongs;
begin
  marker := GetFirst;
    if DatensatzdateiSpeichernOeffnen(listFile) then
    if marker <> nil then
      while marker^.Next <> nil do
      begin
        DatensatzSchreiben(Marker^.info);
        marker := marker^.Next;
      end;
      DatensatzSchreiben(Marker^.info);
end;

          {
// liest den Inhalt eines Datensatzes aus der AdressDatei und f�gt diesen
// sortiert in die Liste ein
procedure ReadList;
begin
  DeInitList;
  while not EndOfFile do
  begin
    addElement(DatensatzLesen);
  end;
end;     }


// Erstellt ein TOneSong Element
function makeElement(song: TTitle) : TOneSong;
begin
    makeElement.Title := song;
    makeElement.ID    := NumberOfElements+1;
end;




end.
