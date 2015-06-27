{------------------------------------------------------------------------------
 Beinhaltet die Startspielfelder.

 Autor: Philip Lehmann-Böhm, 05.03.2007
 ------------------------------------------------------------------------------}
unit uGames;

interface

uses
  uTypes;

const
  // Anzahl der Ausgangssituationen
  gameCount = 1;

function getGame(index: integer): TGameField;

implementation

  const
  // Die Ausgangssituationen
  games: array [1..gameCount] of TGamefield = (
                                                  // 8x10
                                              {  ((false, false, true, false, false, true, false, false),
                                                (false, false, false, false, false, true, false, false),
                                                (true, true, false, false, false, true, false, false),
                                                (false, false, false, true, true, true, false, false),
                                                (false, false, false, true, false, true, false, false),
                                                (false, true, true, false, false, true, false, false),
                                                (false, false, false, false, false, true, false, false),
                                                (false, false, false, false, false, true, false, false),
                                                (true, true, false, false, false, true, false, false),
                                                (false, false, false, true, true, true, false, false)));
                                             }
                                                  //8 x 8
                                             ((false, false, true, false, false, true, false, false),
                                                (true, false, false, false, false, true, false, false),
                                                (false, false, false, false, false, true, false, true),
                                                (true, true, true, true, true, true, false, false),
                                                (false, false, false, true, false, true, true, false),
                                                (false, false, false, false, false, true, true, false),
                                                (true, true, false, true, false, true, false, false),
                                                (false, true, true, true, true, true, true, false)));




                                                {   (false, false, false, false, false),
                                                (false, false, false, false, false),
                                                (false, false, false, true, true),
                                                (false, false, false, true, false)),

                                               ((false, false, false, false, false),
                                                (false, false, true, false, false),
                                                (false, true, false, true, false),
                                                (false, false, true, false, false),
                                                (false, false, false, false, false)),

                                               ((false, false, false, false, false),
                                                (false, false, true, false, false),
                                                (false, false, true, false, false),
                                                (false, false, true, false, false),
                                                (false, false, false, false, false)),

                                               ((false, true, false, false, false),
                                                (false, true, true, false, false),
                                                (false, true, true, false, false),
                                                (false, false, true, false, false),
                                                (false, false, false, false, false)),

                                               ((false, false, true, false, false),
                                                (true, true, false, false, false),
                                                (false, false, true, true, false),
                                                (false, true, false, false, false),
                                                (false, false, false, false, false)),

                                               ((true, true, false, false, false),
                                                (true, true, false, false, false),
                                                (false, false, true, true, false),
                                                (false, false, true, true, false),
                                                (false, false, false, false, false)),

                                               ((true, true, true, true, true),
                                                (true, true, true, true, true),
                                                (true, true, true, true, true),
                                                (true, true, true, true, true),
                                                (true, true, true, true, true)));

                                            }


{-------------------------------------------------------------------------
 Liefert eine bestimmte Ausgangssituation.
 ----------------------------------------------------------------------
 index (in): Der Index der gewünschten Ausgangssituation.
 ----------------------------------------------------------------------
 Rückgabewert (out): Die Ausgangssituation als Spielfeld.
 ----------------------------------------------------------------------
 globale Zugriffe :
 games (lesend): Das Array mit den möglichen Ausgangssituationen.
 -------------------------------------------------------------------------}
function getGame(index: integer): TGameField;
begin
  getGame := games[index];
end;

end.