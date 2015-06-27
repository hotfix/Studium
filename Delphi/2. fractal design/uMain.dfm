object FrmMain: TFrmMain
  Left = 148
  Top = 104
  Caption = 'Fraktal Rekursion'
  ClientHeight = 607
  ClientWidth = 944
  Color = clBtnFace
  Constraints.MinHeight = 505
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnPaint = FormPaint
  OnResize = FormResize
  DesignSize = (
    944
    607)
  PixelsPerInch = 96
  TextHeight = 13
  object PntBxZeichen: TPaintBox
    Left = 3
    Top = 4
    Width = 800
    Height = 600
    Cursor = crCross
    Color = clBtnHighlight
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = PntBxZeichenMouseDown
    OnMouseUp = PntBxZeichenMouseUp
  end
  object PnlMenu: TPanel
    Left = 810
    Top = 4
    Width = 130
    Height = 470
    Anchors = [akTop, akRight]
    TabOrder = 0
    object LblReMin: TLabel
      Left = 8
      Top = 16
      Width = 42
      Height = 16
      Caption = 'ReMin:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblReMax: TLabel
      Left = 8
      Top = 42
      Width = 46
      Height = 16
      Caption = 'ReMax:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblImMin: TLabel
      Left = 8
      Top = 77
      Width = 38
      Height = 16
      Caption = 'ImMin:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblImMax: TLabel
      Left = 8
      Top = 104
      Width = 42
      Height = 16
      Caption = 'ImMax:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblDepth: TLabel
      Left = 11
      Top = 139
      Width = 39
      Height = 16
      Caption = 'Depth:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 11
      Top = 254
      Width = 22
      Height = 16
      Caption = 'Jre:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 284
      Width = 24
      Height = 16
      Caption = 'Jim:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RdGrpVerschiebung: TRadioGroup
      Left = 8
      Top = 171
      Width = 112
      Height = 65
      Caption = 'Optionen'
      ItemIndex = 0
      Items.Strings = (
        'Apfelmannchen'
        'Juliamenge')
      TabOrder = 0
      OnClick = RdGrpVerschiebungClick
    end
    object EdtReMin: TEdit
      Left = 59
      Top = 12
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
      Text = '-2,25'
      OnExit = EdtReMinExit
      OnKeyPress = EdtDepthKeyPress
    end
    object EdtReMax: TEdit
      Left = 59
      Top = 39
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      Text = '0,75'
      OnExit = EdtReMaxExit
      OnKeyPress = EdtDepthKeyPress
    end
    object EdtDepth: TEdit
      Left = 59
      Top = 138
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 3
      Text = '400'
      OnExit = EdtDepthExit
      OnKeyPress = EdtDepthKeyPress
    end
    object EdtImMin: TEdit
      Left = 59
      Top = 74
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 4
      Text = '-1,5'
      OnExit = EdtImMinExit
      OnKeyPress = EdtDepthKeyPress
    end
    object EdtImMax: TEdit
      Left = 59
      Top = 101
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 5
      Text = '1,5'
      OnExit = EdtImMaxExit
      OnKeyPress = EdtDepthKeyPress
    end
    object BtnZeichne: TButton
      Left = 8
      Top = 310
      Width = 112
      Height = 33
      Caption = 'Zeichne'
      TabOrder = 6
      OnClick = BtnZeichneClick
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 427
      Width = 112
      Height = 32
      TabOrder = 7
      Kind = bkClose
    end
    object EdtJre: TEdit
      Left = 59
      Top = 253
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 8
      Text = '-0,743'
      OnExit = EdtJreExit
      OnKeyPress = EdtDepthKeyPress
    end
    object EdtJim: TEdit
      Left = 59
      Top = 283
      Width = 61
      Height = 21
      BiDiMode = bdLeftToRight
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 9
      Text = '0,18'
      OnExit = EdtJimExit
      OnKeyPress = EdtDepthKeyPress
    end
    object BtnReset: TButton
      Left = 8
      Top = 353
      Width = 112
      Height = 33
      Caption = 'Reset'
      TabOrder = 10
      OnClick = BtnResetClick
    end
  end
end
