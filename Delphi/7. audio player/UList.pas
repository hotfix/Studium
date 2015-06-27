unit UList;
{
  Autor: Tim Handschack, mi2165

  Enthält alle Listenoperationen zu Übung 8

  fehlt: Prozedur um auf 1. element zu springen, aber so is schneller und
  ansonsten hätte man auch first in form des Playlistenzeigers aufn 1.
  Song nutzen können
}

interface

  uses UTypes,Math;
  // gibt Speicher der gesamten Liste wieder frei
  procedure DeInitList;

  // hängt ein neues Item an Liste an
  procedure AddElement(song : TOneSong);

  // sucht einen Song in der Liste
  function IsIn(title : TTitle) : boolean;

  // gibt Infokomponente des x-ten Listenelementes zurück
  function GetInfo(index: cardinal): TOneSong;

  // erstellt InfoKomponente
  function makeElement(song: TTitle) : TOneSong;

  //Anzahl der Elemente in der Liste
  function NumberOfElements: integer;

  procedure DeleteElement();

  procedure VerschiebeElement(index : cardinal;MoveUp : boolean);

  procedure IncCurrent();

  procedure DecCurrent();

  procedure SetCurrent();

  function getCurrent(): string;

  // Erstellt Infokomponente
  // ID entspricht Anzahl der in der Liste vorhandenen Titel + 1
  function makePlaylist(song: TTitle) : TOnePlaylist;

   // Hängt einen neuen Song an's Ende der Liste
  // IN user (TOneSong) : Song, der an Songliste angehängt wird
  {-----------------------CURRENT: + 1 bei vorriger leerer Liste---------------}
  procedure AddPlaylist(song: TOnePlaylist);


implementation


  uses Dialogs, SysUtils;

  type
  // Titelliste
  PSongs      = ^TSongs;
  PPlaylists  = ^TPlaylists;
  TSongs      = record
                  prev : PSongs;         // nächster
                  info : TOneSong;       // Benutzerinfos
                  next : PSongs;         // nächster
                end;
  TPlaylists = record
                 prev : PPlaylists;
                 info : TOneSong;         //TOnePlaylist
                 Songs : PSongs;
                 next : PPlaylists;
               end;

  var
      Current: PSongs;        // Liste
      FirstPL : PPlaylists;
     // First : PSongs;
      pointers : integer;   // zählt die aktuell in Verwendung stehenden Pointer




  // Liefert das letztes Element aus der Liste
  // OUT (PSongs)      : letztes Element der Liste
  function LastElement: PSongs;
  var
    Marker : PSongs;
  begin
    Marker := Current;
    if Marker <> nil then
    begin
      while Marker^.next <> nil do
        Marker := Marker^.next;
    end;
    LastElement := Marker;
  end;

  // Dispose eines Zeigers
  // IN pointer (PSongs) : zu disposender Zeiger
  // globaler Zugriff : pointers
  procedure DisposePointer(var pointer: PSongs);
  begin
    Dispose(pointer);
    pointer := nil;
    dec(pointers);   //globale Variable -1
  end;


  // Freigabe der kompletten Liste
 procedure DeInitList;
  var
    Marker : PSongs;
  begin
    Marker :=  LastElement;
    Current := LastElement;
    
    while Marker <> nil do
    begin
      Current := Marker^.prev;
      DisposePointer(Marker);
      Marker := Current;
    end;
  end;
 
    // erstellt ein neues Listenelement und zählt dabei den unitglobalen Zeigerzähler hoch
  // IN  song (TOneSong) : ein Song, der Info Komponente des Listenelementes füllt
  // OUT (PSongs)        : gefülltes Listenelement mit next auf nil
  function NewElement(song: TOneSong): PSongs;
  var
    NeuesElement : PSongs;
  begin
    //Für Zeiger nutzbar machen
    new(NeuesElement);
    //Zeiger auf den übergebenen Song setzen (ID und Title)
    NeuesElement^.info.ID := song.ID;
    NeuesElement^.info.Title := Song.Title;
    //Next wird erstmal auf nil gesetzt
    NeuesElement^.next := nil;
    NeuesElement^.prev := nil;
   // inc(pointers);  //globale Variable +1
    NewElement := NeuesElement;
  end;





  // Prüft, ob ein bestimmter Song in der Liste vorhanden ist
  // IN song (TTitle) : zu suchender Song
  // OUT (boolean)    : true, wenn Song in Liste vorhanden, sonst false
  function IsIn(title : TTitle) : boolean;
  var
    Marker : PSongs;
  begin
    Marker := Current;
    if Marker <> nil then
    begin
      //Zurückzählen und gucken ob das Element gefunden wurde
      while (Marker^.prev <> nil) AND (title <> Marker^.info.Title) do
        Marker := Marker^.prev;
      //Wenn das Element noch nicht gefunden wurde, dann vorwärts
      if (Marker^.info.Title <> title) then
      begin
        Marker := Current;
        while (Marker <> nil) AND (title <> Marker^.info.Title) do
          Marker := Marker^.next;
        //Beim next zählen gefunden/nicht gefunden
        IsIn := (title = Marker^.info.Title);
      end
      else
      begin
        //Beim prev zählen gefunden!
        IsIn := (title = Marker^.info.Title);
      end;
    end; //Ende: Marker <> nil
  end;



  // Liefert ein bestimmtes Element aus der Liste anhand des Index'
  // IN index (cardinal) : Index, an dem sich gesuchtes Element verbirgt
  // OUt (PSongs)        : gesuchtes Element
  function GetElement(index: cardinal): PSongs;
  var
    Marker : PSongs;
  begin
    Marker := Current;
    //Springt zum 1. Element
    if Marker <> nil then
      while Marker^.prev <> nil do
        Marker := Marker^.prev;
    //DONE: Fehlerprüfung bei zu großem Index
    while     (Marker <> nil)
          and (Marker^.next <> nil)
          and (Index > 1) do
    begin
      dec(Index);
      marker := marker^.next;
    end;
    GetElement := Marker;
  end;


  // Liefert die Anzahl der Elemente der Liste
  // OUT (integer) : Anzahl der Songs dieser Liste
  function NumberOfElements: integer;
  var
    Marker : PSongs;
    Counter : integer;
  begin
    Counter := 0;
    Marker := Current;
    if Marker <> nil then
    begin
      while Marker^.prev <> nil do
      begin
        Marker := Marker^.prev;
        inc(Counter);
      end;
      Marker := Current;
      while Marker <> nil do
      begin
        Marker := Marker^.next;
        inc(Counter);
      end;
    end;
    NumberOfElements := Counter;
  end;


  // Liefert einen bestimmten Song anhand des Index'
  // IN index (cardinal) : Index, an dem sich betreffendes Element verbirgt
  // OUT (TOneSong)       : gesuchter Song als kompletter Datensatz
  function GetInfo(index: cardinal): TOneSong;
  begin
    GetInfo := GetElement(index).info;
  end;


  // Hängt einen neuen Song an's Ende der Liste
  // IN user (TOneSong) : Song, der an Songliste angehängt wird
  {-----------------------CURRENT: + 1 bei vorriger leerer Liste---------------}
  procedure AddElement(song: TOneSong);
  var
    LetztesElement : PSongs;
    Marker : PSongs;
  begin
    Marker := Current;
    if  Marker <> nil then //Wenn in der Liste schon was steht
    //DONE: LastElement benutzen
    begin
      LetztesElement := LastElement();
      LetztesElement^.next := newElement(song);
      LetztesElement^.next^.prev := LetztesElement; //lastelement
    end
    else //Bei bestehender leerer Liste
    begin
      Current :=  newElement(song);
    end;
  end;

  function GetFreeSongID(): integer;
  //schonmal gelöschte ids werden noch nicht verteilt
  var
    MaxID : cardinal;
    Marker : PSongs;
  begin
    MaxID := 0;
    Marker := Current;

    if Marker <> nil then
    begin
      while Marker^.prev <> nil do
      begin
        Marker := Marker^.prev;
        if Marker.info.ID > MaxID then
          MaxID := Marker.info.ID;
      end;

      While Marker <> nil do
      begin
        if Marker.info.ID > MaxID then
          MaxID := Marker.info.ID;
      Marker := Marker^.next;
      end;
    end;
    GetFreeSongID := MaxID+1;
  end;

  // Erstellt Infokomponente
  // ID entspricht Anzahl der in der Liste vorhandenen Titel + 1
  function makeElement(song: TTitle) : TOneSong;
  var
    NeuesElement : TOneSong;
  begin
    //WARNUNG: Geht nur wenn nie gelöscht wird (wie hier)
    //ID des neuen Elements wird gesetzt (+1 weil NEUES Element)
    NeuesElement.ID := GetFreeSongID;
    NeuesElement.Title := song;
    makeElement := NeuesElement;
  end;

  procedure DeleteElement();  //eigentlich ohne index, aber egal!
  //Marker und Current anpassen ich volltrottel
  var
    Deleter : PSongs;
   // Marker  : PSongs;
   // i : cardinal;
  begin
    Deleter := Current;

    if Current <> nil then
    begin
      //o1-> c2 -> o3 | o1-> c3                             //Normalfall 2-2
      if (Current^.next <> nil) AND (Current^.prev <> nil) then
      begin
        Current^.prev^.next := Current^.next;
        Current^.next^.prev := Current^.prev;
        Current := Current^.prev;   //höhöhö
        disposepointer(Deleter);         //hmpf
      end
      else
        begin
        //c1 -> o2  | c2                                    //1. Sonderfall 1 1
        if (Current^.prev = nil) AND (Current^.next <> nil) then
        begin
          // Playlist zeiger
          Current^.next^.prev := nil; //guckn
          Current := Current^.next; //höhöhö
          disposepointer(Deleter);       //hmpf
        end
        else
        begin
        //o1 -> c2 | c1                                      //2. SOnderfall 1 1
          if (Current^.next = nil) AND (Current^.prev <> nil) then
          begin
            Current^.prev^.next := nil;
            Current := Current^.prev;
            Deleter^.prev := nil;    //müsste eigentlich, aber najo
            disposepointer(Deleter);
          end
          else
            //c1 | leer                                          //3. Sonderfall
            if (Current <> nil) AND (Current^.next = nil) AND(Current^.prev = nil) then
            begin
              //Playlist zeiger?
              Current := nil;
              disposepointer(Deleter);
            end;
        end;
      end;
    end;
  end;
  {---------------------------Current im Normalfall +1/ aber gleiches element-}
  {---------------------------Current am Anfang +1/ aber gleiches Element-}
  function InsertElementAtPosition(Position : PSongs; song: TOneSong): boolean;
  var
 //   i : cardinal;
    Marker : PSongs;
    NeuesElement : PSongs;
  begin
    Current := Position;

    NeuesElement := NewElement(song);
    //Jetzt befindet sich der Marker an dem Element vor das eins rein soll
    //Also insert vor - dem marker element
    if (Current^.prev <> nil) then
    begin
      //Normalfall o -> c -> o | o -> n -> c -> o //Current bleibt
      Current^.prev^.next := NeuesElement; //k
      NeuesElement^.prev := Current^.prev; //k
      NeuesElement^.next := Current;       //k
      Current^.prev := NeuesElement;       //k
    end
    else
    begin
      if (Current^.prev = nil) AND (Current^.next <> nil) then    //Sonderfall 1
      //Am Anfang einfügen bei mind 1 Element dahinter vorhanden
      // c -> o | n -> c -> o   //Current bleibt
      begin
        //Playlistzeiger setzen !!!
        Current^.prev := NeuesElement;
        NeuesElement^.next := Current;
      end
      else
        if (Current^.next = nil) AND (Current^.prev <> nil) then  //(Sonderfall 2)1
        //o -> c | o -> n -> c   //Current bleibt
        begin
          Current^.prev^.next := NeuesElement;
          Current^.prev := NeuesElement;
          NeuesElement^.next := Current;
          NeuesElement^.prev := Current^.prev;
        end
        else
          // c  | n -> c  //Current bleibt
          if (Current^.prev = nil) AND (Current^.next = nil) AND (Current <> nil) then
          begin
            NeuesElement^.next := Current;
            Current^.prev := NeuesElement;
          end
          else
            // leer | n    //Current auf 1. || besser ma als else, so könnte es probs geben
            if (Current = nil) then
            begin
              Current := NeuesElement;
            end;
     InsertElementAtPosition := TRUE;
    end;
  end;

 //ID wird wohl momentan noch  neu geschrieben, des is doof
 //vielleicht insertelemnt um id erweitern :)
 //Prob bei > 2 MoveDown
 procedure VerschiebeElement(index : cardinal;MoveUp : boolean);
 var
  Dummy : boolean;
 begin
   case MoveUp of
   TRUE : begin
            //normalfall und o1 -> c2 | o2 -> c1 (??)
            if (Current^.prev <> nil) then
            begin
              Current := Current^.prev;
              Dummy := InsertElementAtPosition(Current,getInfo(index));
              Current := Current^.next;
              DeleteElement();
            end;
          end;
   FALSE :begin
            //Normalfall und c1 -> o2 | o2-> c1 (??)
            if (Current^.next <> nil) then
            begin
              Dummy := InsertElementAtPosition(Current,getInfo(index+1));
              Current := Current^.next;
              DeleteElement();
              Current := Current^.prev;
            end;
          end;
   end;
 end;

 // Setze Current auf naechsten Element
 procedure IncCurrent();
 begin
   Current := Current^.next;
 end;

 // Setze Current auf vorherigen Element
 procedure DecCurrent();
 begin
   Current := Current^.prev;
 end;

 //Getcurrent
function getCurrent(): string;
begin
  getCurrent := Current.info.title;
end;

//setCurrent
procedure SetCurrent();
begin
  if Current <> nil then
    while Current^.prev <> nil do
      Current := Current^.prev;
end;




     // erstellt ein neues Listenelement und zählt dabei den unitglobalen Zeigerzähler hoch
  // IN  song (TOneSong) : ein Song, der Info Komponente des Listenelementes füllt
  // OUT (PSongs)        : gefülltes Listenelement mit next auf nil
  function NewPlaylist(song: TOnePlaylist): PPlaylists;
  var
    NeuesElement : PPlaylists;
  begin
    //Für Zeiger nutzbar machen
    new(NeuesElement);
    //Zeiger auf den übergebenen Song setzen (ID und Title)
    NeuesElement^.info.ID := song.ID;
    NeuesElement^.info.Title := Song.Title;
    NeuesElement^.Songs := Current;
    //Next wird erstmal auf nil gesetzt
    NeuesElement^.next := nil;
    NeuesElement^.prev := nil;
    inc(pointers);  //globale Variable +1
    NewPlaylist := NeuesElement;
  end;

  // Erstellt Infokomponente
  // ID entspricht Anzahl der in der Liste vorhandenen Titel + 1
  function makePlaylist(song: TTitle) : TOnePlaylist;
  var
    NeuesElement : TOnePlaylist;
  begin
    //WARNUNG: Geht nur wenn nie gelöscht wird (wie hier)
    //ID des neuen Elements wird gesetzt (+1 weil NEUES Element)
    NeuesElement.ID := pointers + 1;
    NeuesElement.Title := song;
    makePlaylist := NeuesElement;
  end;

   // Hängt einen neuen Song an's Ende der Liste
  // IN user (TOneSong) : Song, der an Songliste angehängt wird
  {-----------------------CURRENT: + 1 bei vorriger leerer Liste---------------}
  procedure AddPlaylist(song: TOnePlaylist);
  var
    LetztesElement : PPlaylists;
    Marker : PPlaylists;
  begin
    Marker := FirstPL;
    if  Marker <> nil then //Wenn in der Liste schon was steht
    //DONE: LastElement benutzen
    begin
      while Marker^.next <> nil do
          Marker := Marker^.next;
      LetztesElement := Marker;
      LetztesElement^.next := NewPlaylist(song);
      LetztesElement^.next^.prev := LetztesElement; //lastelement
    end
    else //Bei bestehender leerer Liste
    begin
      FirstPL :=  NewPlaylist(song);
    end;
  end;

initialization

  // setzt Zähler der aktuell verwendeten Zeiger auf 0 (zum Programmstart)
  pointers := 0;
  Current := nil;
  FirstPL := nil;

finalization

  //Assert(PointerCount=0, IntToStr(PointerCount)+ 'Elemente wurden nicht freigegeben!');
  DeInitList();
  Assert(Pointers=0, IntToStr(Pointers)+ ' Elemente wurden nicht freigegeben!');
  
end.
