object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Medienverwaltung'
  ClientHeight = 504
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MnMenu
  OldCreateOrder = False
  OnCreate = OnFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlNav: TPanel
    Left = 6
    Top = 8
    Width = 319
    Height = 41
    TabOrder = 0
    object BtnNavOf: TLabel
      Left = 144
      Top = 13
      Width = 18
      Height = 13
      Caption = 'von'
    end
    object BtnNavPrev: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #171' Prev'
      TabOrder = 0
      OnClick = BtnNavPrevClick
    end
    object BtnNavNext: TButton
      Left = 230
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Next '#187
      TabOrder = 1
      OnClick = BtnNavNextClick
    end
    object EdtNavActID: TEdit
      Left = 88
      Top = 11
      Width = 41
      Height = 21
      TabOrder = 2
    end
    object EdtNavMaxID: TEdit
      Left = 174
      Top = 10
      Width = 50
      Height = 21
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 3
    Top = 54
    Width = 322
    Height = 332
    TabOrder = 1
    object LblID: TLabel
      Left = 8
      Top = 16
      Width = 15
      Height = 13
      Caption = 'ID:'
    end
    object LblName: TLabel
      Left = 8
      Top = 48
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object PnlSoftware: TPanel
      Left = 8
      Top = 225
      Width = 306
      Height = 73
      TabOrder = 0
      object LblPublisher: TLabel
        Left = 16
        Top = 13
        Width = 50
        Height = 13
        Caption = 'Hersteller:'
      end
      object LblKey: TLabel
        Left = 16
        Top = 43
        Width = 47
        Height = 13
        Caption = 'Schlussel:'
      end
      object EdtSoftwareHersteller: TEdit
        Left = 82
        Top = 10
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object EdtSoftwareSchluessel: TEdit
        Left = 82
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 1
      end
    end
    object RdGrpType: TRadioGroup
      Left = 8
      Top = 77
      Width = 306
      Height = 46
      BiDiMode = bdLeftToRight
      Caption = 'Typ:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'CD'
        'DVD')
      ParentBiDiMode = False
      TabOrder = 1
    end
    object RdGrpCategory: TRadioGroup
      Left = 8
      Top = 129
      Width = 137
      Height = 90
      Caption = 'Kategorie:'
      ItemIndex = 0
      Items.Strings = (
        'Film'
        'Musik'
        'Software'
        'Sonst. Daten')
      TabOrder = 2
      OnClick = OnClickKategorie
    end
    object EdtID: TEdit
      Left = 90
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object EdtName: TEdit
      Left = 90
      Top = 45
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object PnlMusik: TPanel
      Left = 8
      Top = 225
      Width = 306
      Height = 73
      TabOrder = 6
      object Label4: TLabel
        Left = 16
        Top = 13
        Width = 38
        Height = 13
        Caption = 'Format:'
      end
      object Label5: TLabel
        Left = 16
        Top = 43
        Width = 50
        Height = 13
        Caption = 'Kategorie:'
      end
      object EdtMusikFormat: TEdit
        Left = 82
        Top = 10
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object EdtMusikKategorie: TEdit
        Left = 82
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 1
      end
    end
    object PnlRest: TPanel
      Left = 8
      Top = 257
      Width = 306
      Height = 40
      TabOrder = 7
      OnClick = PnlRestClick
      object Label6: TLabel
        Left = 16
        Top = 13
        Width = 36
        Height = 13
        Caption = 'Zusatz:'
      end
      object EdtRestZusatz: TEdit
        Left = 82
        Top = 10
        Width = 121
        Height = 21
        TabOrder = 0
      end
    end
    object PnlFilm: TPanel
      Left = 8
      Top = 225
      Width = 306
      Height = 97
      TabOrder = 5
      object Label1: TLabel
        Left = 16
        Top = 13
        Width = 38
        Height = 13
        Caption = 'Format:'
      end
      object Label2: TLabel
        Left = 16
        Top = 43
        Width = 33
        Height = 13
        Caption = 'Lange:'
      end
      object Label3: TLabel
        Left = 16
        Top = 72
        Width = 50
        Height = 13
        Caption = 'Kategorie:'
      end
      object EdtFilmFormat: TEdit
        Left = 82
        Top = 10
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object EdtFilmLaenge: TEdit
        Left = 82
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object EdtFilmKategorie: TEdit
        Left = 82
        Top = 67
        Width = 121
        Height = 21
        TabOrder = 2
      end
    end
  end
  object BtnNewMedium: TButton
    Left = 6
    Top = 393
    Width = 99
    Height = 40
    Caption = 'Neues Medium'
    TabOrder = 2
    OnClick = BtnNewMediumClick
  end
  object BtnSaveMedium: TButton
    Left = 216
    Top = 393
    Width = 102
    Height = 40
    Caption = 'Medium speichern'
    TabOrder = 3
    OnClick = BtnSaveMediumClick
  end
  object MnMenu: TMainMenu
    object MnDatei: TMenuItem
      Caption = '&Datei'
      object MnAnzeigen: TMenuItem
        Caption = 'Anzeigen'
        OnClick = MnAnzeigenClick
      end
      object MnExit: TMenuItem
        Caption = 'Exit'
        ShortCut = 16465
        OnClick = MnExitClick
      end
    end
    object MnMedium: TMenuItem
      Caption = '&Medium'
      object MnNeu: TMenuItem
        Caption = 'Neu'
        Enabled = False
        ShortCut = 16462
      end
      object MnSpeichern: TMenuItem
        Caption = 'Speichern'
        Enabled = False
        ShortCut = 16467
      end
      object MnSortieren: TMenuItem
        Caption = 'Sortieren nach'
        object MnSID: TMenuItem
          Caption = 'ID'
          ShortCut = 49225
          OnClick = MnSIDClick
        end
        object MnSName: TMenuItem
          Caption = 'Name'
          OnClick = MnSNameClick
        end
      end
    end
  end
end
