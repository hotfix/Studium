//  Unit u_tools:
//  Diese Unit enthält Routinen zum Test auf Vorhandensein von Dateien, Entdecken und
//  Entfernen von Schreibschutz sowie Dialoge mit dem Warnen vor Überschreiben
//


unit UTools;

interface

function DateiExistiert(const dateiname: string): boolean;
//  Prüft, ob eine Datei, die geöffnet werden soll, vorhanden ist
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertOeffen (boolean): true - Datei existiert, false - tut's nicht

function DateiExistiertSpeichern(const dateiname: string): boolean;
//  Prüft, ob eine Datei, in die gespeichert werden soll, schon existiert und wenn ja,
//  wird gefragt, ob diese überschrieben werden soll.
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertSpeichern (boolean): true - vorhanden, false - nicht vorhanden od. überschreibbar

procedure DateiOeffnenFileMode(modus: boolean);
//  Setzt den File Mode auf 'nur lesen' bzw. 'lesen/schreiben', dient dazu, exceptions
//  beim Öffnen schreibgeschützter Dateien zu verhindern
//  -> modus (boolean): true - 'nur lesen', false - 'lesen/schreiben'

function Schreibschutz(const dateiname: string): boolean;
//  Stellt fest, ob eine Datei schreibgeschützt ist
//  -> dateiname (String, const): Pfad&Dateiname der zu prüfenden Datei
//  <- schreibgeschuetzt (boolean): true - Schreibschutz vorhanden

function SchreibschutzEntfernt(const dateiname: string): boolean;
//  Entfernt, wenn Datei schreibgeschützt, auf Wunsch des Nutzers den Schreibschutz
//  -> dateiname (string, const): die betreffende Datei
//  <- keinSchreibschutz (boolean): true - Schreibschutz nicht (mehr) vorhanden, false - geschützt

implementation

uses sysUtils, dialogs, controls;


function Schreibschutz(const dateiname: string): boolean;
//  Stellt fest, ob eine Datei schreibgeschützt ist
//  -> dateiname (String, const): Pfad&Dateiname der zu prüfenden Datei
//  <- schreibgeschuetzt (boolean): true - Schreibschutz vorhanden
begin
  Schreibschutz := ((sysutils.FileGetAttr(Dateiname) and sysutils.faReadOnly) = sysutils.faReadOnly);
end;


function SchreibschutzEntfernt(const dateiname: string): boolean;
//  Entfernt, wenn Datei schreibgeschützt, auf Wunsch des Nutzers den Schreibschutz
//  -> dateiname (string, const): die betreffende Datei
//  <- keinSchreibschutz (boolean): true - Schreibschutz nicht (mehr) vorhanden, false - geschützt
  var entfernt: integer;
      Schutz : boolean;
begin
  Schutz := false;
  if FileExists(dateiname) then
  begin
    Schutz := Schreibschutz(Dateiname);
    if Schutz then
    begin
      Schutz := MessageDlg('Die Datei ist schreibgeschützt, soll der Schreibschutz entfernt werden?',
                           mtConfirmation, [mbYes, mbNo], 0) <> mrYes;
      if not Schutz then
        entfernt := sysutils.FileSetAttr(dateiname, (sysutils.FileGetAttr(dateiname) and not sysutils.faReadOnly));
    end;
  end;
  SchreibschutzEntfernt := not Schutz;
end;


function DateiExistiert(const dateiname: string): boolean;
//  Prüft, ob eine Datei vorhanden ist und erstellte diese ggf
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertOeffen (boolean): true - Datei existiert, false - tut's nicht
begin
  if not FileExists(dateiname) then
    showmessage('Die Datei'+#13+#13+dateiname+#13+#13+'wird neu erstellt!');
  DateiExistiert := FileExists(dateiname);
end;


function DateiExistiertSpeichern(const dateiname: string): boolean;
//  Prüft, ob eine Datei, in die gespeichert werden soll, schon existiert und wenn ja,
//  wird gefragt, ob diese überschrieben werden soll.
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertSpeichern (boolean): true - vorhanden, false - nicht vorhanden od. überschreibbar
  var existiert : boolean;
begin
  existiert := FileExists(Dateiname);
  if existiert then
    existiert := MessageDlg('Die Datei ist vorhanden, soll die Datei ' +
      'überschrieben werden?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes;
  DateiExistiertSpeichern := existiert;
end;


procedure DateiOeffnenFileMode(modus: boolean);
//  Setzt den File Mode auf 'nur lesen' bzw. 'lesen/schreiben', dient dazu, exceptions
//  beim Öffnen schreibgeschützter Dateien zu verhindern
//  -> modus (boolean): true - 'nur lesen', false - 'lesen/schreiben'
begin
  if modus then
    FileMode := fmOpenRead
  else
    FileMode := fmOpenReadWrite;
end;



end.
