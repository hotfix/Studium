//----------------------------------------------------------
// Programm Beschreibung
//--------------------------
// Medienverwaltung ist ein Programm, mit dem man
// eine Struktur in seine CD/DVD Sammlungen bringen kann.
// Es bietet die M√∂glichkeit, eine CD-Sammlung komplett
// aufzunehmen, sie durchzunummerieren und
// zus√§tzliche Informationen √ºber die einzelnen Datentr√§ger
// zu speichern.
// --------------------------
//  HauptUnit zur steuerung des Formulares
//
// Erstellt von: Bastian Terfloth und Alexander Albrant
//           am: 23.05.07
//      Version: 1.01
//----------------------------------------------------------
unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls , UTypen;

type
  TFrmMain = class(TForm)
    MnMenu: TMainMenu;
    MnDatei: TMenuItem;
    MnMedium: TMenuItem;
    BtnNavPrev: TButton;
    BtnNavNext: TButton;
    PnlNav: TPanel;
    Panel2: TPanel;
    PnlSoftware: TPanel;
    BtnNewMedium: TButton;
    BtnSaveMedium: TButton;
    RdGrpType: TRadioGroup;
    RdGrpCategory: TRadioGroup;
    LblID: TLabel;
    LblName: TLabel;
    EdtID: TEdit;
    BtnNavOf: TLabel;
    EdtNavActID: TEdit;
    EdtNavMaxID: TEdit;
    LblPublisher: TLabel;
    EdtSoftwareHersteller: TEdit;
    EdtSoftwareSchluessel: TEdit;
    LblKey: TLabel;
    EdtName: TEdit;
    PnlFilm: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdtFilmFormat: TEdit;
    EdtFilmLaenge: TEdit;
    Label3: TLabel;
    EdtFilmKategorie: TEdit;
    PnlMusik: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    EdtMusikFormat: TEdit;
    EdtMusikKategorie: TEdit;
    PnlRest: TPanel;
    Label6: TLabel;
    EdtRestZusatz: TEdit;
    MnAnzeigen: TMenuItem;
    MnExit: TMenuItem;
    MnNeu: TMenuItem;
    MnSpeichern: TMenuItem;
    MnSortieren: TMenuItem;
    MnSID: TMenuItem;
    MnSName: TMenuItem;
    procedure MnSIDClick(Sender: TObject);

    procedure MnAnzeigenClick(Sender: TObject);

    procedure MnExitClick(Sender: TObject);
    procedure PnlRestClick(Sender: TObject);

     procedure BtnNavPrevClick(Sender: TObject);
    procedure BtnNavNextClick(Sender: TObject);
    procedure BtnSaveMediumClick(Sender: TObject);
    procedure BtnNewMediumClick(Sender: TObject);
    procedure OnClickKategorie(Sender: TObject);
    procedure OnFormCreate(Sender: TObject);
    procedure MbMediumTabelleClick(Sender: TObject);
    procedure MnSNameClick(Sender: TObject);
  private
    { Private declarations }
    procedure ActivatePanels();
    procedure FillNavEdits(SetIndex : TArraySize); //Navigation
    procedure FillIndiEdits(ID : TArraySize; Name : string); //KatgegorieunabhÂØßige
    procedure FillKategorieEdits(Medium : TSingleMedium); //Kategorieabh√§ngige
    procedure SetKategorieRdGrp(Kategorie : TKategorien);
    procedure SetTypRdGrp(TypNr : TTypes);
    procedure InitMain();   //Initialisiert die Medienverwaltung zu Beginn
    function IsSetKategorie(): boolean; //gibt TRUE wenn Kategorie gesetzt wurde
    function IsSetTyp():boolean; //Gibt TRUE wenn der Typ (CD,DVD) gesetzt wurde
    procedure GetDataSetData(ArrayIndex : TArraySize);
    procedure ActivateNavigation();
    procedure ActivateMainButtons();
    procedure FillDefault();
    procedure Sortiere(SortierKriterium : TSortType);

  public
    { Public declarations }
   end;

var
  FrmMain: TFrmMain;

implementation

uses
  UDaten, UTabelle;

//Globale Variablen
var
  AktArrayIndex : TArraySize;

{$R *.dfm}

{-----------------------------------------------------------------
Hauptmen√ºeintrag: Anzeigen der Tabelle (UTabelle)
-----------------------------------------------------------------}
procedure TFrmMain.MnAnzeigenClick(Sender: TObject);
begin
   FrmTabelle.ShowModal;
end;

{-----------------------------------------------------------------
Hauptmen√ºeintrag: Beendet das Programm
-----------------------------------------------------------------}
procedure TFrmMain.MnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

{-----------------------------------------------------------------
Sortiert
-----------------------------------------------------------------}
procedure TFrmMain.Sortiere(SortierKriterium : TSortType);
begin
  if BubbleSort(SortierKriterium) then showmessage('Sortiert')
  else showmessage('Sortieren geht nicht');
end;

{-----------------------------------------------------------------
Hauptmen√ºeintrag: Sortieren nach -> ID
-----------------------------------------------------------------}
procedure TFrmMain.MnSIDClick(Sender: TObject);

begin
  Sortiere(IDS);
end;


procedure TFrmMain.MnSNameClick(Sender: TObject);
begin
  Sortiere(SName);
end;


{-----------------------------------------------------------------
√∂ffnet ein neues Formular(UTabelle) in dem die DatensÂµ∫e stehen
------------------------------------------------------------------
AusfÌ©≤ung: MainMenu1 -> Medium -> Tabelle anzeigen
-----------------------------------------------------------------}
procedure TFrmMain.MbMediumTabelleClick(Sender: TObject);
begin
  FrmTabelle.ShowModal;
end;



{-----------------------------------------------------------------
Aktualisiert die jeweiligen Panels nachdem die Kategorie geleeert wurde
------------------------------------------------------------------
Ausfl√∂ung: Wenn auf die Kategorien geklickt wurde
-----------------------------------------------------------------}
procedure TFrmMain.OnClickKategorie(Sender: TObject);
begin
  ActivatePanels();
end;

{-----------------------------------------------------------------
Initialisiert alle wichtigen Komponenten und Variablen
------------------------------------------------------------------
AusfÌ©≤ung: Beim ProgrammStart
-----------------------------------------------------------------}
procedure TFrmMain.OnFormCreate(Sender: TObject);
begin
  initMain();
  ActivatePanels();
  BtnNewMedium.Enabled := False;
end;

procedure TFrmMain.PnlRestClick(Sender: TObject);
begin

end;

{-----------------------------------------------------------------
Aktualisiert die GFX-Komponenten entsprechend der Eintr√§ge
in der aktuellen Kategorie (RdGrpKategorie)
-----------------------------------------------------------------}
procedure TFrmMain.ActivatePanels();
begin
  PnlFilm.Visible  :=  RdGrpCategory.ItemIndex = 0;
  PnlMusik.Visible := RdGrpCategory.ItemIndex = 1;
  PnlSoftware.Visible := RdGrpCategory.ItemIndex = 2;
  PnlRest.Visible := RdGrpCategory.ItemIndex = 3;
  Panel2.Visible := AktArrayIndex <> 0;
end;

{-----------------------------------------------------------------
Aktualisiert die GFX-Komponenten entsprechend der Eintr√§ge
in der aktuellen Kategorie (RdGrpKategorie)
-----------------------------------------------------------------}
procedure TFrmMain.BtnNavNextClick(Sender: TObject);
begin
  AktArrayIndex := AktArrayIndex + 1;
  FillNavEdits(AktArrayIndex);
  GetDataSetData(AktArrayIndex);
  ActivatePanels();
  ActivateNavigation();
  ActivateMainButtons();
end;

{-----------------------------------------------------------------
Zeigt den vorigen Datensatz an, Aktualisiert entsprechend die Navigation,
Holt die Daten des vorigen Datensatzes und Aktiviert die entsprechenden Panels
-----------------------------------------------------------------}
procedure TFrmMain.BtnNavPrevClick(Sender: TObject);
begin
  AktArrayINdex := AktArrayIndex - 1;
  FillNavEdits(AktArrayIndex);
  GetDataSetData(AktArrayIndex);
  ActivatePanels();
  ActivateNavigation();
  ActivateMainButtons();
end;

{-----------------------------------------------------------------
›¢erprÌß¥ ob der aktuelle Datensatz geÂØ§ert werden darf,
erwartet ggf. eine BestÂµ©gung vom Benutzer und.
------------------------------------------------------------------
AusfÌ©≤ung: Durch Button 'Neues Medium'
-----------------------------------------------------------------}
procedure TFrmMain.BtnNewMediumClick(Sender: TObject);
begin
  
  if (AktArrayIndex > GetNewDataCount()) then
  begin
    showMessage('Dies ist schon ein Neue Datensatz. Schreib hier erstmal was rein!');
  end
  else
  begin
    AktArrayIndex := GetNewDataCount() + 1;
    FillDefault();
  end;
  ActivatePanels();
  ActivateNavigation();
  ActivateMainButtons();
end;

{-----------------------------------------------------------------
Aktuelle Daten in den Textfeldern werden im Array gespeichert
-----------------------------------------------------------------}
procedure TFrmMain.BtnSaveMediumClick(Sender: TObject);
var
 Medium : TSingleMedium;

begin
  //Pruefe ob Kategorie und Typ Gesetzt sind
  if IsSetKategorie() AND IsSetTyp() then
  begin
   //--
   //Medien Typ
   with Medium do
   begin
    case RdGrpType.ItemIndex of
     0 : Typ := CD;
     1 : Typ := DVD;
    end;
    //Medien Kategorie
    case RdGrpCategory.ItemIndex of
      0 : Kategorien := Film;
      1 : Kategorien :=  Musik;
      2 : Kategorien := Software;
      3 : Kategorien := Rest;
    end;

    ID := StrToInt(EdtID.Text);
    Name := EdtName.Text;

    case Kategorien of
      Film: begin
              FilmFormat := EdtFilmFormat.Text;
              Laenge := StrToInt(EdtFilmLaenge.Text);
              FilmKategorie := EdtFilmKategorie.Text;
            end;
      Musik: begin
              MusikFormat := EdtMusikFormat.Text;
              MusikKategorie := EdtMusikKategorie.Text;
             end;
      Software: begin
                  Hersteller := EdtSoftwareHersteller.Text;
                  Schluessel := EdtSoftwareSchluessel.Text;
                end;
      Rest: begin
              Zusatz := EdtRestZusatz.Text;
            end;
    end; //with ende
  end;
  DSaveMedium(AktArrayIndex, Medium); //AktArrayIndex oder ID :)?
  if AktArrayIndex = getNewDataCount() + 1 then
      SetNewDataCount(GetNewDataCount()+1);
   FillNavEdits(AktArrayIndex);
   ActivateNavigation();
   ActivateMainButtons();
 end
  else
    showmessage('Sie Haben die Kategorie und/oder den Typ nicht gesetzt');
end;

{-----------------------------------------------------------------!
Initialisiert alle wichtigen Komponenten und Variablen
-----------------------------------------------------------------}
procedure TFrmMain.InitMain();

begin
  InitNewDataCount();                 //Setzt die anzahl an bereits erstellten Daten
  AktArrayIndex := 1;                 //DerArrayIndex wird initialisiert
  FillDefault();
  ActivateNavigation();
  ActivateMainButtons();
  EdtNavMaxID.Enabled:=false;
  EdtNavActID.Enabled := false;
  EdtID.Enabled:= false;
end;

{-----------------------------------------------------------------!
Setzt alle Editfelder der Navigation
-----------------------------------------------------------------}
procedure TFrmMain.FillNavEdits(SetIndex : TArraySize);
begin
  EdtNavActID.Text := IntToStr(SetIndex);
  EdtNavMaxID.Text := IntToStr(GetNewDataCount);
end;


{-----------------------------------------------------------------!
function die √ºberrpr√ºft ob die Checkbox Kategorie gesetzt ist
-----------------------------------------------------------------}
function TFrmMain.IsSetKategorie(): boolean;
begin
  IsSetKategorie :=  RdGrpCategory.ItemIndex <> -1;
end;

{-----------------------------------------------------------------
function die √ºbrpr√ºft ob die Checkbox Typ (CD,DVD) gesetzt ist
-----------------------------------------------------------------}
function TFrmMain.IsSetTyp():boolean;
begin
  IsSetTyp := RdGrpType.ItemIndex <> -1;
end;

{-----------------------------------------------------------------
Prozedur die alle Kategorieunabh√§ngigen Editfelder f√ºllt
-----------------------------------------------------------------}
procedure TFrmMain.FillIndiEdits(ID: TArraySize; Name: string);
begin
  EdtID.Text := IntToStr(ID);
  EdtName.Text := Name;
end;

{-----------------------------------------------------------------
Ganz komische Ì£•rflÌ¥≥ige Prozedur :)
ich wollte halt eigentlich die TKategorie eingeben und den entsprechenden
ItemIndex zurÌ§´kriegen.
-----------------------------------------------------------------}
procedure TFrmMain.SetKategorieRdGrp(Kategorie : TKategorien);
begin
  case Kategorie of
    Film  : RdGrpCategory.ItemIndex := 0;
    Musik  : RdGrpCategory.ItemIndex := 1;
    Software  : RdGrpCategory.ItemIndex := 2;
    Rest  : RdGrpCategory.ItemIndex := 3;
  end;
end;

{-----------------------------------------------------------------
Prozedur zum setzen der Typ Checkbox
-----------------------------------------------------------------}
procedure TFrmMain.SetTypRdGrp(TypNr : TTypes);
begin
  case TypNr of
    CD  : RdGrpType.ItemIndex := 0;
    DVD  : RdGrpType.ItemIndex := 1;
  end;
end;


{-----------------------------------------------------------------
Wichtige Prozedur, die die Daten per GetMedium aus der UDaten holt
und sie dann entsprechend der Kategorie in die Editfelder schreibt
-----------------------------------------------------------------}
procedure TFrmMain.GetDataSetData(ArrayIndex : TArraySize);
var
  OneMedium : TSingleMedium;
begin
  OneMedium := GetMedium(ArrayIndex);
  case OneMedium.Typ of
    CD: SetTypRdGrp(CD);
    DVD: SetTypRdGrp(DVD);
  end;
  FillIndiEdits(OneMedium.ID,OneMedium.Name);
  SetKategorieRdGrp(OneMedium.Kategorien);
  FillKategorieEdits(OneMedium);
end;

procedure TFrmMain.ActivateNavigation();
begin
  BtnNavPrev.Enabled := (AktArrayIndex <> low(TArraySize)+1) AND (AktArrayIndex > 0);
  BtnNavNext.Enabled := AktArrayIndex < GetNewDataCount();
end;

procedure TFrmMain.ActivateMainButtons();
begin
  //BtnNewMedium.Enabled wird am anfang durch FormCreate auf False gesetzt
  BtnNewMedium.Enabled := (AktArrayIndex <> cArraySize);
  BtnSaveMedium.Enabled := AktArrayIndex <> low(TArraySize);
end;


{-----------------------------------------------------------------
Prozedur die die Editfelder der entsprechenden Kategorie f√ºllt
------------------------------------------------------------------
Ben√∂tigt Medium.TSingleMedium f√ºr Kategorieauswahl und entspr
fill
-----------------------------------------------------------------}
procedure TFrmMain.FillKategorieEdits(Medium : TSingleMedium);
begin
  with Medium do
  begin
  case Kategorien of
   Film : begin
            EdtFilmFormat.Text := FilmFormat;
            EdtFilmLaenge.Text := intToStr(Laenge);
            EdtFilmKategorie.Text := FilmKategorie;
          end;
   Musik : begin
             EdtMusikFormat.Text := FilmFormat;
             EdtMusikKategorie.Text := MusikKategorie;
           end;
   Software : begin
                EdtSoftwareHersteller.Text := Hersteller;
                EdtSoftwareSchluessel.Text := Schluessel;
              end;
   Rest : begin
            EdtRestZusatz.Text := Zusatz;
          end;
   end;
  end; //with ende
end;

procedure TFrmMain.FillDefault();
begin
 FillNavEdits(AktArrayIndex);
 FillIndiEdits(GetNewDataCount()+1,'DefaultName');
 //Init Felder mit Default werten
 EdtFilmFormat.Text := 'DefaultMusikFormat';
 EdtFilmLaenge.Text := '0';
 EdtFilmKategorie.Text := 'DefaultFilmKat';
 EdtMusikFormat.Text := 'DefaultMusikFormat';
 EdtMusikKategorie.Text := 'DefaultMusikKategorie';
 EdtSoftwareHersteller.Text := 'DefaultSoftwareHersteller';
 EdtSoftwareSchluessel.Text := 'DefaultKey';
 EdtRestZusatz.Text := 'DefaultText Zusatz';
end;

end.
