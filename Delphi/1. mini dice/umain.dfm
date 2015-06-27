object FrmMain: TFrmMain
  Left = 192
  Top = 107
  Caption = 'Mini Dice'
  ClientHeight = 313
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 8
    Top = 8
    Width = 255
    Height = 257
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 62
      Width = 79
      Height = 13
      Caption = 'Spielvariante:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblGameType: TLabel
      Left = 110
      Top = 62
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Single'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BtnOptions: TButton
      Left = 13
      Top = 9
      Width = 228
      Height = 25
      Caption = 'Optionen'
      TabOrder = 1
      OnClick = BtnOptionsClick
    end
    object BtnWurf: TButton
      Left = 16
      Top = 225
      Width = 225
      Height = 25
      Caption = 'Wurfeln'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnWurfClick
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 96
      Width = 225
      Height = 121
      Caption = 'Player Infortmation'
      TabOrder = 2
      object Label2: TLabel
        Left = 16
        Top = 26
        Width = 51
        Height = 13
        Caption = 'Vermogen:'
      end
      object LblSetWert: TLabel
        Left = 16
        Top = 54
        Width = 68
        Height = 13
        Caption = 'Betrag setzen:'
      end
      object Label4: TLabel
        Left = 16
        Top = 82
        Width = 54
        Height = 13
        Caption = 'Setzen auf:'
      end
      object LblSetField: TLabel
        Left = 76
        Top = 83
        Width = 114
        Height = 13
        Caption = '5, 6, 7, 8, 13, 14, 15, 16'
        Visible = False
      end
      object EdtVermoegen: TEdit
        Left = 96
        Top = 24
        Width = 58
        Height = 21
        BiDiMode = bdRightToLeft
        Color = clMenu
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 0
      end
      object CmbBxSetOn: TComboBox
        Left = 96
        Top = 80
        Width = 58
        Height = 19
        Style = csOwnerDrawFixed
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = '1'
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6')
      end
      object EdtBetrag: TEdit
        Left = 96
        Top = 52
        Width = 58
        Height = 21
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        TabOrder = 2
        Text = '5'
        OnExit = EdtBetragExit
        OnKeyPress = EdtBetragKeyPress
      end
    end
  end
  object PnlErgebnis: TPanel
    Left = 8
    Top = 272
    Width = 257
    Height = 33
    TabOrder = 1
    object LblWurfel1: TLabel
      Left = 21
      Top = 10
      Width = 20
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblWurfel2: TLabel
      Left = 110
      Top = 10
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblWurfel3: TLabel
      Left = 207
      Top = 10
      Width = 20
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
