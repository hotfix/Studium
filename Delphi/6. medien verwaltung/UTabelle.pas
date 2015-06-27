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

  public
    { Public declarations }
    procedure fillTable();
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
end;

{-----------------------------------------------------------------
Initalisiert die oberste Zeile
-----------------------------------------------------------------}
procedure TFrmTabelle.Init();

begin
  StrGrdCollection.RowCount := GetMaxID+1;
  with StrGrdCollection do
  begin
    ColWidths[0] := 30;
    Cells[0,0]:= 'ID';
    Cells[1,0]:= 'Name';
    Cells[2,0]:= 'Typ';
    Cells[3,0]:= 'Kategorie';
  end;
end;


{-----------------------------------------------------------------
Die Tabelle wird entsprechend der Medien gefüllt
-----------------------------------------------------------------}
procedure TFrmTabelle.fillTable();
var
  i : integer;
  TempMedium : TMedium;
begin
  for i := low(TNummer) to getMaxID()-1 do
  begin
    TempMedium := GetMedium(i);
    StrGrdCollection.Cells[0,i+1] := IntToStr(TempMedium.ID);
    StrGrdCollection.Cells[1,i+1] := TempMedium.Name;
    case GetMedium(i).Typ of
      CD :  StrGrdCollection.Cells[2,i+1] := 'CD';
      DVD :  StrGrdCollection.Cells[2,i+1]:= 'DVD';
    end;
    case GetMedium(i).Kategorie of
      Film :  StrGrdCollection.Cells[3,i+1]:= 'Film';
      Musik :  StrGrdCollection.Cells[3,i+1]:= 'Musik';
      Software :  StrGrdCollection.Cells[3,i+1]:= 'Software';
      Sonst_Daten :  StrGrdCollection.Cells[3,i+1]:= 'sonstiges';
    end;
  end;
end;

end.
