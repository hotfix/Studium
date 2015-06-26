object FrmLog: TFrmLog
  Left = 192
  Top = 107
  Caption = 'Log'
  ClientHeight = 294
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MemLog: TMemo
    Left = 0
    Top = 0
    Width = 344
    Height = 294
    Align = alClient
    Enabled = False
    TabOrder = 0
    OnChange = MemLogChange
  end
end
