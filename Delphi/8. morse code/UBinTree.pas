/////////////////////////////////////////////////////////////////////
///  Unit UBinTree.pas
///
/// Beinhaltet Funktionen und Prozeduren die für die Erstellung,
/// Bearbeitung usw. eines Binärbaumes notwenig sind.
///
/// Erstellt von: Bastian T. und Alexander A. am 01.07.07
/// Letztes Update: 01.07.07 Vers. 1.01
/////////////////////////////////////////////////////////////////////
unit UBinTree;

interface
uses UTypes, UConst, Dialogs, SysUtils;

  function DecodeWort(MorseWort : TBuchstabeM): char;
  function IsInMorseWort(MorseWort : string): boolean;


implementation

type
  InfoType = char;
  TNodePointer = ^TNode;
  TNode = record
            BuchstabeK : InfoType;  //char 'A'..'Z'
            Left : TNodePointer;    // .
            Right : TNodePointer;   // -
          end;

var
  Root : TNodePointer;  //Globale Variable die auf die Wurzel zeigt
  pointers : integer;   //Globale Variable für die Speicherfreigabe

/////////////////////////////////////////////////////////////////////
// DeInitList:
// Prozedur durchläuft den Baum rekursiv und deinit. die entsprechenden
// Nodes
/////////////////////////////////////////////////////////////////////
procedure DeInitList(var root : TNodePointer);
begin
  if Root <> nil then
  begin
  dec(pointers);
    DeInitList(root^.Left);
    DeInitList(root^.Right);
    Dispose(root);
    root:= nil;
  end;
end;

//------------------------------Baum erzeugen------------------------------

/////////////////////////////////////////////////////////////////////
// NewNode:
// Erstellt einen neuen Knoten ohne Inhalt
/////////////////////////////////////////////////////////////////////
// Out: Zeiger auf den neuen Knoten
/////////////////////////////////////////////////////////////////////
function NewNode() : TNodePointer;
var
  TempNode : TNodePointer;
begin
  new(TempNode);
  TempNode^.BuchstabeK := ' ';
  TempNode^.Left := nil;
  TempNode^.Right := nil;
  inc(pointers);
  NewNode := TempNode;
end;

/////////////////////////////////////////////////////////////////////
// FillOneNode:
// Legt ein Node im Baum an und erstellt zusätzlich die übergeortneten Nodes.
/////////////////////////////////////////////////////////////////////
// In: Infokomponente des gerade anzulegenden Nodes (Klartextbuchstabe)
/////////////////////////////////////////////////////////////////////
procedure FillOneNode(Buchstabe : TBuchstabeK);
var
  i : byte;
  Position : TNodePointer;
begin
  Position := Root;
  i := 1;
  while i < length(CCodeWord[Buchstabe])+1 do
  begin
    if CCodeWord[Buchstabe][i] = '.' then
    begin
      if Position^.Left = nil then    //Wenn am Ende angekommen, dann wird
      begin                           //ein neuer Knoten angelegt ...
        Position^.Left := NewNode;
        Position := Position^.Left;
      end
      else
      begin
        Position := Position^.Left;   //Wenn nicht am Ende angekommen, dann
      end;                            //entsprechend der Anweisung Position änd.
    end
    else //if Buchstabe[i] = '-'
    begin
      if Position^.Right = nil then
      begin
        Position^.Right := NewNode;
        Position := Position^.Right;
      end
      else
      begin
        Position := Position^.Right;
      end;
    end; //ende von Right
  inc(i);
  end; //end while
  Position^.BuchstabeK := Buchstabe;
end;

/////////////////////////////////////////////////////////////////////
// Create Tree:
// Legt einen Baum mit entsprechendem Inhalt an
/////////////////////////////////////////////////////////////////////
procedure CreateTree();
var
  Buchstabe : TBuchstabeK;
begin
  //Deklaration von Root;
  new(Root);
  Root^.BuchstabeK := ' ';
  Root^.Left := nil;
  Root^.Right := nil;
   // Für alle Buchstaben ein Node
  for Buchstabe := 'A' to 'Z' do
  begin
    FillOneNode(Buchstabe);
  end;
end;

//------------------------------Mit Baum arbeiten------------------------------
function IsInMorseWort(MorseWort : string): boolean;
var
  Position : TNodePointer;
  i: Integer;
  IsIn : boolean;
begin
  IsIn := TRUE;
  Position := Root;
  if length(MorseWort) > 4 then
    IsIn := FALSE
  else
  begin
    i := 1;
    while (i <= length(MorseWort)) AND (IsIn = TRUE) do
    begin
      if MorseWort[i] = '.' then
      begin
        if Position^.Left <> nil then
          Position := Position^.Left
        else
          IsIn := FALSE;
      end
      else  //if MorseWort[i] = '-'
      begin
        if Position^.Right <> nil then
          Position := Position^.Right
        else
          IsIn := FALSE;
      end;
    inc(i);
    end; //ende While
  end;
  IsInMorseWort := IsIn;
end;

function DecodeWort(MorseWort : TBuchstabeM): char;
var
  i : byte;
  Position : TNodePointer;
  IsIn : boolean;
begin
  Position := Root;
  //DOOF
  if IsInMorseWort(MorseWort) then
  begin
    for i := 1 to length(MorseWort) do
    begin
      if ((MorseWort[i] = '.')and (Position^.Left <> nil))
        or ((MorseWort[i] = '-') and (Position^.Right <> nil)) then
      begin
      //'-' noch als konst definieren
        if (MorseWort[i] = '.') then
          Position := Position^.Left ;

        if (MorseWort[i] = '-') then
          Position := Position^.Right;
      end
      else
      begin
       if (Position^.Left = nil) OR (Position^.Right = nil) then
       begin
         //Position^.BuchstabeK := ' ';
         showmessage('Mind. ein Buchstabe konnte nicht im Suchbaum gefunden werden');
       end
       else
       begin
         //Position^.BuchstabeK := ' '; //Bei einem leerzeichen
         Position := root;
       end;
      end;
    IsIn := TRUE;
    end;
    end
  else
  begin
    IsIn := FALSE;
    Assert(NOT(IsIn),'Ein Morsewort wurde nicht gefiltert');
  end;
  DecodeWort := Position^.BuchstabeK;

end;


initialization
  pointers := 1;
  root := nil;
  CreateTree();
finalization
  DeInitList(root);
  Assert(Pointers=0, IntToStr(Pointers)+ ' Elemente wurden nicht freigegeben!');
end.
