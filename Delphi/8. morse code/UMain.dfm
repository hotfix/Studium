object frm: Tfrm
  Left = 0
  Top = 0
  Caption = 'MorseCode Creator'
  ClientHeight = 144
  ClientWidth = 519
  Color = clBtnFace
  Constraints.MaxHeight = 180
  Constraints.MaxWidth = 535
  Constraints.MinHeight = 171
  Constraints.MinWidth = 527
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = OnFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GrpBx_Main: TGroupBox
    Left = 11
    Top = 2
    Width = 497
    Height = 138
    Caption = 'Codieren / Decodieren'
    TabOrder = 0
    object Lbl_CodText: TLabel
      Left = 16
      Top = 35
      Width = 42
      Height = 13
      Caption = 'Klartext:'
    end
    object Lbl_CodCode: TLabel
      Left = 16
      Top = 99
      Width = 58
      Height = 13
      Caption = 'MorseCode:'
    end
    object Lbl_DecodCode: TLabel
      Left = 288
      Top = 35
      Width = 58
      Height = 13
      Caption = 'MorseCode:'
    end
    object Lbl_DecodText: TLabel
      Left = 304
      Top = 99
      Width = 42
      Height = 13
      Caption = 'Klartext:'
    end
    object Edt_CodText: TEdit
      Left = 80
      Top = 32
      Width = 121
      Height = 21
      MaxLength = 40
      TabOrder = 0
      Text = 'hallo'
      OnChange = Edt_CodTextChange
    end
    object Edt_CodCode: TEdit
      Left = 80
      Top = 96
      Width = 121
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object Btn_Codieren: TButton
      Left = 80
      Top = 61
      Width = 121
      Height = 25
      Caption = 'Codieren'
      TabOrder = 2
      OnClick = Btn_CodierenClick
    end
    object Btn_Decodieren: TButton
      Left = 352
      Top = 62
      Width = 121
      Height = 25
      Caption = 'Decodieren'
      TabOrder = 3
      OnClick = Btn_DecodierenClick
    end
    object Edt_DecodCode: TEdit
      Left = 352
      Top = 35
      Width = 121
      Height = 21
      MaxLength = 160
      TabOrder = 4
      OnChange = Edt_DecodCodeChange
    end
    object Edt_DecodText: TEdit
      Left = 352
      Top = 96
      Width = 121
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
  end
end
