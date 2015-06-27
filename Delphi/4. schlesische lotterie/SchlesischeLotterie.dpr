program SchlesischeLotterie;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uGame in 'uGame.pas',
  uTypes in 'uTypes.pas',
  uConst in 'uConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
