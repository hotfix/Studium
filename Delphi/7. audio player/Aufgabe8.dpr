program Aufgabe8;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UList in 'UList.pas',
  UTypes in 'UTypes.pas',
  UFile in 'UFile.pas',
  UFileTools in 'UFileTools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'John Player';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
