program mDice;

uses
  Forms,
  uMain in 'uMain.pas' {FrmMain},
  uOptions in 'uOptions.pas' {Frmoptionen},
  uLog in 'uLog.pas' {FrmLog},
  uCalculate in 'uCalculate.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmoptionen, Frmoptionen);
  Application.CreateForm(TFrmLog, FrmLog);
  Application.Run;
end.
