{------------------------------------------------------------------------------
 Typenunit.

 Autor: Bastian Terfloth und Alexander Albrant - 16.05.07
 ------------------------------------------------------------------------------}
unit UTypen;

interface
const
 cArraySize = 10;

type
 TArraySize = 0..cArraySize;
 TSortType = (IDS,SName);
 TTypes = (CD,DVD);
 TKategorien = (Film, Musik, Software, Rest);
 TSingleMedium = packed record
                   ID : TArraySize;
                   Name : string[50];
                   Typ : TTypes;
                   case Kategorien : TKategorien of
                     Film : (FilmFormat : string[50];
                             Laenge : byte;
                             FilmKategorie : string[50]);
                     Musik : (MusikFormat : string[50];
                              MusikKategorie  : string[50]);
                     Software : (Hersteller : string[50];
                                 Schluessel : string[50]);
                     Rest : (Zusatz : string[70]);
                   end;
 TMedium = array[TArraySize] of TSingleMedium;
  
implementation



end.
