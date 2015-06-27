object frmMain: TfrmMain
  Left = 293
  Top = 404
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Schlesische Lotterie'
  ClientHeight = 225
  ClientWidth = 153
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblMoney: TLabel
    Left = 8
    Top = 8
    Width = 60
    Height = 13
    Caption = 'Verm'#246'gen: 0'
  end
  object grpbxOwnDeck: TGroupBox
    Left = 8
    Top = 32
    Width = 137
    Height = 185
    Caption = 'Eigenes Blatt'
    TabOrder = 0
    object btnBuyCard: TButton
      Left = 8
      Top = 16
      Width = 121
      Height = 25
      Caption = 'Karte kaufen'
      TabOrder = 0
      OnClick = btnBuyCardClick
    end
    object lbOwnDeck: TListBox
      Left = 8
      Top = 48
      Width = 121
      Height = 97
      ItemHeight = 13
      TabOrder = 1
    end
    object btnReady: TButton
      Left = 8
      Top = 152
      Width = 121
      Height = 25
      Caption = 'Fertig, Ziehung starten'
      TabOrder = 2
      OnClick = btnReadyClick
    end
  end
end
