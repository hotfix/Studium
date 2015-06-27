{------------------------------------------------------------------------------
 Typdeklaration des Spielfeldes.
 Autor: Philip Lehmann-B�hm, 20.03.2007
 Erweitert um TNachbarCount von Bastian Terfloth am 09.05.07
 ------------------------------------------------------------------------------}
unit uTypes;

interface

  const
    // Spielfeldbreite
    cMaxWidth = 8;
    // Spielfeldh�he
    cMaxHeight = 8;

  type
    // Spielfelddimensionen
    TGameWidth = 1..cMaxWidth;
    TGameHeight = 1..CMaxHeight;
    // Spielfeld als zweidimensionales Boolean-Array
    TGamefield = array [TGameWidth , TGameHeight] of boolean;

implementation

end.
