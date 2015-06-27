{------------------------------------------------------------------------------
Tabellenunit: UTabelle
-----------------------
Wird benötigt um die Tabelle auszugeben.

 Autor: Bastian Terfloth und Alexander Albrant - 16.05.07
 ------------------------------------------------------------------------------}
unit UTabelle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;

type
  TFrmTabelle = class(TForm)
    StrGrdCollection: TStringGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    //Initialisierung
    procedure Init();

    procedure fillTable();
  public
    { Public declarations }
  end;

var
  FrmTabelle: TFrmTabelle;

implementation

uses UDaten, UTypen;
{$R *.dfm}

//FormCreate
procedure TFrmTabelle.FormShow(Sender: TObject);
begin
  Init();


  fillTable();
end;

// Prozedur zum Initialisiren der Spaltenuberschrieften
procedure TFrmTabelle.Init();

begin
  StrGrdCollection.RowCount := GetNewDataCount+1;
//Inizialiesiere Die die ObersteSpalte
  with StrGrdCollection do
  begin
    ColWidths[0] := 30;
    Cells[0,0]:= 'ID';
    Cells[1,0]:= 'Name';
    Cells[2,0]:= 'Typ';
    Cells[3,0]:= 'Kategorie';
  end;
end;


//Die Tabelle (TabelleAnzeigen) wird entsprechend des Arrays gefüllt
procedure TFrmTabelle.fillTable();
var
  i : integer;
begin
  for i := low(TArraySize)+1 to high(TArraySize) do
  begin
    StrGrdCollection.Cells[0,i] := IntToStr(GetMedium(i).ID);
    StrGrdCollection.Cells[1,i] := GetMedium(i).Name;
    case GetMedium(i).Typ of
      CD :  StrGrdCollection.Cells[2,i] := 'CD';
      DVD :  StrGrdCollection.Cells[2,i]:= 'DVD';
    end;
    case GetMedium(i).Kategorien of
      Film :  StrGrdCollection.Cells[3,i]:= 'Film';
      Musik :  StrGrdCollection.Cells[3,i]:= 'Musik';
      Software :  StrGrdCollection.Cells[3,i]:= 'Software';
      Rest :  StrGrdCollection.Cells[3,i]:= 'sonstiges';
    end;
  end;
end;

end.
