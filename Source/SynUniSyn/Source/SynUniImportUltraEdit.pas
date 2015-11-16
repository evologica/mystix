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
@abstract(Provides UltraEdit highlighting schemes import)
@authors(Fantasist [walking_in_the_sky@yahoo.com], Vit [nevzorov@yahoo.com],
         Vitalik [vetal-x@mail.ru], Quadr0 [quadr02005@yahoo.com])
@created(2003)
@lastmod(2005-05-17)
}

unit SynUniImportUltraEdit;

interface

uses
  Classes,
  Graphics,
  SysUtils,
  SynUniImport,
  SynUniClasses,
  SynUniRules;

type
  { Base class for UltraEdit highlighting schemes import }
  TSynUniImportUltraEdit = class(TSynUniImport)
    FileList: TStringList;
    FilePos: integer;
    FileName: string;
    { Constructor of TSynUniImportUltraEdit }
    constructor Create();
    { Destructor of TSynUniImportUltraEdit }
    destructor Destroy();
    function Import(Rules: TSynRange; Info: TSynInfo): boolean;
    { Import from stream }
    function LoadFromStream(Stream: TStream): boolean;
    { Import from file }
    function LoadFromFile(FileName: string): boolean;
  end;

implementation

constructor TSynUniImportUltraEdit.Create();
begin
  FileList := TStringList.Create;
end;

destructor TSynUniImportUltraEdit.Destroy();
begin
  FileList.Free;
end;

function TSynUniImportUltraEdit.Import(Rules: TSynRange; Info: TSynInfo): boolean;
var
  i, j, qn1, qn2, bn1, bn2, cur, Nc: integer;
  qc1, qc2: char;
  word, buf: string;
  Cnames: array [1..8] of string;
  Created: array [1..8] of integer;
  isLoading: boolean;
  keyword: TSynKeyList;
const
  colors: array [1..8] of TColor =
            (clBlue, clRed, $0080FF, clGreen, clMaroon, clBlue, clBlue, clBlue);
  badsymb: array [0..8] of char = ('\', '/', ':', '*', '?', '"', '<', '>', '|');
  LINE_COMMENT  = 1;
  BLOCK_COMMENT = 2;
  STRING_CHARS  = 3;
  LINE_COMM_NUM = 4;
  SINGLE_WORD   = 5;
  WHOLE_STRING  = 6;
  ESCAPE_CHAR   = 7;

  function GetAttribute(Key: string; Style: integer): boolean;
  var pos_start, space1_pos, space2_pos, len: integer;
  begin
    Result := False;
    if pos(key, buf) = 0 then Exit;
    pos_start := pos(key, buf) + length(key);
    if (Style = LINE_COMMENT) or (Style = BLOCK_COMMENT) or (Style = STRING_CHARS) then begin
      if Style =  LINE_COMMENT then len :=  5 else
      if Style = BLOCK_COMMENT then len := 19 else
      if Style =  STRING_CHARS then len := 2  else len := 5;
      word := copy(buf, pos_start, len);
      space1_pos := pos(' ', word);
      if space1_pos > 0 then
        if space1_pos = 1 then begin
          space2_pos := pos(' ', copy(word, 2, len-1));
          if space2_pos > 0 then
            word := copy(word, 1, space2_pos);
        end else
          word := copy(word, 1, space1_pos-1)
    end
    else if Style = LINE_COMM_NUM then begin
      len := StrToInt(buf[pos_start]);
      word := copy(buf, pos_start+1, len);
      space1_pos := pos(' ', word);
      if space1_pos > 0 then
    end
    else if Style = WHOLE_STRING then
      word := copy(buf, pos_start, length(buf) - pos_start + 1)
    else if Style = ESCAPE_CHAR then
      word := buf[pos_start]
    else if Style = SINGLE_WORD then ;

    if word <> '' then Result := True;
  end;

  function GetToken: string;
  begin
    cur := pos(' ', buf);
    if cur > 0 then begin
      Result := copy(buf, 1, cur-1);
      buf := copy(buf, cur+1, length(buf)-cur);
    end else begin
      Result := buf;   buf := '';
    end;
  end;

begin
  if not Assigned(FileList) then
    if FileName <> '' then begin
      //'File was loaded.'
      FileList := TStringList.Create;
      FileList.LoadFromFile(FileName);
      FileName := FileName;
      FilePos := 0;
    end
    else begin
      //'File was not assigned and not loaded. Exiting...'
      Result := False;
      Exit;
    end
  else begin
    if (FileName = FileName) and (FilePos >= FileList.Count-1) or (FileName = '') then begin
      //'Variables are deleted. Exiting...'
      if Assigned(FileList) then begin
        FileList.Free;
        FileList := nil;
      end;
      FileName := '';
      FilePos := 0;
      Result := False;
      Exit;
    end;
    if FileName <> FileName then begin
      //'New File was loaded.'
      FileList.LoadFromFile(FileName);
      FileName := FileName;
      FilePos := 0;
    end;
  end;

  Rules.Clear;
  isLoading := False;
  qc1 := #0;   qc2 := #0;   Nc := 0;   qn1 := -1;   qn2 := -1; 
  for i := FilePos to FileList.Count-1 do begin
    buf := FileList.Strings[i];
    FilePos := i;
    if buf = '' then continue;
    if copy(buf, 1, 2) = '/L' then begin
      if not isLoading then
        isLoading := True
      else begin // isLoading = True?
		Info.Author.Remark := 'Created with UltraEdit Converter. (c) Vitalik';
        Result := True;
        Exit;
      end;
      Nc := 0; bn1 := -1; bn2 := -1; qn1 := -1; qn2 := -1; qc1 := #0; qc2 := #0;
      for j := 1 to 8 do begin Cnames[j] := ''; Created[j] := -1; end;
      if (buf[4] = '"') or (buf[5] = '"') then begin
        cur := pos('"', copy(buf, pos('"',buf)+1, length(buf)-pos('"',buf))) + pos('"', buf);
        Info.General.Name := copy(buf, pos('"',buf)+1, cur-pos('"',buf)-1);
      end;
      if Info.General.Name = '' then
        Info.General.Name := ExtractFileName(FileName);
      if GetAttribute('File Extensions = ', WHOLE_STRING) then begin
        Info.General.Extensions := word;
      end;
      Rules.AddSet('Numbers', ['0','1','2','3','4','5','6','7','8','9'], clRed);
      if GetAttribute('Nocase', SINGLE_WORD) then
        Rules.CaseSensitive := False
      else
        Rules.CaseSensitive := True;
      if not GetAttribute('Noquote', SINGLE_WORD) then begin
        if not GetAttribute('String Chars = ', STRING_CHARS) then
          word := '"''';
        qn1 := Rules.RangeCount;
        qc1 := word[1];
        with Rules.AddRange(qc1, qc1, 'String', clGray) do
          fRule.fCloseOnEol := true;
        if length(word) > 1 then begin
          qn2 := Rules.RangeCount;
          qc2 := word[2];
          with Rules.AddRange(qc2, qc2, 'String', clGray) do
            fRule.fCloseOnEol := true;
        end;
        if GetAttribute('Escape Char = ', ESCAPE_CHAR) then begin
          with Rules.Ranges[qn1].AddKeyList('Escape', clGray) do
            KeyList.Text := word + word + #13#10 + word + qc1;
          if qn2 > -1 then
            with Rules.Ranges[qn2].AddKeyList('Escape', clGray) do
              KeyList.Text := word + word + #13#10 + word + qc2;
        end;
      end;
      if GetAttribute('Line Comment = ', LINE_COMMENT) then begin
        with Rules.AddRange(word, '', 'Line Comment', clTeal) do
          fRule.fCloseOnEol := true;
      end;
      if GetAttribute('Line Comment Alt = ', LINE_COMMENT) then begin
        with Rules.AddRange(word, '', 'Line Comment Alt', clTeal) do
          fRule.fCloseOnEol := true;
      end;
      if GetAttribute('Line Comment Num = ', LINE_COMM_NUM) then begin
        with Rules.AddRange(word, '', 'Line Comment Num', clTeal) do
          fRule.fCloseOnEol := true;
      end;
      if GetAttribute('Block Comment On = ', BLOCK_COMMENT) then begin
        bn1 := Rules.RangeCount;
        with Rules.AddRange(word, '', 'Block Comment', clTeal) do
          fRule.fCloseOnEol := true;
      end;
      if GetAttribute('Block Comment Off = ', BLOCK_COMMENT) then begin
        if bn1 = -1 then
          Rules.AddRange('', word, 'Block Comment', clTeal)
        else begin
          Rules.Ranges[bn1].fRule.fCloseSymbol.Symbol := word;
          Rules.Ranges[bn1].fRule.fCloseOnEol := false;
        end;
      end;
      if GetAttribute('Block Comment On Alt = ', BLOCK_COMMENT) then begin
        bn2 := Rules.RangeCount;
        with Rules.AddRange(word, '', 'Block Comment Alt', clTeal) do
          fRule.fCloseOnEol := true;
      end;
      if GetAttribute('Block Comment Off Alt = ', BLOCK_COMMENT) then begin
        if bn2 = -1 then
          Rules.AddRange('', word, 'Block Comment Alt', clTeal)
        else begin
          Rules.Ranges[bn2].fRule.fCloseSymbol.Symbol := word;
          Rules.Ranges[bn2].fRule.fCloseOnEol := false;
        end;
      end;
    end else begin
      if not isLoading then isLoading := True;
      if copy(buf, 1, 13) = '/Delimiters =' then
        Rules.SetDelimiters(StrToSet(copy(buf, pos('=',buf)+1, length(buf)-pos('=',buf)+1)))
      else
      if copy(buf, 1, 2) = '/C' then begin
        Nc := StrToInt(buf[3]);
        if buf[4] = '"' then begin
          cur := pos('"', copy(buf, 5, length(buf)-4)) + 4;
          Cnames[Nc] := copy(buf, 5, cur-5);
          if Created[Nc] > -1 then // already created
            Rules.KeyLists[Created[Nc]].Name := Cnames[Nc];
        end
        else
          if Created[Nc] = -1 then // haven't created
            Cnames[Nc] := 'Word list ' + IntToStr(Nc);
      end else
      if (buf[1] = '/') and (buf[2] <> '/') then // "/XXXXXXX = ...."
      else begin
        if (buf[1] = qc1) and (qn1 <> -1) then begin
          Rules.Ranges[qn1].Attribs.Foreground := colors[Nc];
          Rules.Ranges[qn1].Attribs.ParentForeground := False;
        end;
        if (buf[1] = qc2) and (qn2 <> -1) then begin
          Rules.Ranges[qn2].Attribs.Foreground := colors[Nc];
          Rules.Ranges[qn2].Attribs.ParentForeground := False;
        end;
        word := GetToken;
        if word = '**' then begin
          repeat
            word := GetToken;
            with Rules.AddRange(word, '', Cnames[Nc], colors[Nc]) do begin
              TermSymbols := Rules.TermSymbols;
              fRule.fCloseOnTerm := true;
            end;
          until buf = '';
        end else begin
          if Created[Nc] = -1 then begin
            Created[Nc] := Rules.KeyListCount;
            keyword := Rules.AddKeyList(Cnames[Nc], colors[Nc]);
          end else
            keyword := Rules.KeyLists[Created[Nc]];
          if word = '//' then
            word := GetToken;
          keyword.KeyList.Add(word);
          while buf <> '' do begin
            word := GetToken;
            keyword.KeyList.Add(word);
          end;
        end;
      end;
    end;
  end;
  Info.Author.Remark := 'Created with UltraEdit Converter (c) Vitalik';
  Result := True;
end;

function TSynUniImportUltraEdit.LoadFromStream(Stream: TStream): boolean;
begin
  FileList.LoadFromStream(Stream);
end;

function TSynUniImportUltraEdit.LoadFromFile(FileName: string): boolean;
begin
  FileList.LoadFromFile(FileName);
end;

end.
