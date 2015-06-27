unit UDatei;

interface

uses UTypes;

function DatensatzDateiLadenOeffnen(Dateiname: string): boolean;
function DatensatzDateiSpeichernOeffnen(Dateiname: string): boolean;
procedure DatensatzDateiSchliessen;
function DatensatzLesen: TOneSong;
procedure DatensatzSchreiben(Datensatz: TOneSong);
function ErsterDatensatz: longint;
function LetzterDatensatz: longint;
function EndOfFile : boolean;

implementation

uses UTools, dialogs, sysutils;

type TDatensatzDatei = file of TOneSong;
     TTestDatensatzDatei = file of Byte;

var DatensatzDatei: TDatensatzDatei;


function DatensatzDateiGueltig(var TestDatensatzDatei: TTestDatensatzDatei): boolean;
begin
  DatensatzDateiGueltig := (filesize(TestDatensatzDatei) mod sizeof(TOneSong) = 0) and (filesize(TestDatensatzDatei) > 0);
end;


function DatensatzDateiLadenOeffnen(Dateiname: string): boolean;
  var Erfolg: boolean;
      TestDatensatzDatei: TTestDatensatzDatei;
begin
  assign(TestDatensatzDatei, Dateiname);
  Erfolg := DateiExistiert(Dateiname) and SchreibschutzEntfernt(Dateiname);

  if Erfolg then
  begin
    reset(TestDatensatzDatei);
    Erfolg := DatensatzDateiGueltig(TestDatensatzDatei);
    Close(TestDatensatzDatei);
    if Erfolg then
    begin
      assign(DatensatzDatei, Dateiname);
      reset(DatensatzDatei);
    end;
  end;

  DatensatzDateiLadenOeffnen := Erfolg;
end;



function DatensatzDateiSpeichernOeffnen(Dateiname: string): boolean;
  var Erfolg: boolean;
begin
  Erfolg := not DateiExistiertSpeichern(Dateiname);

  if Erfolg then
  begin
    assign(DatensatzDatei, Dateiname);
    rewrite(DatensatzDatei);
  end;

  DatensatzDateiSpeichernOeffnen := Erfolg;
end;



procedure DatensatzDateiSchliessen;
begin
  Close(DatensatzDatei);
end;



function DatensatzLesen: TOneSong;
  var Datensatz: TOneSong;
begin
  read(DatensatzDatei, Datensatz);
  DatensatzLesen := Datensatz;
end;



procedure DatensatzSchreiben(Datensatz: TOneSong);
begin
  write(DatensatzDatei, Datensatz);
end;


function ErsterDatensatz: integer;
begin
  ErsterDatensatz := 0;
end;


function LetzterDatensatz: integer;
begin
  LetzterDatensatz := FileSize(DatensatzDatei);
end;


function EndOfFile : boolean;
begin
  EndOfFile := EOF(Datensatzdatei);
end;


end.
