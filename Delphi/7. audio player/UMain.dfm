object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'John Player'
  ClientHeight = 456
  ClientWidth = 702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Lb_Title: TLabel
    Left = 142
    Top = 335
    Width = 3
    Height = 13
  end
  object MediaPlayer: TMediaPlayer
    Left = 109
    Top = 94
    Width = 29
    Height = 31
    VisibleButtons = []
    Display = MediaPlayer
    Visible = False
    TabOrder = 0
  end
  object Bt_AddFile: TButton
    Left = 22
    Top = 258
    Width = 75
    Height = 26
    Cursor = crHandPoint
    HelpType = htKeyword
    Caption = 'Add Song'
    TabOrder = 1
    OnClick = Bt_AddFileClick
  end
  object Lb_Songs: TListBox
    Left = 142
    Top = 24
    Width = 227
    Height = 305
    Enabled = False
    ItemHeight = 13
    TabOrder = 2
  end
  object Bt_Save: TButton
    Left = 22
    Top = 296
    Width = 75
    Height = 26
    Cursor = crHandPoint
    HelpType = htKeyword
    Caption = 'Save Playlist'
    TabOrder = 3
    OnClick = Bt_SaveClick
  end
  object Bt_Open: TButton
    Left = 22
    Top = 321
    Width = 75
    Height = 26
    Cursor = crHandPoint
    HelpType = htKeyword
    Caption = 'Open Playlist'
    TabOrder = 4
    OnClick = Bt_OpenClick
  end
  object Bt_Next: TButton
    Left = 22
    Top = 105
    Width = 75
    Height = 26
    Cursor = crHandPoint
    Caption = 'Next'
    TabOrder = 5
    OnClick = Bt_Next_Click
  end
  object Bt_First: TButton
    Left = 22
    Top = 79
    Width = 75
    Height = 26
    Cursor = crHandPoint
    Caption = 'First'
    TabOrder = 6
    OnClick = Bt_FirstClick
  end
  object Bt_Stop: TButton
    Left = 22
    Top = 45
    Width = 75
    Height = 26
    Cursor = crHandPoint
    Caption = 'Stop'
    TabOrder = 7
    OnClick = Bt_StopClick
  end
  object Bt_Play: TButton
    Left = 22
    Top = 19
    Width = 75
    Height = 26
    Cursor = crHandPoint
    Caption = 'Play'
    TabOrder = 8
    OnClick = Bt_PlayClick
  end
  object ProgressBar: TProgressBar
    Left = 142
    Top = 8
    Width = 227
    Height = 11
    TabOrder = 9
  end
  object Bt_Prev: TButton
    Left = 22
    Top = 130
    Width = 75
    Height = 26
    Caption = 'Prev'
    TabOrder = 10
    OnClick = Bt_PrevClick
  end
  object Bt_MoveUp: TButton
    Left = 22
    Top = 168
    Width = 75
    Height = 26
    Caption = 'Move Up'
    TabOrder = 11
    OnClick = Bt_MoveUpClick
  end
  object Bt_MoveDown: TButton
    Left = 22
    Top = 193
    Width = 75
    Height = 26
    Caption = 'Move Down'
    TabOrder = 12
    OnClick = Bt_MoveDownClick
  end
  object Bt_DeleteSongs: TButton
    Left = 22
    Top = 232
    Width = 75
    Height = 26
    Caption = 'Delete Songs'
    TabOrder = 13
    OnClick = Bt_DeleteSongsClick
  end
  object bt_atposition: TButton
    Left = 24
    Top = 384
    Width = 75
    Height = 25
    Caption = 'bt_atposition'
    TabOrder = 14
    OnClick = bt_atpositionClick
  end
  object StrGrPlaylists: TStringGrid
    Left = 409
    Top = 8
    Width = 280
    Height = 321
    ColCount = 2
    DefaultColWidth = 20
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    TabOrder = 15
    ColWidths = (
      20
      255)
  end
  object Bt_ToList: TButton
    Left = 374
    Top = 113
    Width = 33
    Height = 108
    Caption = '=>'
    TabOrder = 16
    OnClick = Bt_ToListClick
  end
  object XPManifest1: TXPManifest
    Left = 112
  end
  object OpenFile: TOpenDialog
    Filter = 'MP3s|*.mp3|Playlist|*.jpl'
    Left = 112
    Top = 32
  end
  object saveFile: TSaveDialog
    DefaultExt = 'jpl'
    Filter = 'John Player Playlist|*.jpl'
    Left = 112
    Top = 64
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 112
    Top = 128
  end
end
