program Fraktal;

uses
  Forms,
  uMain in 'uMain.pas' {FrmMain},
  uCalc in 'uCalc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
