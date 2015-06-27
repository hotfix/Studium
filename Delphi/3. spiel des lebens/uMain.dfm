object frmMain: TfrmMain
  Left = 195
  Top = 100
  Caption = 'Spiel des Lebens'
  ClientHeight = 159
  ClientWidth = 352
  Color = clBtnFace
  Constraints.MaxHeight = 195
  Constraints.MaxWidth = 368
  Constraints.MinHeight = 185
  Constraints.MinWidth = 360
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblGameStart: TLabel
    Left = 152
    Top = 12
    Width = 126
    Height = 13
    Caption = 'Ausgangssituation wahlen:'
  end
  object cmbbxGameStart: TComboBox
    Left = 280
    Top = 8
    Width = 65
    Height = 21
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
    OnChange = cmbbxGameStartChange
  end
  object btnNextGen: TButton
    Left = 152
    Top = 32
    Width = 193
    Height = 25
    Caption = 'Nachste Generation'
    TabOrder = 1
    OnClick = btnNextGenClick
  end
  object gamefield: TStringGrid
    Left = 152
    Top = 64
    Width = 193
    Height = 89
    DefaultColWidth = 10
    DefaultRowHeight = 10
    FixedCols = 0
    FixedRows = 0
    TabOrder = 2
  end
  object grpbxGamefield: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 145
    Caption = 'Spielfeldgr'#246#223'e andern'
    TabOrder = 3
    object btnIncWidth: TButton
      Left = 8
      Top = 16
      Width = 121
      Height = 25
      Caption = 'Breite vergr'#246#223'ern'
      TabOrder = 0
      OnClick = btnIncWidthClick
    end
    object btnDecWidth: TButton
      Left = 8
      Top = 48
      Width = 121
      Height = 25
      Caption = 'Breite verkleinern'
      TabOrder = 1
      OnClick = btnDecWidthClick
    end
    object btnIncHeight: TButton
      Left = 8
      Top = 80
      Width = 121
      Height = 25
      Caption = 'Hohe vergr'#246#223'ern'
      TabOrder = 2
      OnClick = btnIncHeightClick
    end
    object btnDecHeight: TButton
      Left = 8
      Top = 112
      Width = 121
      Height = 25
      Caption = 'Hohe verkleinern'
      TabOrder = 3
      OnClick = btnDecHeightClick
    end
  end
end
