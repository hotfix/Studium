 //------------------------------------------------------
 //  Programm zum erzeugen von Fraktalen
 //  Mandelbrot und Julia
 //
 // UMain, dient zur Stuerung des Formulares
 // Erstellt von : Bastian Terfloth(WInf 8196)
 //                   und
 //                Alexander Albrant (winf2862)
 // am : 29.04.2007
 // version : 0.1
 //------------------------------------------------------

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, OleServer, OutlookXP, Buttons;

type
  TFrmMain = class(TForm)
    RdGrpVerschiebung: TRadioGroup;
    LblReMin: TLabel;
    LblReMax: TLabel;
    LblImMin: TLabel;
    LblImMax: TLabel;
    LblDepth: TLabel;
    EdtReMin: TEdit;
    EdtReMax: TEdit;
    EdtDepth: TEdit;
    EdtImMin: TEdit;
    EdtImMax: TEdit;
    BtnZeichne: TButton;
    BitBtn1: TBitBtn;
    PntBxZeichen: TPaintBox;
    PnlMenu: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdtJre: TEdit;
    EdtJim: TEdit;
    BtnReset: TButton;
    procedure EdtDepthKeyPress(Sender: TObject; var Key: Char);
    procedure BtnResetClick(Sender: TObject);
    procedure RdGrpVerschiebungClick(Sender: TObject);
    procedure EdtReMinExit(Sender: TObject);
    procedure EdtReMaxExit(Sender: TObject);
    procedure EdtImMinExit(Sender: TObject);
    procedure EdtImMaxExit(Sender: TObject);
    procedure EdtDepthExit(Sender: TObject);
    procedure EdtJreExit(Sender: TObject);
    procedure EdtJimExit(Sender: TObject);
    procedure PntBxZeichenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PntBxZeichenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnZeichneClick(Sender: TObject);
  private
    { Private-Deklarationen }
    var
      mausX,
      mausY : integer;

    procedure berechne();

  public
    { Public-Deklarationen }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
uses uCalc;

//Prozedur zur Berechnung
//Durchlauf der x und y Koordinate
procedure TFrmMain.berechne();
var
  xmin, xmax, // Remin, ReMax
  ymin, ymax, //
  jim, jre,
  x, y : real;
  depth,
  x_img, y_img : integer;
  creal, cimag : real;
begin
  xmin := strtofloat(EdtReMin.Text);
  xmax := strtofloat(EdtReMax.Text);
  ymin := strtofloat(EdtImMin.Text);
  ymax := strtofloat(EdtImMax.Text);
  depth:= strtoint(EdtDepth.Text);
  jre := strtofloat(EdtJre.Text);
  jim := strtofloat(EdtJim.Text);
  for x_img := 1 to PntBxZeichen.Width do
    for y_img := 1 to PntBxZeichen.Height do
      begin
        if RdGrpVerschiebung.ItemIndex = 0 then
        begin
          x := getRe(x_img, xmin, xmax, PntBxZeichen.Width);
          y := getIm(y_img, ymax, ymin, PntBxZeichen.Height);
          creal := x;
          cimag := y;
          PntBxZeichen.Canvas.pixels[x_img, y_img] := mandel(depth,x,y,creal,cimag);
        end
        else
        begin
          creal := 0;   //Re0
          cimag := 0;   //Im0
          //Realer Anteil im Koord.System
          x := getRe(x_img, xmin, xmax, PntBxZeichen.Width);
          y := getIm(y_img, ymax, ymin, PntBxZeichen.Height);
          //zeichne
          PntBxZeichen.Canvas.pixels[x_img, y_img] := Julia(depth,x,y,creal,
                                                            cimag,jre,jim);
        end;
      end;
end;

//Erreichnis Reset
//Setzt alles auf die Anfangswerte und aktuliesiert die fläche
procedure TFrmMain.BtnResetClick(Sender: TObject);
begin
  PntBxZeichen.Canvas.Brush.Color := clWhite;
  PntBxZeichen.canvas.rectangle(0,0,PntBxZeichen.Width,PntBxZeichen.Height);
  EdtDepth.Text := '400';
  EdtImMax.Text := '1,5';
  EdtImMin.Text := '-1,5';
  EdtJim.Text := '0,18';
  EdtReMin.Text := '-2,25';
  EdtJre.Text := '-0,743';
  EdtReMax.Text := '0,75';
end;

//Zeichnet
procedure TFrmMain.BtnZeichneClick(Sender: TObject);
begin
  berechne();
end;

//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtDepthExit(Sender: TObject);
var dummy : Integer;
begin
  if not(TryStrToInt(EdtDepth.Text,dummy)) then
    EdtDepth.Text := '400';
end;


procedure TFrmMain.EdtDepthKeyPress(Sender: TObject; var Key: Char);
begin
  if (Sender=EdtReMin) or (Sender=EdtReMax)
      or (Sender=EdtImMin) or (Sender=EdtImMax)
      or (Sender=EdtJre) or (Sender=EdtJim) then
    begin
      if not (key in ['0'..'9',#8,#44,#45]) then
        key := #0;
      if (key = #44) and (pos(',',(Sender as TEdit).Text) <> 0) then
        key := #0;
      if (key = #45) and (pos('-',(Sender as TEdit).Text) <> 0) then
        key := #0; //wenn komma schon eingegeben, dann nicht mehr moglich
    end;
    if (Sender=EdtDepth) then
      if not (key in ['0'..'9',#8]) then
        key := #0;
end;

//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtImMaxExit(Sender: TObject);
var dummy : Extended;
begin
  if not(TryStrToFloat(EdtImMax.Text,dummy)) then
    EdtImMax.Text := '1,5';
end;



//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtImMinExit(Sender: TObject);
var dummy : Extended;
begin
  if not(TryStrToFloat(EdtImMin.Text,dummy)) then
    EdtImMin.Text := '-1,5';
end;



//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtJimExit(Sender: TObject);
var dummy : Extended;
begin
  if not(TryStrToFloat(EdtJim.Text,dummy)) then
    EdtJim.Text := '0,18';
end;



//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtJreExit(Sender: TObject);
var dummy : Extended;
begin
  if not(TryStrToFloat(EdtJre.Text,dummy)) then
    EdtJre.Text := '-0,743';
end;



//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtReMaxExit(Sender: TObject);
var dummy : Extended;
begin
  if not(TryStrToFloat(EdtReMax.Text,dummy)) then
    EdtReMax.Text := '0,75';
end;



//prüfe die zahl beim verlassen des Editfeldes
procedure TFrmMain.EdtReMinExit(Sender: TObject);
var dummy : Extended;
begin
  if not(TryStrToFloat(EdtReMin.Text,dummy)) then
    EdtReMin.Text := '-2,25';
end;



//Inizialiesierung der Zeichenfläche beim Start
procedure TFrmMain.FormPaint(Sender: TObject);
begin
  PntBxZeichen.Canvas.Brush.Color := clWhite;
  PntBxZeichen.canvas.rectangle(0,0,PntBxZeichen.Width,PntBxZeichen.Height);
  //PntBxZeichen.Canvas.fillrect(rect(0,0,PntBxZeichen.Width,PntBxZeichen.Height));
end;

//passt die Zeichenfläche beim Resizen
procedure TFrmMain.FormResize(Sender: TObject);
begin
  PntBxZeichen.Height := FrmMain.Height-35 ;
  PntBxZeichen.Width := FrmMain.Width-PnlMenu.Width-20;
end;

//Koordienaten der linken oberen Ecke
//methode mouseDown
procedure TFrmMain.PntBxZeichenMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mausX := X;
  mausY := Y;
end;

//Koordienaten der linken oberen Ecke
//methode mouseUp
procedure TFrmMain.PntBxZeichenMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

var tauschx, tauschy :integer;
begin

  //Ermöglicht Zoomen in allen 4 Kombinationen
  if (MausX > X) then
  begin
    TauschX := X;
    X := MausX;
    MausX := TauschX;
  end;

  if (MausY > Y) then
  begin
     TauschY := Y;
     Y := MausY;
     MausY := TauschY;
  end;



  EdtReMin.Text := FloatToStr(getRe(mausX,(StrToFloat(EdtReMin.Text)),
                              (StrToFloat(EdtReMax.Text)),PntBxZeichen.Width));

  EdtReMax.Text := FloatToStr(getRe(X,(StrToFloat(EdtReMin.Text)),
                              (StrToFloat(EdtReMax.Text)),PntBxZeichen.Width));

  EdtImMin.Text := FloatToStr(getIm(Y,(StrToFloat(EdtImMax.Text)),
                            (StrToFloat(EdtImMin.Text)),PntBxZeichen.Height));

  EdtImMax.Text := FloatToStr(getIm(mausY,(StrToFloat(EdtImMax.Text)),
                            (StrToFloat(EdtImMin.Text)),PntBxZeichen.Height));

  Application.ProcessMessages;
//  Zeichnung ausführen
  BtnZeichne.Click;
end;

//Abarbeutung der funktion der RadioButtons
procedure TFrmMain.RdGrpVerschiebungClick(Sender: TObject);
begin
    EdtJre.Enabled := RdGrpVerschiebung.ItemIndex = 1;
    EdtJim.Enabled := RdGrpVerschiebung.ItemIndex = 1;
end;

end.
