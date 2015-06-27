{Enthält die Typen für die Medienverwaltung
Autor: Gerrit Remané (winf8003) }

unit UTypen;

interface

type
  // Typ für Index
  TNummer = cardinal;

  // Typen für die Komponenten des Records
  TID = cardinal;
  TName = string[50];
  TTyp = (CD, DVD);
  TKategorie = (Film, Musik, Software, Sonst_Daten);
  TLaenge = cardinal;
  //Typ für HTML
  TSpalten = (HID,Name,Typ,HKategorie);
  TMapKat = array[TKategorie] of String[20];
  TMapTyp = array[TTyp] of string[3];

  // Record mit variantem Teil, in dem je ein Medium gespeichert werden kann
  TMedium = record
    ID : TID;
    Name : TName;
    Typ : TTyp;
    case Kategorie : TKategorie of
      Film : (FFormat : TName;
              Laenge : TLaenge;
              FilmKategorie : TName);
      Musik : (MFormat : TName;
               MusikKategorie : TName);
      Software : (Hersteller : TName;
                  Schluessel : TName);
      Sonst_Daten : (Zusatz : string[70]);
    end;

  //Merkmal anhand dem sortiert werden soll
  TMerkmal = (ID, N, T, K);

const
  //DefaultMedium, das geladen wird, wenn das Einlesen nicht funktioniert
  CDefaultMedium: TMedium = (ID: 0; Name: '';  Typ: CD; Kategorie: Film;
        FFormat: ''; Laenge: 0; FilmKategorie: '');


implementation

end.
