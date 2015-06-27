unit UTypes;
{
  Autor: Tim Handschack, mi2165
  Enthält alle Typdeklarationen zu Übung 8.
}

interface


type
  TTitle      = String[200];
  TID         = cardinal;

  // SongDaten
  TOneSong = record
               ID      : TID;        // ID
               Title   : TTitle;     // Songtitel
             end;

  TOnePlaylist = record
                  ID : TID;
                  Title : TTitle;
                 end;


implementation

end.
