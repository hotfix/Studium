program Medienverwalltung;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  UTabelle in 'UTabelle.pas' {FrmTabelle},
  UDaten in 'UDaten.pas',
  UTypen in 'UTypen.pas',
  UHTML in 'UHTML.pas',
  UFileTools in 'UFileTools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmTabelle, FrmTabelle);
  Application.Run;
end.
