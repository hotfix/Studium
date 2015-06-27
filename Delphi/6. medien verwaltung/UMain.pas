//----------------------------------------------------------
// Programm Beschreibung
//--------------------------
// Medienverwaltung ist ein Programm, mit dem man
// eine Struktur in seine CD/DVD Sammlungen bringen kann.
// Es bietet die Möglichkeit, eine CD-Sammlung komplett
// aufzunehmen, sie durchzunummerieren und
// zusätzliche Informationen über die einzelnen Datenträger
// zu speichern.
// --------------------------
//  HauptUnit zur steuerung des Formulares
//
// Erstellt von: Bastian Terfloth und Alexander Albrant
//           am: 23.05.07
//      Version: 1.05 neuste
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
    OpnDlgOpenFile: TOpenDialog;
    SvDlgSaveFile: TSaveDialog;
    MnOpenCreate: TMenuItem;
    MnHTML: TMenuItem;
    MnKategorie: TMenuItem;
    MnTyp: TMenuItem;
    procedure MnSpeichernClick(Sender: TObject);
    procedure MnNeuClick(Sender: TObject);
    procedure MnHTMLClick(Sender: TObject);
    procedure OnClose(Sender: TObject; var Action: TCloseAction);
    procedure MnOpenCreateClick(Sender: TObject);
    procedure SortClick(Sender: TObject);
    procedure MnAnzeigenClick(Sender: TObject);
    procedure MnExitClick(Sender: TObject);
    procedure BtnNavPrevClick(Sender: TObject);
    procedure BtnNavNextClick(Sender: TObject);
    procedure BtnSaveMediumClick(Sender: TObject);
    procedure BtnNewMediumClick(Sender: TObject);
    procedure OnClickKategorie(Sender: TObject);
    procedure OnFormCreate(Sender: TObject);
    procedure MbMediumTabelleClick(Sender: TObject);
  private
    { Private declarations }
    procedure ActivatePanels();
    procedure FillNavEdits(SetIndex : TNummer);
    procedure FillIndiEdits(ID : TNummer; Name : string);
    procedure FillKategorieEdits(Medium : TMedium);
    procedure GetDataSetData(Default : boolean);
    procedure SetKategorieRdGrp(Kategorie : TKategorie);
    procedure SetTypRdGrp(TypNr : TTyp);
    procedure InitMain();
    function  IsSetKategorie(): boolean;
    function  IsSetTyp():boolean;
    procedure Sortiere(SortierKriterium : TMerkmal);
    procedure UpDateComponents();
    procedure MnBtnShowNewMedium(visible : boolean);
    procedure MnBtnShowSaveMedium(visible : boolean);
    procedure NewMedium();
    procedure SaveMedium();
    var
       OpenFileName : string[50]; //Dateiname der aktuell geöffneten Datei
       Schreibschutz : boolean;   //Schreibschutz bei aktueller Datei aktiv

  public
    { Public declarations }
   end;

var
  FrmMain: TFrmMain;

implementation

uses
  UDaten, UTabelle, UHTML, UFileTools;

//Globale Variablen
var
  AktPosition : TNummer;

{$R *.dfm}

{-----------------------------------------------------------------
MnOpenCreateClick: Offnen der Datei mit Hilfe von TOpenDialog
-----------------------------------------------------------------}
procedure TFrmMain.MnOpenCreateClick(Sender:TObject);
begin
  if OpnDlgOpenFile.Execute then
  begin
    if OpenFileName <> '' then
      if NOT(SchliesseDatei()) then
        showMessage('Fehler bei CloseDatei');

    if FileExists(OpnDlgOpenFile.FileName) then
    begin
      Schreibschutz := CheckReadOnly(OpnDlgOpenFile.FileName);
      if  CheckFileSize(OpnDlgOpenFile.FileName, GetRecordSize()) then
      begin
       if OeffneDatei(OpnDlgOpenFile.FileName,Schreibschutz) then
       begin
         //Datei wurde erfolgreich geöffnet
         OpenFileName := OpnDlgOpenFile.FileName;
         AktPosition := 0;
         if GetFuellStand() > 0 then
         begin
           //mindestens 1 DatenSatz
           GetDataSetData(FALSE);
         end
         else
         begin
           //Kein Datensatz
           GetDataSetData(TRUE); 
         end;
       end
       else
         showMessage('Öffnen von Datei nicht erfolgreich')
      end
      else
      begin
        showMessage('Die Datei hat leider nicht das richtige Format');
      end;
    end
    else //Datei existiert nicht, also muss eine Neue erstellt werden
    if Dateierstellen(OpnDlgOpenFile.FileName) then
    begin
      //ShowMessage('Datei konnte erfolgreich erstellt werden');
      OpenFileName := OpnDlgOpenFile.FileName;
      AktPosition := 0;
      FillKategorieEdits(CDefaultMedium);
      FillNavEdits(AktPosition);
      FillIndiEdits(CDefaultMedium.ID,CDefaultMedium.Name);
    end
    else
      ShowMessage('Datei konnte nicht erstellt werden');
    UpdateComponents();
  end;
end;

procedure TFrmMain.MnSpeichernClick(Sender: TObject);
begin
  SaveMedium();
end;

{-----------------------------------------------------------------
Hauptmenüeintrag: Anzeigen der Tabelle (UTabelle)
-----------------------------------------------------------------}
procedure TFrmMain.MnAnzeigenClick(Sender: TObject);
var
  dummy : integer;
begin
   FrmTabelle.FillTable();
   dummy := FrmTabelle.ShowModal;
end;

{-----------------------------------------------------------------
Hauptmenüeintrag: Beendet das Programm
-----------------------------------------------------------------}
procedure TFrmMain.MnExitClick(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------
Hauptmenüeintrag: Speichert die HTML-Datei
-----------------------------------------------------------------}
procedure TFrmMain.MnHTMLClick(Sender: TObject);
begin
  if SvDlgSaveFile.Execute() then
  begin
     if NOT(OpenTempFile(SvDlgSaveFile.FileName)) then
     begin
       showmessage('Speichern in HTML konnte nicht ausgeführt werden!');
     end;
  end;
end;

{-----------------------------------------------------------------
Hauptmenüeintrag: Speichert die HTML-Datei
-----------------------------------------------------------------}
procedure TFrmMain.MnNeuClick(Sender: TObject);
begin
  NewMedium();
end;

{-----------------------------------------------------------------
Sortiere: Sortiert die Daten anhand von Kriterien mit BubbleSort
-----------------------------------------------------------------}
procedure TFrmMain.Sortiere(SortierKriterium : TMerkmal);
begin
 if NOT(BubbleSort(SortierKriterium)) then
 begin
   showmessage('Sortieren hat leider nicht funktioniert!');
 end;
end;

{-----------------------------------------------------------------
SortClick: Übergibt das gewünschte Sortierkriterium an Sortiere
-----------------------------------------------------------------}
procedure TFrmMain.SortClick(Sender: TObject);

begin
  if Sender = MnSID then Sortiere(ID);
  if Sender = MnSName then Sortiere(N);
  if Sender = MnKategorie then Sortiere(K);
  if Sender = MnTyp then Sortiere(T);
end;


{-----------------------------------------------------------------
öffnet ein neues Formular(UTabelle) in dem die Datensätze stehen
------------------------------------------------------------------}
procedure TFrmMain.MbMediumTabelleClick(Sender: TObject);
begin
  FrmTabelle.ShowModal;
end;



{-----------------------------------------------------------------
Aktualisiert die jeweiligen Panels nachdem die Kategorie geleeert wurde
------------------------------------------------------------------}
procedure TFrmMain.OnClickKategorie(Sender: TObject);
begin
  ActivatePanels();
end;

procedure TFrmMain.OnClose(Sender: TObject; var Action: TCloseAction);
begin
 if OpenFileName <> '' then
 begin
   if NOT(SchliesseDatei()) then
     showMessage('Beim Schliessen der Datei ist ein Fehler aufgetreten');
 end;
end;

{-----------------------------------------------------------------
Initialisiert alle wichtigen Komponenten und Variablen
------------------------------------------------------------------}
procedure TFrmMain.OnFormCreate(Sender: TObject);
begin
 initMain();
end;

{-----------------------------------------------------------------
Initialisiert alle wichtigen Komponenten und Variablen
-----------------------------------------------------------------}
procedure TFrmMain.InitMain();

begin
  AktPosition := 0;        //Aktuelle Position des zu lesenden Datensatzes = 0
  OpenFileName := '';      //Aktueller Dateiname = ''
  OpnDlgOpenFile.InitialDir := ExtractFilePath(Application.Exename);
  Schreibschutz := FALSE;
  initMaxID();             //Setzt die Anzahl der Elemente auf 0
  UpDateComponents();      //Aktualisiert die grafischen Komponenten
end;

{-----------------------------------------------------------------
Alle grafischen Komponenten die "NewMedium" aufrufen werden aktiviert/deaktiviert
-----------------------------------------------------------------}
procedure TFrmMain.MnBtnShowNewMedium(visible : boolean);
begin
 BtnNewMedium.Enabled := visible;
 MnNeu.Enabled := visible;
end;

{-----------------------------------------------------------------
Alle grafischen Komponenten die "SaveMEdium" aufrufen werden aktiviert/deaktiviert
-----------------------------------------------------------------}
procedure TFrmMain.MnBtnShowSaveMedium(visible : boolean);
begin
  BtnSaveMedium.Enabled := visible;
  MnSpeichern.Enabled := visible;
end;

{-----------------------------------------------------------------
Grafische Komponenten werden aktiviert/deaktiviert
-----------------------------------------------------------------}
procedure TFrmMain.UpDateComponents();
begin
  if OpenFileName = '' then
  begin
    //Wenn keine Datei geladen wurde
    MnBtnShowNewMedium(FALSE);
    MnBtnShowSaveMedium(FALSE);
    MnSortieren.Enabled := FALSE;
    MnAnzeigen.Enabled := FALSE;
    MnHTML.Enabled := FALSE;
    BtnNavPrev.Enabled := FALSE;
    BtnNavNext.Enabled := FALSE;
  end
  else
  begin
    //Wenn eine Datei geladen wurde
    BtnNavPrev.Enabled := (OpenFileName <> '') AND (AktPosition > 0);
    BtnNavNext.Enabled := (AktPosition+1 < getFuellstand());
    MnBtnShowNewMedium((AktPosition <> getFuellStand()) AND NOT(Schreibschutz));
    MnBtnShowSaveMedium(NOT(Schreibschutz));
    MnAnzeigen.Enabled := (OpenFileName <> '') AND (getFuellStand() > 0);
    MnSortieren.Enabled := (OpenFileName <> '') AND (getFuellStand() > 1) AND
                            NOT(Schreibschutz);
    MnHTML.Enabled := (OpenFileName <> '') AND (getFuellStand() > 0);
  end;
end;

{-----------------------------------------------------------------
Aktualisiert die GFX-Komponenten entsprechend der Einträge
in der aktuellen Kategorie (RdGrpKategorie)
-----------------------------------------------------------------}
procedure TFrmMain.ActivatePanels();
begin
  PnlFilm.Visible  :=  RdGrpCategory.ItemIndex = 0;
  PnlMusik.Visible := RdGrpCategory.ItemIndex = 1;
  PnlSoftware.Visible := RdGrpCategory.ItemIndex = 2;
  PnlRest.Visible := RdGrpCategory.ItemIndex = 3;
end;

{-----------------------------------------------------------------
Aktualisiert die GFX-Komponenten entsprechend der Einträge
in der aktuellen Kategorie (RdGrpKategorie)
-----------------------------------------------------------------}
procedure TFrmMain.BtnNavNextClick(Sender: TObject);
begin
  inc(AktPosition);
  GetDataSetData(FALSE);
  UpDateComponents();
end;

{-----------------------------------------------------------------
Zeigt den vorigen Datensatz an, Aktualisiert entsprechend die Navigation,
Holt die Daten des vorigen Datensatzes und Aktiviert die entsprechenden Panels
-----------------------------------------------------------------}
procedure TFrmMain.BtnNavPrevClick(Sender: TObject);

begin
  dec(AktPosition);
  GetDataSetData(FALSE);
  UpDateComponents();
end;

{-----------------------------------------------------------------
ݢerpr��� ob der aktuelle Datensatz ge寤ert werden darf,
erwartet ggf. eine Best嵩gung vom Benutzer und.
------------------------------------------------------------------
Ausf���ung: Durch Button 'Neues Medium'
-----------------------------------------------------------------}
procedure TFrmMain.BtnNewMediumClick(Sender: TObject);
begin
  NewMedium();
end;

procedure TFrmMain.NewMedium();
begin
  AktPosition := getFuellstand();
  FillKategorieEdits(CDefaultMedium);
  FillNavEdits(AktPosition);
  FillIndiEdits(AktPosition,CDefaultMedium.Name);
  UpdateComponents();
end;

{-----------------------------------------------------------------
Aktuelle Daten in den Textfeldern werden in der Datei gespeichert
-----------------------------------------------------------------}
procedure TFrmMain.BtnSaveMediumClick(Sender: TObject);
begin
  SaveMedium();
end;

procedure TFrmMain.SaveMedium;
var
 Medium : TMedium; //ein einzelnes Medium

begin
  //Pruefe ob Kategorie und Typ Gesetzt sind
  if IsSetKategorie() AND IsSetTyp() then
  begin
   with Medium do
   begin
    case RdGrpType.ItemIndex of
     0 : Typ := CD;
     1 : Typ := DVD;
    end;
    case RdGrpCategory.ItemIndex of
      0 : Kategorie := Film;
      1 : Kategorie :=  Musik;
      2 : Kategorie := Software;
      3 : Kategorie := Sonst_Daten;
    end;

    ID := StrToInt(EdtID.Text);
    Name := EdtName.Text;

    case Kategorie of
      Film: begin
              FFormat := EdtFilmFormat.Text;
              Laenge := StrToInt(EdtFilmLaenge.Text);
              FilmKategorie := EdtFilmKategorie.Text;
            end;
      Musik: begin
              MFormat := EdtMusikFormat.Text;
              MusikKategorie := EdtMusikKategorie.Text;
             end;
      Software: begin
                  Hersteller := EdtSoftwareHersteller.Text;
                  Schluessel := EdtSoftwareSchluessel.Text;
                end;
      Sonst_Daten: begin
              Zusatz := EdtRestZusatz.Text;
            end;
    end; //with ende
  end;
  if NOT(setMedium(AktPosition, Medium, TRUE)) then
    ShowMessage('Fehler beim Speichern des Mediums');
  UpDateComponents();
 end
  else
    showmessage('Sie Haben die Kategorie und/oder den Typ nicht gesetzt');
end;

{-----------------------------------------------------------------!
Setzt alle Editfelder der Navigation
-----------------------------------------------------------------}
procedure TFrmMain.FillNavEdits(SetIndex : TNummer);
var
  MaxIndex : TNummer;

begin
  if AktPosition+1 > getFuellstand() then
    MaxIndex := AktPosition+1
  else
    MaxIndex := getFuellstand();

  EdtNavActID.Text := IntToStr(SetIndex+1);
  EdtNavMaxID.Text := IntToStr(MaxIndex);
end;


{-----------------------------------------------------------------!
function die überrprüft ob die Checkbox Kategorie gesetzt ist
-----------------------------------------------------------------}
function TFrmMain.IsSetKategorie(): boolean;
begin
  IsSetKategorie :=  RdGrpCategory.ItemIndex <> -1;
end;

{-----------------------------------------------------------------
function die übrprüft ob die Checkbox Typ (CD,DVD) gesetzt ist
-----------------------------------------------------------------}
function TFrmMain.IsSetTyp():boolean;
begin
  IsSetTyp := RdGrpType.ItemIndex <> -1;
end;

{-----------------------------------------------------------------
Prozedur die alle Kategorieunabhängigen Editfelder füllt
-----------------------------------------------------------------}
procedure TFrmMain.FillIndiEdits(ID: TNummer; Name: string);
begin
  EdtID.Text := IntToStr(ID);
  EdtName.Text := Name;
end;

{-----------------------------------------------------------------
Ganz komische ���rfl���ige Prozedur :)
ich wollte halt eigentlich die TKategorie eingeben und den entsprechenden
ItemIndex zur���kriegen.
-----------------------------------------------------------------}
procedure TFrmMain.SetKategorieRdGrp(Kategorie : TKategorie);
begin
  RdGrpCategory.ItemIndex := ord(Kategorie);
end;

{-----------------------------------------------------------------
Prozedur zum setzen der Typ Checkbox
-----------------------------------------------------------------}
procedure TFrmMain.SetTypRdGrp(TypNr : TTyp);
begin
    RdGrpType.ItemIndex := ord(TypNr);
end;


{-----------------------------------------------------------------
Prozedur die die DAten aus der Datei holt und in die Editfelder schreibt
-----------------------------------------------------------------}
procedure TFrmMain.GetDataSetData(Default : boolean);
var
  TempMedium : TMedium;
begin
  if not(Default) then
  begin
    TempMedium := getMedium(AktPosition);
    FillKategorieEdits(TempMedium);
    FillNavEdits(AktPosition);
    FillIndiEdits(TempMedium.ID,TempMedium.Name);
    case TempMedium.Typ of
      CD: SetTypRdGrp(CD);
      DVD: SetTypRdGrp(DVD);
    end;
    SetKategorieRdGrp(TempMedium.Kategorie);
  end
  else
  begin
    FillKategorieEdits(CDefaultMedium);
    FillNavEdits(AktPosition);
    FillIndiEdits(CDefaultMedium.ID,CDefaultMedium.Name);
  end;
end;

{-----------------------------------------------------------------
Prozedur die die Editfelder der entsprechenden Kategorie füllt
------------------------------------------------------------------
Benötigt Medium.TSingleMedium für Kategorieauswahl und entspr
fill
-----------------------------------------------------------------}
procedure TFrmMain.FillKategorieEdits(Medium : TMedium);
begin
  with Medium do
  begin
  case Kategorie of
   Film : begin
            EdtFilmFormat.Text := FFormat;
            EdtFilmLaenge.Text := intToStr(Laenge);
            EdtFilmKategorie.Text := FilmKategorie;
          end;
   Musik : begin
             EdtMusikFormat.Text := FFormat;
             EdtMusikKategorie.Text := MusikKategorie;
           end;
   Software : begin
                EdtSoftwareHersteller.Text := Hersteller;
                EdtSoftwareSchluessel.Text := Schluessel;
              end;
   Sonst_Daten : begin
            EdtRestZusatz.Text := Zusatz;
          end;
   end;
  end; //with ende
end;


end.
