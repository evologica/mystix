{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynUniHighlighter.pas, released 2003-01
All Rights Reserved.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

{
@abstract(Provides EditPlus highlighting schemes import)
@authors(Fantasist [walking_in_the_sky@yahoo.com], Vit [nevzorov@yahoo.com],
         Vitalik [vetal-x@mail.ru], Quadr0 [quadr02005@yahoo.com])
@created(2003)
@lastmod(2004-05-12)
}

unit SynUniImportEditPlus;

interface

uses
  Classes,
  Graphics,
  SysUtils,
  SynUniImport,
  SynUniClasses,
  SynUniRules;

type
  { Base class of EditPlus highlighting schemes importer }
  TSynUniImportEditPlus = class(TSynUniImport)
    { List of files }
    FileList: TStringList;
    { Constructor of TSynUniImportEditPlus }
    constructor Create();
    { Destructor of TSynUniImportEditPlus }
    destructor Destroy();
    procedure Import(Rules: TSynRange; Info: TSynInfo);
    { Imports from stream }
    function LoadFromStream(Stream: TStream): boolean;
    { Imports from file }
    function LoadFromFile(FileName: string): boolean;
  end;

implementation

constructor TSynUniImportEditPlus.Create();
begin
  FileList := TStringList.Create;
end;

destructor TSynUniImportEditPlus.Destroy();
begin
  FileList.Free;
end;

procedure TSynUniImportEditPlus.Import(Rules: TSynRange; Info: TSynInfo);
var
  qn1, qn2, bn1, bn2, curKwd, i: integer;
  key, value, buf: string;
const
  kwcolors: array [0..4] of TColor = (clBlue, clRed, clTeal, clOlive, clMaroon);
begin
  Rules.Clear;
  qn1 := -1;   qn2 := -1;   bn1 := -1;   bn2 := -1;
  curKwd := -1;
  for i := 0 to FileList.Count-1 do begin
    buf := FileList.Strings[i];
    if buf = '' then
      continue;
    if buf[1] = '#' then begin
      key := copy(buf, 1, pos('=', buf)-1);
      value := copy(buf, pos('=', buf)+1, length(buf)-pos('=', buf));
      if key = '#TITLE' then begin
        Info.General.Name := value
      end
      else if key = '#DELIMITER' then
        Rules.TermSymbols := StrToSet(value)
      else if key = '#CONTINUE_QUOTE' then begin
        if value = 'y' then begin
          if qn1 > -1 then Rules.Ranges[qn1].fRule.fCloseOnEol := False;
          if qn2 > -1 then Rules.Ranges[qn2].fRule.fCloseOnEol := False;
        end
        else begin
          if qn1 > -1 then Rules.Ranges[qn1].fRule.fCloseOnEol := True;
          if qn2 > -1 then Rules.Ranges[qn2].fRule.fCloseOnEol := True;
        end
      end
      else if key = '#CASE' then begin
        if value = 'y' then
          Rules.CaseSensitive := True
        else
          Rules.CaseSensitive := False;
      end
      else if (key = '#KEYWORD') or (buf = '#KEYWORD') then begin
        inc(curKwd);
        if key = '' then
          Rules.AddKeyList('Keyword '+IntToStr(curKwd+1), kwcolors[curKwd])
        else
          Rules.AddKeyList(value, kwcolors[curKwd]);
      end
      else if value <> '' then
        if key = '#QUOTATION1' then begin
          qn1 := Rules.RangeCount;
          Rules.AddRange(value[1], value[1], 'Quotaion', clFuchsia);
        end else
        if key = '#QUOTATION2' then begin
          qn2 := Rules.RangeCount;
          Rules.AddRange(value[1], value[1], 'Quotaion2', clFuchsia);
        end else
        if key = '#LINECOMMENT' then begin
          //ln1 := Rules.RangeCount;
          with Rules.AddRange(value, '', 'Line comment', clGreen) do
            fRule.fCloseOnEol := True;
        end else
        if key = '#LINECOMMENT2' then begin
          //ln2 := Rules.RangeCount;
          with Rules.AddRange(value, '', 'Line comment 2', clGreen) do
            fRule.fCloseOnEol := True;
        end else
        if key = '#COMMENTON' then begin
          if bn1 = -1 then begin
            bn1 := Rules.RangeCount;
            Rules.AddRange(value, '', 'Block comment', clGreen);
          end else
            Rules.Ranges[bn1].fRule.fOpenSymbol.Symbol := value
        end else
        if key = '#COMMENTOFF' then begin
          if bn1 = -1 then begin
            bn1 := Rules.RangeCount;
            Rules.AddRange('', value, 'Block comment', clGreen);
          end else
            Rules.Ranges[bn1].fRule.fCloseSymbol.Symbol := value
        end else
        if key = '#COMMENTON2' then begin
          if bn2 = -1 then begin
            bn2 := Rules.RangeCount;
            Rules.AddRange(value, '', 'Block comment 2', clGreen);
          end else
            Rules.Ranges[bn2].fRule.fOpenSymbol.Symbol := value
        end else
        if key = '#COMMENTOFF2' then begin
          if bn2 = -1 then begin
            bn2 := Rules.RangeCount;
            Rules.AddRange('', value, 'Block comment 2', clGreen);
          end else
            Rules.Ranges[bn2].fRule.fCloseSymbol.Symbol := value
        end else
        if copy(key, 1, 7) = '#PREFIX' then begin
          with Rules.AddRange(value, '', 'Prefix '+key[8],
            kwColors[StrToInt(key[8])]) do
            fRule.fCloseOnTerm := True;
        end
    end
    else if buf[1] = ';' then
    else begin
      Rules.KeyLists[curKwd].KeyList.Add(buf);
    end
  end;
  Rules.SetDelimiters(Rules.TermSymbols);
  Info.Author.Remark := 'Created with EditPlus Converter (c) Vitalik';
end;

function TSynUniImportEditPlus.LoadFromStream(Stream: TStream): boolean;
begin
  FileList.LoadFromStream(Stream);
end;

function TSynUniImportEditPlus.LoadFromFile(FileName: string): boolean;
begin
  FileList.LoadFromFile(FileName);
end;

end.
