//  Unit u_tools:
//  Diese Unit enth�lt Routinen zum Test auf Vorhandensein von Dateien, Entdecken und
//  Entfernen von Schreibschutz sowie Dialoge mit dem Warnen vor �berschreiben
//


unit UTools;

interface

function DateiExistiert(const dateiname: string): boolean;
//  Pr�ft, ob eine Datei, die ge�ffnet werden soll, vorhanden ist
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertOeffen (boolean): true - Datei existiert, false - tut's nicht

function DateiExistiertSpeichern(const dateiname: string): boolean;
//  Pr�ft, ob eine Datei, in die gespeichert werden soll, schon existiert und wenn ja,
//  wird gefragt, ob diese �berschrieben werden soll.
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertSpeichern (boolean): true - vorhanden, false - nicht vorhanden od. �berschreibbar

procedure DateiOeffnenFileMode(modus: boolean);
//  Setzt den File Mode auf 'nur lesen' bzw. 'lesen/schreiben', dient dazu, exceptions
//  beim �ffnen schreibgesch�tzter Dateien zu verhindern
//  -> modus (boolean): true - 'nur lesen', false - 'lesen/schreiben'

function Schreibschutz(const dateiname: string): boolean;
//  Stellt fest, ob eine Datei schreibgesch�tzt ist
//  -> dateiname (String, const): Pfad&Dateiname der zu pr�fenden Datei
//  <- schreibgeschuetzt (boolean): true - Schreibschutz vorhanden

function SchreibschutzEntfernt(const dateiname: string): boolean;
//  Entfernt, wenn Datei schreibgesch�tzt, auf Wunsch des Nutzers den Schreibschutz
//  -> dateiname (string, const): die betreffende Datei
//  <- keinSchreibschutz (boolean): true - Schreibschutz nicht (mehr) vorhanden, false - gesch�tzt

implementation

uses sysUtils, dialogs, controls;


function Schreibschutz(const dateiname: string): boolean;
//  Stellt fest, ob eine Datei schreibgesch�tzt ist
//  -> dateiname (String, const): Pfad&Dateiname der zu pr�fenden Datei
//  <- schreibgeschuetzt (boolean): true - Schreibschutz vorhanden
begin
  Schreibschutz := ((sysutils.FileGetAttr(Dateiname) and sysutils.faReadOnly) = sysutils.faReadOnly);
end;


function SchreibschutzEntfernt(const dateiname: string): boolean;
//  Entfernt, wenn Datei schreibgesch�tzt, auf Wunsch des Nutzers den Schreibschutz
//  -> dateiname (string, const): die betreffende Datei
//  <- keinSchreibschutz (boolean): true - Schreibschutz nicht (mehr) vorhanden, false - gesch�tzt
  var entfernt: integer;
      Schutz : boolean;
begin
  Schutz := false;
  if FileExists(dateiname) then
  begin
    Schutz := Schreibschutz(Dateiname);
    if Schutz then
    begin
      Schutz := MessageDlg('Die Datei ist schreibgesch�tzt, soll der Schreibschutz entfernt werden?',
                           mtConfirmation, [mbYes, mbNo], 0) <> mrYes;
      if not Schutz then
        entfernt := sysutils.FileSetAttr(dateiname, (sysutils.FileGetAttr(dateiname) and not sysutils.faReadOnly));
    end;
  end;
  SchreibschutzEntfernt := not Schutz;
end;


function DateiExistiert(const dateiname: string): boolean;
//  Pr�ft, ob eine Datei vorhanden ist und erstellte diese ggf
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertOeffen (boolean): true - Datei existiert, false - tut's nicht
begin
  if not FileExists(dateiname) then
    showmessage('Die Datei'+#13+#13+dateiname+#13+#13+'wird neu erstellt!');
  DateiExistiert := FileExists(dateiname);
end;


function DateiExistiertSpeichern(const dateiname: string): boolean;
//  Pr�ft, ob eine Datei, in die gespeichert werden soll, schon existiert und wenn ja,
//  wird gefragt, ob diese �berschrieben werden soll.
//  -> dateiname (string, const): die betreffende Datei
//  <- dateiExistiertSpeichern (boolean): true - vorhanden, false - nicht vorhanden od. �berschreibbar
  var existiert : boolean;
begin
  existiert := FileExists(Dateiname);
  if existiert then
    existiert := MessageDlg('Die Datei ist vorhanden, soll die Datei ' +
      '�berschrieben werden?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes;
  DateiExistiertSpeichern := existiert;
end;


procedure DateiOeffnenFileMode(modus: boolean);
//  Setzt den File Mode auf 'nur lesen' bzw. 'lesen/schreiben', dient dazu, exceptions
//  beim �ffnen schreibgesch�tzter Dateien zu verhindern
//  -> modus (boolean): true - 'nur lesen', false - 'lesen/schreiben'
begin
  if modus then
    FileMode := fmOpenRead
  else
    FileMode := fmOpenReadWrite;
end;



end.
