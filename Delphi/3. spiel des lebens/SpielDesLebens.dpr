program SpielDesLebens;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uTypes in 'uTypes.pas',
  uGameLogic in 'uGameLogic.pas',
  uGames in 'uGames.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
