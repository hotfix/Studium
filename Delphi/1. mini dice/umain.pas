//-------------------------------------------------------------
// Hauptformular Unit
// Steuerung des Hauptformulars
// erstellt von: Alexander Albrant(winf2862)
//               Bastian Terfloth(WInf 8196)
// am: 17.04.2007
//-------------------------------------------------------------

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmMain = class(TForm)
    BtnOptions: TButton;
    BtnWurf: TButton;
    Label1: TLabel;
    LblGameType: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    LblSetWert: TLabel;
    Label4: TLabel;
    EdtVermoegen: TEdit;
    CmbBxSetOn: TComboBox;
    EdtBetrag: TEdit;
    PnlErgebnis: TPanel;
    LblSetField: TLabel;
    LblWurfel1: TLabel;
    LblWurfel2: TLabel;
    LblWurfel3: TLabel;

    procedure EdtBetragKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOptionsClick(Sender: TObject);
    procedure BtnWurfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtBetragExit(Sender: TObject);
  private
    { Private-Deklarationen }

    //Das aktuelle Vermцgen des Spielers
    const Kapital = 35000;
  public
    { Public-Deklarationen }


  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
uses uOptions, uLog, uCalculate;


//Methode OnCreate
procedure TFrmMain.FormCreate(Sender: TObject);
begin
  randomize;
  //Startkapital setzen
  EdtVermoegen.Text := IntToStr(Kapital);
end;


//Procedure die zum öffnen des Optionenformulares dient
// und zum Einlesen der Einstellungen
procedure TFrmMain.BtnOptionsClick(Sender: TObject);
var
  tmpGameType : integer;
  tmpLog : boolean;
begin
  if not FrmLog.Visible then
     Frmoptionen.setLog(false);

  //Temporäre Variablen der Einstellungswerte
  tmpGameType := Frmoptionen.getGameType;
  tmpLog := Frmoptionen.getLog;

  //Falls die einstellungen abgebrochen werden
  //werden die alten Werde behalten
  if Frmoptionen.ShowModal <> mrOk then
  begin
    Frmoptionen.setGameType(tmpGameType);
    Frmoptionen.setLog(tmpLog);
  end;


  // Prüfe welches Spiel gespilt wird,
  //um dazugehöriges Lables
  //und die dazugehörigen Felder beim Setzen auf anzuzeigen
  if Frmoptionen.getGameType = 0 then
  begin
    LblGameType.Caption := 'Single';
    CmbBxSetOn.Visible := true;
    LblSetField.Visible := false ;
    //LblWurfel1.Visible := true;
    //LblWurfel3.Visible := true;
  end else
  begin
    CmbBxSetOn.Visible := false;
    LblSetField.Visible := true;
    LblGameType.Caption :='Field';
    //LblWurfel1.Visible := false;
    //LblWurfel3.Visible := false;
  end;
  //Log aktive, wird das Logfenster angezeigt
  if Frmoptionen.getLog then
    FrmLog.Show
  else
    FrmLog.Hide;
end;

//Methode zum Abfangen einer Falschen eingabe von Beträgen
//Erlaubt nur zahlen von 0-9 und Backspace
procedure TFrmMain.EdtBetragExit(Sender: TObject);
var
  dummy:integer;
begin
    if not TryStrToInt(EdtBetrag.Text, dummy)then
    begin
      ShowMessage('Kein Betrag gesetzt!');
      EdtBetrag.Text := '10';
    end;
end;

procedure TFrmMain.EdtBetragKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#48..#57, #8]) then key := #0;
end;



//Methode Button Wurf klick
//Random zuweisung der wurfwerte der 3 würfel
//single: treffer ausrechnung
//field: berechnung der summe
procedure TFrmMain.BtnWurfClick(Sender: TObject);

var i,j: byte;
    wurf : array [1..3] of integer;
    gWerte : set of byte;
    gewonnen : boolean;
    summe : string;

begin

//Ist der gesetzte betrag auch wirklick kleiner gleich dem vermögen
  if (StrToInt(EdtBetrag.Text) <= StrToInt(EdtVermoegen.Text)) then
  begin
    j := 0;
    //3 werte in ein array speichern
    //sofortiger vergleich, obs ein treffer
    for i := 1 to 3 do
    begin
      wurf[i] := (random(6)+1);
      if wurf[i] = StrToInt(CmbBxSetOn.Text)then
       inc(j); //Anzahl der treffer
    end;
    LblWurfel1.Caption := IntToStr(wurf[1]);
    LblWurfel2.Caption := IntToStr(wurf[2]);
    LblWurfel3.Caption := IntToStr(wurf[3]);
    if Frmoptionen.getGameType = 0 then
    begin
      //Neuer vermögen wird berechnen und übergeben
      EdtVermoegen.Text := CalcSingle(j,EdtBetrag.text, EdtVermoegen.text);
    end
      else
    begin
      gWerte := [5,6,7,8,13,14,15,16];
      //LblWurfel2.Caption := IntToStr( wurf[1] + wurf[2] + wurf[3]);
      summe := IntToStr( wurf[1] + wurf[2] + wurf[3]);
      gewonnen := false;
      if (StrToInt(summe) in gWerte) then
        gewonnen := true;
      EdtVermoegen.Text := CalcField(gewonnen,EdtBetrag.text, EdtVermoegen.text);

    end;
    FrmLog.LineAdd(Frmoptionen.getGameType, CmbBxSetOn.Text, LblWurfel1.Caption,
                    LblWurfel2.Caption,LblWurfel3.Caption, EdtBetrag.Text,
                     EdtVermoegen.Text);
  end
    else
  begin
    ShowMessage('Sie haben nicht so viel Vermögen!');
  end;
  
  //Prüfe ob Vermögen gleich 0 ist
  if StrToInt(EdtVermoegen.Text) = 0 then
    if Application.MessageBox('Verloren noch mal?',
                              'Verloren', MB_YESNO)=6 then
    begin
      EdtVermoegen.Text := IntToStr(Kapital);
      FrmLog.LogDelete();
    end;
end;





end.
