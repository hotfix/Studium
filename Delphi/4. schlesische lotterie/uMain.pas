{------------------------------------------------------------------------------
Hauptunit des Spiels: Schlesische Lotterie.
Glьcksspiel mit franz. Kartenblatt
Bearbeitet von: Bastian Terfloth und Alexander Albrant am 15.5.07
 ------------------------------------------------------------------------------}
unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMain = class(TForm)
    grpbxOwnDeck: TGroupBox;
    btnBuyCard: TButton;
    lbOwnDeck: TListBox;
    btnReady: TButton;
    lblMoney: TLabel;
    procedure btnReadyClick(Sender: TObject);
    procedure btnBuyCardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure UpdateComponents;
    procedure  berechne;
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uGame, uTypes;


{-------------------------------------------------------------------------
 Fьhrt die Ziehung durch. Wenn das Spiel verloren ist, wird nachgefragt, ob
 ein neues gestartet werden soll.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnReadyClick(Sender: TObject);
begin
  berechne;
end;
//berechnung
procedure  TfrmMain.berechne;
var
   Result : TGameResult;
   RndStartMoney : integer;
   RndDifMoneyStr : string;
   gewinn : integer;
begin
  gewinn := 0;
  RndStartMoney := getMoney();
  Result := playGame(gewinn);
  //"Berechnet" das gewonnene Geld, und gibt die entsprechenden
  //Resultate (Dealer-Draw) per ShowMessage aus.
  RndDifMoneyStr := inttostr(gewinn);
  //decDeckMoney;
  //UpdateComponents;
  LblMoney.Caption := ('Vermögen: '+ IntToStr(gewinn + RndStartMoney));
  ShowMessage('Ziehungsergebniss:'+#13#10+
              'Paar1: '+Result[0]+' und '+Result[1]+#13#10+
              'Paar2: '+Result[2]+' und '+Result[3]+#13#10+
              'Paar3: '+Result[4]+' und '+Result[5]+#13#10+
              'Paar4: '+Result[6]+' und '+Result[7]+#13#10+
              'Grosses Los: '+Result[8]+#13#10+
              RndDifMoneyStr+' gewonnen');
   setMoney(gewinn+RndStartMoney);
  //Wenn keine Karte (auf der Hand) mehr bezahlt werden kann, dann wird gefragt
  //ob nochmal gespielt werden soll.
  //if NOT(CheckMoney(1)) then
   if (getMoney() > 0) then  begin
    if  (Application.MessageBox('Willst Du deine Karten behalten?',
                              'Neue Runde',MB_YESNO)=ID_YES) and (checkDeckMoney()) then
    begin
       //Geld entsprechend der Karten im Deck abziehen
      decDeckMoney();
      UpdateComponents();
    end
    else
    begin
      //Mit leerem Deck starten
      emptyDeck();
      UpdateComponents();
      LbOwnDeck.Items.Clear;
    end
  end
  //Wenn mindestens eine Karte auf der Hand noch bezahlt weren kann wird
  //ьberprьft ob das Geld fьr die aktuelle Hand noch ausreicht:
  //wenn ja: wird gefragt die Karten behalten werden sollen
  //wenn nein: dann wird die Kartenhand weggeworfen
  else
    if Application.MessageBox('Willst Du nochmal spielen?',
    'Leider Verloren',MB_YESNO)=ID_YES then
    begin
      initGame();
      LbOwnDeck.Items.Clear;
      UpdateComponents();
    end
    else
      Application.Terminate;
end;

{-------------------------------------------------------------------------
 Kauft eine Karte und fьgt sie dem eigenen Blatt hinzu.
 -------------------------------------------------------------------------}
procedure TfrmMain.btnBuyCardClick(Sender: TObject);
var I : TCards;
begin
  if addCardToOwnDeck() then
  begin
    LbOwnDeck.Items.Clear;
    for I := k7 to kra do
      if cardindeck(I) then
        //Fьgt die aktuell gezogene Karte der Box hinzu
        LbOwnDeck.Items.Append(CardToStr(I));
  end;
  UpdateComponents();
end;

{-------------------------------------------------------------------------
 Initialisiert das Spiel.
 -------------------------------------------------------------------------}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  initGame();
  UpdateComponents();
end;

{-------------------------------------------------------------------------
 Aktualisiert die Komponenten
 -------------------------------------------------------------------------}
 procedure TfrmMain.UpdateComponents;
 begin
   //Aktiviert/Deaktiviert den "Karte ziehen-Button"
   BtnBuyCard.Enabled := CheckDrawPossible();
   //Aktiviert/deaktiviert den "Ziehung Starten-Button" wenn genьgend Geld da ist
   BtnReady.Enabled := (GetCardCount > 0);
   //Aktualisiert die Anzeige des Vermцgens
   LblMoney.Caption := 'Vermögen: '+IntToStr(getMoney());
 end;

end.
