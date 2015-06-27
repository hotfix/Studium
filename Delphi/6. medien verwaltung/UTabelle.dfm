object FrmTabelle: TFrmTabelle
  Left = 0
  Top = 0
  Caption = 'Medienverwaltung - Anzeigetabelle'
  ClientHeight = 327
  ClientWidth = 354
  Color = clBtnFace
  Constraints.MaxHeight = 363
  Constraints.MinHeight = 354
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StrGrdCollection: TStringGrid
    Left = 0
    Top = 0
    Width = 354
    Height = 327
    Align = alClient
    ColCount = 4
    Constraints.MaxWidth = 354
    Constraints.MinHeight = 43
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ColWidths = (
      29
      138
      95
      84)
  end
end
