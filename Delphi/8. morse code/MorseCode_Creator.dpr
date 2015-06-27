program MorseCode_Creator;

uses
  Forms,
  UMain in 'UMain.pas' {frm},
  ULogic in 'ULogic.pas',
  UBinTree in 'UBinTree.pas',
  UConst in 'UConst.pas',
  UTypes in 'UTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm, frm);
  Application.Run;
end.
