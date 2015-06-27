{------------------------------------------------------------------------------
 Hauptunit des Spiel des Lebens
 Autor: Philip Lehmann-B�hm, 20.03.2007
 --------------------------------------
 Erweitert/gef�llt am 09.05.07 von Bastian Terfloth und Alexander Albrant
 --------------------------------------
 Es wird das Spiel des Lebens simuliert.
 Weitere Informationen findet man unter
 http://de.wikipedia.org/wiki/Conways_Spiel_des_Lebens
 ------------------------------------------------------------------------------}
unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TfrmMain = class(TForm)
    cmbbxGameStart: TComboBox;
    btnNextGen: TButton;
    lblGameStart: TLabel;
    gamefield: TStringGrid;
    grpbxGamefield: TGroupBox;
    btnIncWidth: TButton;
    btnDecWidth: TButton;
    btnIncHeight: TButton;
    btnDecHeight: TButton;
    procedure btnNextGenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbbxGameStartChange(Sender: TObject);
    procedure btnDecWidthClick(Sender: TObject);
    procedure btnIncWidthClick(Sender: TObject);
    procedure btnIncHeightClick(Sender: TObject);
    procedure btnDecHeightClick(Sender: TObject);
  private
    procedure drawGame;
    procedure updateComponents;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

  uses
    uGameLogic, uTypes, uGames;

{$R *.dfm}

{-------------------------------------------------------------------------
 �bertr�gt das Spielfeld in das Stringgrid, wobei ein belegtes Feld durch
 ein # repr�sentiert wird.
 -------------------------------------------------------------------------}
procedure TfrmMain.drawGame;
var
  i,j :integer;
begin
//Durchlaufe das StrGrid und F�lle mit Werten
  for i := 0 to high(TGameWidth)-1 do //x Werte
    for j := 0 to high(TGameHeight)-1 do//y Werte
     if getCellState(low(TGameWidth)+i,low(TGameHeight)+j) then
       gamefield.Cells[i,j] := '*'
     else
       gamefield.Cells[i,j] := '';
end;

{-------------------------------------------------------------------------
 Die n�chste Generation berechnen und das Spielfeld zeichnen.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnNextGenClick(Sender: TObject);
begin
  nextGen();
  drawGame();
end;

{-------------------------------------------------------------------------
 Beim Programmstart die Combobox mit den m�glichen Ausgangssituationen
 f�llen, das Stringgrid an die Konstanten anpassen, das Spielfeld mit der
 ersten m�glichen Ausgangssituation f�llen und das ganze zeichnen.
 -------------------------------------------------------------------------}
procedure TfrmMain.FormCreate(Sender: TObject);
var
  I : integer; //Z�hlvariable f�r 1 to GamesCount

begin
  {F�llt die Auswahl der m�glichen Spielvarianten der CmbbxGameStart
  mit Werten von 1 bis GameCount (Anzahl der Spielvarianten)}
  for I := 1 to GameCount do
    cmbbxGameStart.Items.Insert(I-1,IntToStr(I));
  CmbbxGameStart.ItemIndex := 0;
  initGlob();
  initGame(cmbbxGameStart.ItemIndex+1);
  updateComponents();
end;

{-------------------------------------------------------------------------
 Die ausgew�hlte Ausgangssituation laden und das Spielfeld zeichnen.
 -------------------------------------------------------------------------}
procedure TfrmMain.cmbbxGameStartChange(Sender: TObject);
begin
   initGame(cmbbxGameStart.ItemIndex+1);

   updateComponents();
end;

{-------------------------------------------------------------------------
 Die Komponenten anpassen: Die Buttons entsprechend aktivieren und das
 Stringgrid an das Spielfeld anpassen.
 -------------------------------------------------------------------------}
procedure TfrmMain.updateComponents;
begin
  //Stringgrid anpassen
  gamefield.ColCount := getWidth();
  gamefield.RowCount := getHeight();
  //Buttons aktivieren & deaktivieren
  BtnIncHeight.Enabled := (gamefield.RowCount < high(TGameHeight));
  BtnDecHeight.Enabled := (gamefield.RowCount > low(TGameHeight));
  BtnIncWidth.Enabled := (gamefield.ColCount < high(TGameWidth));
  BtnDecWidth.Enabled := (gamefield.ColCount > low(TGameWidth));
  drawGame();
end;

{-------------------------------------------------------------------------
 Die Spielfeldbreite erniedrigen und die Komponenten aktualisieren.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnDecWidthClick(Sender: TObject);
begin
  setWidth(getWidth() - 1);
  updateComponents;
end;

{-------------------------------------------------------------------------
 Die Spielfeldbreite erh�hen und die Komponenten aktualisieren.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnIncWidthClick(Sender: TObject);
begin
  setWidth(getWidth() + 1);
  updateComponents;
end;

{-------------------------------------------------------------------------
 Die Spielfeldh�he erh�hen und die Komponenten aktualisieren.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnIncHeightClick(Sender: TObject);
begin
  setHeight(getHeight() + 1);
  updateComponents;
end;

{-------------------------------------------------------------------------
 Die Spielfeldh�he erniedrigen und die Komponenten aktualisieren.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnDecHeightClick(Sender: TObject);
begin
  setHeight(getHeight() - 1);
  updateComponents;
end;

end.
