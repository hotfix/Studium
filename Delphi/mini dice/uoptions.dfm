object Frmoptionen: TFrmoptionen
  Left = 189
  Top = 170
  Caption = 'Optionen'
  ClientHeight = 117
  ClientWidth = 189
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RdGrpGameType: TRadioGroup
    Left = 8
    Top = 8
    Width = 89
    Height = 65
    Caption = 'Spielvariante'
    ItemIndex = 0
    Items.Strings = (
      'Single dice'
      'Field')
    TabOrder = 0
  end
  object ChkBxLog: TCheckBox
    Left = 109
    Top = 15
    Width = 57
    Height = 17
    Caption = 'Log'
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 83
    Width = 85
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 100
    Top = 83
    Width = 85
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
