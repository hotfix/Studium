//-------------------------------------------------------------
// Log Unit
// Ausgabe des Logs auf dem Formular
// erstellt von: Alexander Albrant(winf2862)
// am: 17.04.2007
//-------------------------------------------------------------
unit uLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmLog = class(TForm)
    MemLog: TMemo;
    procedure MemLogChange(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    //Löscht die Logs
    procedure LogDelete ();
    //Fügt eine neue Logzeile hinzu
    procedure LineAdd(gametype:integer; SetWert, wert1, wert2,
                        wert3, betrag, vermoegen : string);
  end;

var
  FrmLog: TFrmLog;

implementation

{$R *.dfm}
//Methode Clear
//Löscht die Logs beim neuen Spiel
procedure TFrmLog.LogDelete ();
begin
    MemLog.Lines.Clear;
end;

procedure TFrmLog.MemLogChange(Sender: TObject);
begin

end;

//Methode Add
//Fügt eine neue Logzeile bei jedem Zug
procedure TFrmLog.LineAdd(gametype:integer; SetWert, wert1, wert2,
                        wert3, betrag, vermoegen : string);
var
  dummy : integer;
  game: string;
begin
//Beim singel Spiel  und Field
  if gametype = 0 then
  begin
    game := 'Tipp';
    dummy := MemLog.Lines.Add(game+': ' +SetWert +'; gewürfelt: '+wert1+' '
                        +wert2+' '+wert3+'; gesetzt: '+betrag+'; neues Vermögen: '
                          +vermoegen);
  end
  else
  begin
    game := 'Field';
    dummy :=
        MemLog.Lines.Add(game+': gewürfelt: '+wert1+' '+wert2+' '+wert3+' = '+
                        IntToStr(StrToInt(wert1)+StrToInt(wert2)+StrToInt(wert3))
                        +'; gesetzt: '+betrag+'; neues Vermögen: ' +vermoegen);
  end;
end;
end.
