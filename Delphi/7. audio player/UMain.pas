unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, XPMan, StdCtrls, UTypes, ComCtrls, ExtCtrls, Grids;

type
  TfrmMain = class(TForm)
    XPManifest1: TXPManifest;
    MediaPlayer: TMediaPlayer;
    OpenFile: TOpenDialog;
    Bt_AddFile: TButton;
    Lb_Songs: TListBox;
    Bt_Save: TButton;
    saveFile: TSaveDialog;
    Bt_Open: TButton;
    Bt_Next: TButton;
    Bt_First: TButton;
    Lb_Title: TLabel;
    Bt_Stop: TButton;
    Bt_Play: TButton;
    Timer: TTimer;
    ProgressBar: TProgressBar;
    Bt_Prev: TButton;
    Bt_MoveUp: TButton;
    Bt_MoveDown: TButton;
    Bt_DeleteSongs: TButton;
    bt_atposition: TButton;
    StrGrPlaylists: TStringGrid;
    Bt_ToList: TButton;
    procedure Bt_ToListClick(Sender: TObject);
    procedure bt_atpositionClick(Sender: TObject);
    procedure Bt_MoveDownClick(Sender: TObject);
    procedure Bt_MoveUpClick(Sender: TObject);
    procedure Bt_DeleteSongsClick(Sender: TObject);
    procedure Bt_PrevClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Bt_StopClick(Sender: TObject);
    procedure Bt_PlayClick(Sender: TObject);
    procedure Bt_FirstClick(Sender: TObject);
    procedure Bt_Next_Click(Sender: TObject);
    procedure Bt_OpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Bt_SaveClick(Sender: TObject);
    procedure Bt_AddFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure ListToBox;
    procedure UpdateButtons;

    procedure InitStrGr();


  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


uses UList, UFile;

procedure TfrmMain.UpdateButtons;
begin
  //Save
  Bt_Save.Enabled := NumberOfElements() > 0;
  
  //Next
  Bt_Next.Enabled := (NumberOfElements() > 1) AND
                     (Lb_Songs.Items.count > Lb_Songs.ItemIndex+1);
  //First
  Bt_First.Enabled := (NumberOfElements() > 0) AND
                      (Lb_Songs.ItemIndex <> 0);
  //Stop
  Bt_Stop.Enabled := (NumberOfElements() > 0) AND
                     (Progressbar.Position <> 0) AND
                     (Progressbar.Position <> Progressbar.Max);
  //Play
  Bt_Play.Enabled := Lb_Songs.ItemIndex >= 0;

  //Prev
  Bt_Prev.Enabled := (NumberOfElements() > 1) AND
                     (Lb_Songs.ItemIndex > 0);
  //Moveup
  Bt_MoveUp.Enabled := (NumberOfElements() > 1) AND
                        (Lb_Songs.ItemIndex > 0);
  //MoveDown
  Bt_MoveDown.Enabled := (NumberOfElements() > 1) AND
                        (Lb_Songs.ItemIndex < NumberOfElements());
  //Delete Song
  Bt_DeleteSongs.Enabled := NumberOfElements() > 0;

  //ToPlaylist List
  Bt_ToList.Enabled := NumberOfElements() > 0;
end;

// Öffnet Open File Dialog, um einen Song der Listbox hinzuzufügen
procedure TfrmMain.Bt_AddFileClick(Sender: TObject);
begin         
  OpenFile.FilterIndex := 1;
  if OpenFile.Execute then
  begin
    if FileExists(OpenFile.FileName) then
    begin
        //Intern die Daten in der Liste (hinten) speichern
        AddElement(MakeElement(OpenFile.FileName));
        //Element der Listbox hinzufügen
        Lb_Songs.Items.Append((OpenFile.FileName));
        UpdateButtons();
    end
    else
      ShowMessage('Datei existiert nicht!');
  end;
end; //Add



// Setzt Playlist wieder an den Anfang
procedure TfrmMain.bt_atpositionClick(Sender: TObject);
var
  Dummy : boolean;
begin
 { Dummy := InsertElementAtPosition(Lb_Songs.ItemIndex+1,getInfo(1));
 ListToBox();}
end;

procedure TfrmMain.Bt_DeleteSongsClick(Sender: TObject);
var
  TempItemIndex : integer;
begin
  TempItemIndex := Lb_Songs.ItemIndex;
  DeleteElement();
  //Listbox neu zeichnen
  ListToBox();
  //Markierung (itemindex) an current anpassen
  if TempItemIndex > Lb_Songs.Items.Count-1 then
    Lb_Songs.ItemIndex := Lb_Songs.Items.Count-1
  else
    Lb_Songs.ItemIndex := TempItemIndex;


end;
//Uebergeht zum ersten Lied
procedure TfrmMain.Bt_FirstClick(Sender: TObject);
begin
  Lb_Songs.ItemIndex := 0;
  setCurrent(); //mit vorbehalt :P
  UpdateButtons();
end;
//Bewegt den Song nach unten
procedure TfrmMain.Bt_MoveDownClick(Sender: TObject);
var
  TempItemIndex : cardinal;
begin
  TempItemIndex :=  Lb_Songs.ItemIndex;
  VerschiebeElement(Lb_Songs.ItemIndex+1, FALSE);
  ListToBox();
  Lb_Songs.ItemIndex := TempItemIndex;
end;

//Bewegt den Song nach oben
procedure TfrmMain.Bt_MoveUpClick(Sender: TObject);
var
  TempItemIndex : cardinal;
begin
  TempItemIndex := Lb_Songs.ItemIndex;
  VerschiebeElement(Lb_Songs.ItemIndex+1, TRUE);
  ListToBox();
  Lb_Songs.ItemIndex := TempItemIndex;

end;


// Holt den nächsten Titel
procedure TfrmMain.Bt_Next_Click(Sender: TObject);
begin
  Lb_Songs.ItemIndex := Lb_Songs.ItemIndex + 1;
  IncCurrent();
  UpdateButtons();
end;  //Next


// Öffnet Playliste und liest sie in Liste, füllt Listbox
procedure TfrmMain.Bt_OpenClick(Sender: TObject);
begin
  OpenFile.FilterIndex := 2;
  if OpenFile.Execute then
  begin
    if getFileContent(OpenFile.FileName) then
    begin
      ListToBox();
    end
    else
      ShowMessage('Fehler: Falsches Format, leer oder readonly');
  end;
  UpdateButtons();
end; // Open



// Spielt aktuellen Song ab
procedure TfrmMain.Bt_PlayClick(Sender: TObject);
var TempInfo : TOneSong;
begin
  Progressbar.Max:=0;
  TempInfo :=GetInfo(Lb_Songs.ItemIndex+1);
  Lb_Title.Caption := TempInfo.Title;
  MediaPlayer.FileName := TempInfo.Title;
  MediaPlayer.Open;
  MediaPlayer.Play;
  Progressbar.Max := MediaPlayer.Length;
end; // Play

//Geht ein Lied zurueck
procedure TfrmMain.Bt_PrevClick(Sender: TObject);
begin
  Lb_Songs.ItemIndex := Lb_Songs.ItemIndex - 1;
  DecCurrent();
  UpdateButtons();
end;


// Läuft durch Liste und speichert jedes Element in Datei
procedure TfrmMain.Bt_SaveClick(Sender: TObject);
begin
  if SaveFile.Execute then
  begin
    if NOT(setFileContent(SaveFile.FileName)) then
      showMessage('Schreiben in Datei nicht erfolgreich, warscheinlich ReadOnly');
  end;
  UpdateButtons();
end;


// Stoppt Wiedergabe
procedure TfrmMain.Bt_StopClick(Sender: TObject);
begin
  Mediaplayer.Stop;
  Mediaplayer.Close;
  UpdateButtons();
end;

//Speichert Playlist in StrGr
procedure TfrmMain.Bt_ToListClick(Sender: TObject);
var i : integer;
    Title : string;
begin
  Title := '';
  //Setze Die Lieder zusammen
  for i := 0 to Lb_Songs.Items.count-1 do
  begin
    title := title + ExtractFileName(Lb_Songs.Items[i]);
  end;
  //Zeichne StrGr
  with StrGrPlaylists do
    begin
      Cells [0,RowCount-1] := inttostr(RowCount-1);
      AddPlaylist(makePlaylist(Title));
      Cells [1,RowCount-1] := title;
      RowCount := RowCount +1;
      //ShowMessage(inttostr(RowCount));
    end;
end;


// Schließt Form, DeInit Listen
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  case Action of
    caNone : close();
    caHide : ;
    caFree : begin
               DeinitList();
               close();
             end;
    caMinimize : ;
  end;
end;

//Disabled Buttons für Programmstart
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //OpenFile.InitialDir := ExtractFilePath(Application.Exename);
  UpdateButtons();
  InitStrGr();
end;

// Liest Liste in Listbox ein
procedure TfrmMain.ListToBox;
var
  pos : cardinal;
begin
  Lb_Songs.Items.Clear;
  for pos := 1 to NumberOfElements do
  begin
    Lb_Songs.Items.Append(getInfo(pos).Title);
  end;
end;

// meine Funktion
procedure TfrmMain.TimerTimer(Sender: TObject);
begin
  if Progressbar.Max<>0 then
  begin
    Progressbar.Position := MediaPlayer.Position;
    UpdateButtons();
  end;
  if MediaPlayer.FileName = '' then
    ProgressBar.position:=0;
end;

//Initialisiere Stringried
procedure TfrmMain.InitStrGr();
begin

//Inizialiesiere Die die ObersteSpalte
  with StrGrPlaylists do
  begin
    Cells[0,0]:= 'ID';
    Cells[1,0]:= 'Playlist';
  end;
end;

end.
