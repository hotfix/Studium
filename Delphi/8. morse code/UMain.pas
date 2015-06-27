/////////////////////////////////////////////////////////////////////
///  Unit UMAIN.pas
/// Der Morsecode Creator soll in der Lage sein, Klartext in das Morsealphabet
/// zu codieren, sowie im Morsecode chiffrierten Text zu decodieren.
/// Im Morsealphabet sind die Buchstaben durch eine Aneinanderreihung
/// von Punkten und Strichen codiert
///
/// Erstellt von: Bastian T. und Alexander A. am 01.07.07
/// Letztes Update: 01.07.07 Vers. 1.01
/////////////////////////////////////////////////////////////////////
unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UTypes, UConst;

type
  Tfrm = class(TForm)
    GrpBx_Main: TGroupBox;
    Edt_CodText: TEdit;
    Edt_CodCode: TEdit;
    Btn_Codieren: TButton;
    Btn_Decodieren: TButton;
    Edt_DecodCode: TEdit;
    Edt_DecodText: TEdit;
    Lbl_CodText: TLabel;
    Lbl_CodCode: TLabel;
    Lbl_DecodCode: TLabel;
    Lbl_DecodText: TLabel;
    procedure Edt_DecodCodeChange(Sender: TObject);
    procedure Edt_CodTextChange(Sender: TObject);
    procedure Btn_DecodierenClick(Sender: TObject);
    procedure OnFormCreate(Sender: TObject);
    procedure Btn_CodierenClick(Sender: TObject);
  private
    { Private declarations }
    procedure BtnUpdate ();
  public
    { Public declarations }
  end;

var
  frm: Tfrm;

implementation

{$R *.dfm}

uses ULogic;

/////////////////////////////////////////////////////////////////////
// BtnUpdate:
// Die Buttons werden aktiviert wenn mindestens ein Buchstabe
// im entsprechenden Textfeld steht
/////////////////////////////////////////////////////////////////////
procedure Tfrm.BtnUpdate ();
begin
  Btn_Codieren.Enabled := Length(Edt_CodText.Text) > 0 ;
  Btn_Decodieren.Enabled := Length(Edt_DecodCode.Text) > 0;
end;


/////////////////////////////////////////////////////////////////////
// Btn_CodierenClick:
// Der Inhalt des Textfeldes wird entsprechend übergeben
/////////////////////////////////////////////////////////////////////
procedure Tfrm.Btn_CodierenClick(Sender: TObject);

begin
  // Abfangen von fehlerhaften eingaben passiert bei ONCHANGE
  // Filter ist bei ONCHANGE ebenfalls realisiert
  Edt_CodCode.Text := TextToCode(Edt_CodText.Text) ;
end;

/////////////////////////////////////////////////////////////////////
// Btn_DecodierenClick:
// Der Inhalt des Textfeldes wird entsprechend übergeben
/////////////////////////////////////////////////////////////////////
procedure Tfrm.Btn_DecodierenClick(Sender: TObject);
begin
  // Abfangen von fehlerhaften eingaben passiert bei ONCHANGE
  // Filter ist bei ONCHANGE ebenfalls realisiert
  Edt_DeCodText.Text := CodeToText(Edt_DeCodCode.Text);
end;



/////////////////////////////////////////////////////////////////////
// Edt_CodTextChange:
// Entsprechend der übergebenen Restiktionen wird der Inhalt des
// Klartext-Editfeldes überprüft und ggf. verbessert
/////////////////////////////////////////////////////////////////////
// Bezieht sich nur auf chars
/////////////////////////////////////////////////////////////////////
procedure Tfrm.Edt_CodTextChange(Sender: TObject);
var
  TempEdt_CodeText : string;
  Restriktion : TEingabe;
begin
  Restriktion := ['A'..'Z','a'..'z',' ',#8];

  TempEdt_CodeText := Edt_CodText.Text;
  if NOT(InputFilterK(TempEdt_CodeText,Restriktion)) then
    showmessage('Fehler in der Eingabe entdeckt und Umgewandelt');
  Edt_CodText.Text := TempEdt_CodeText;
  //Setzt den Curser an die vorige Position
  Edt_CodText.SelStart := length(TempEdt_CodeText);
  BtnUpdate();
end;

/////////////////////////////////////////////////////////////////////
// Edt_CodTextChange:
// Entsprechend der übergebenen Restiktionen wird der Inhalt des
// Klartext-Editfeldes überprüft und ggf. verbessert
/////////////////////////////////////////////////////////////////////
// Zusätzlich wird ein weiterer Filter (InputfilterM) aufgerufen, der alle
// Zeichen löscht die nicht im Suchbaum gefunden werden können
/////////////////////////////////////////////////////////////////////
procedure Tfrm.Edt_DecodCodeChange(Sender: TObject);
var
  Restriktion : TEingabe;
  TempEdt_DecodCode : string;
begin
  Restriktion := [' ','.','-', #8];
  TempEdt_DecodCode := Edt_DecodCode.Text;
  //Filter für einfache Zeichen entsprechend der Restiktionen
  if NOT(InputFilterK(TempEdt_DecodCode,Restriktion)) then
    showmessage('Fehler in der Eingabe (Morse) entdeckt und umgewandelt');
  //Zusätzlicher Filter bzl. des Codebaumes
  if InputFilterM(TempEdt_DecodCode) then
    showmessage('Fehlerhaftes Morsewort entdeckt und entfernt');
  Edt_DecodCode.Text := TempEdt_DecodCode;
  //Setzt den Curser auf die richtige Position
  Edt_DecodCode.SelStart := length(TempEdt_DecodCode);
  BtnUpdate ();
end;

/////////////////////////////////////////////////////////////////////
//OnFormCreate:
//Alle Buttons aktivieren/deaktivieren
/////////////////////////////////////////////////////////////////////
procedure Tfrm.OnFormCreate(Sender: TObject);
begin
  BtnUpdate ();
end;

end.
