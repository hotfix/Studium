//-------------------------------------------------------------
// Optionen Unit
// Steuerung der Optionen des Spiels
// erstellt von: Alexander Albrant(winf2862)
// am: 17.04.2007
//-------------------------------------------------------------
unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFrmoptionen = class(TForm)
    RdGrpGameType: TRadioGroup;
    ChkBxLog: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    //Get spiel variante
    function getGameType () : integer;
     //Get Log
    function getLog () : boolean;
    //setzte Spiel variante
    procedure setGameType (gameType : integer);
    //Setzte log wert
    procedure setLog (log : boolean);
  end;

var
  Frmoptionen: TFrmoptionen;

implementation

{$R *.dfm}

function TFrmoptionen.getGameType () : integer;
begin
  getGameType := RdGrpGameType.ItemIndex;
end;


function TFrmoptionen.getLog () : boolean;
begin
  getLog := ChkBxLog.Checked;
end;


procedure TFrmoptionen.setGameType (gameType : integer);
begin
  RdGrpGameType.ItemIndex := gameType;
end;


procedure TFrmoptionen.setLog (log : boolean);
begin
  ChkBxLog.Checked := log;
end;
end.

