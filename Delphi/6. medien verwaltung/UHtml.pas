//-----------------------------------------------------------------
//UHTML ist eine Unit die es ermöglicht die Medienliste in eine
//HTML-Liste umzuwandeln
//-----------------------------------------------------------------
// Erstellt von: Bastian Terfloth und Alexander Albrant
//           am: 12.06.07
//      Version: 1.01
//-----------------------------------------------------------------

unit UHTML;

interface
  function OpenTempFile(DateiName : string):boolean;

implementation

uses UDaten, UTypen, SysUtils;
const
   //HTML Konstanten
   CHeader = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">'+#10#13+
             '<html>'+#10#13+
             ' <head>'+#10#13+
             '  <title>Medienverwaltung</title>'+#10#13+
             ' </head>'+#10#13+
             '   <body>'+#10#13+
             '    <center>'+#10#13;
   CBottom = '    </center>'+#10#13+
             '   </body>'+#10#13+
             '</html>'+#10#13;
  CTableStart = '<table width="700" cellpadding="0" cellspacing="0" border="1">'+#10#13;
  CTableEnd   = '</table>'+#10#13;
  CZeile0 = '<TR>  <TD>ID</TD> <TD>Name</TD> <TD>Typ</TD> <TD>Kategorie</TD> </TR>';


const
  TypStrings:TMapTyp = ('CD','DVD');
  KatStrings:TMapKat = ('Film','Musik','Software','Sonstige');


{-----------------------------------------------------------------
Table: Eine Zeile der Tabelle wird ermittelt und als String zurückgegeben
-----------------------------------------------------------------}
function Table(Kategorie : TSpalten; Zeile :TNummer) : string;
var
 TempString : string;
begin
    case Kategorie of
      HID  : TempString := TempString+'<TD>'+IntToStr(getMedium(Zeile).ID)+'</TD>'+#10#13;
      Name : TempString := TempString+'<TD>'+getMedium(Zeile).Name+'</TD>'+#10#13;
      Typ :  TempString := TempString+'<TD>'+TypStrings[getMedium(Zeile).Typ]+'</TD>'+#10#13;
      HKategorie : TempString := TempString+
                  '<TD>'+KatStrings[getMedium(Zeile).Kategorie]+'</TD>'+#10#13;
    end;
    Table := TempString;
end;

{-----------------------------------------------------------------
WriteHTML: folgende Daten werden nacheinander in die HTML-Datei geschrieben:
- CHeader = Header
- CTableStart = Tabellenanfang (<Table ......)
- CZeile0 = Die erste Zeile der Tabelle (ID|Name|Typ|Kategorie)
- (function table)
- CTableEnd = Tabellenende (</Table>)
- CBottom = Ende der HTML-Datei
-----------------------------------------------------------------}
procedure WriteHTML(var  HTMLDatei : TextFile);
var
 Zeile : TNummer;
 Spalte : TSpalten;
begin
  writeln(HTMLDatei,CHeader);
  writeln(HTMLDatei,CTableStart);
  writeln(HTMLDatei,CZeile0);
  for Zeile := 0 to getMaxID()-1 do
  begin
    writeln(HTMLDatei,'<TR>');
    for Spalte := HID to HKategorie do
    begin
      writeln(HTMLDatei,Table(Spalte,Zeile));
    end;
 writeln(HTMLDatei,'</TR>');
 end;
 writeln(HTMLDatei,CTableEnd);
 writeln(HTMLDatei,CBottom);
end;

{-----------------------------------------------------------------
HTML Datei wird geöffnet von den anderen Prozeduren gefüllt
gespeichert und wieder geschlossen
-----------------------------------------------------------------}
function OpenTempFile(DateiName : string):boolean;
var  HTMLDatei : TextFile;
begin
  OpenTempFile := TRUE;
  try
    AssignFile(HTMLDatei,DateiName);
    Rewrite(HTMLDatei);
    WriteHTML(HTMLDatei);
    close(HTMLDatei);
  except
    OpenTempFile := FALSE;
  end;
end;
end.
