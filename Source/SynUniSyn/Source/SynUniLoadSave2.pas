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
@abstract(Provides highlighting schemes loading)
@authors(Fantasist [walking_in_the_sky@yahoo.com], Vit [nevzorov@yahoo.com],
         Vitalik [vetal-x@mail.ru], Quadr0 [quadr02005@yahoo.com])
@created(2003)                           
@lastmod(2005-05-17)
}

//=== OLD LOADING ============================================================
function GetAttrValue(Name: string; xml: TXMLParser): string;
Var
  I: integer;
begin
  Result := '';
  if xml = nil then Exit;

  for I := 0 to xml.CurAttr.Count -1 do
    if SameText(Name, xml.CurAttr.Name(I)) then begin
      Result := xml.CurAttr.Value(I);
      Exit;
    end;
end;

function Verify(tag: string; xml: TXMLParser): boolean;
begin
  Result := SameText(xml.CurName, tag);
  if Result then begin
    xml.Normalize := False;
    xml.CurContent := '';
    xml.Scan;
    xml.Normalize := True;
  end
end;

procedure LoadAttri(curRule: TSynRule; xml: TXMLParser);
begin
//  inc(CurRule.ind);
  CurRule.Attribs{ByIndex[0]}.ParentForeground := False;
  CurRule.Attribs{ByIndex[0]}.ParentBackground := False;
  while xml.Scan do begin
    if (xml.CurPartType = ptStartTag) then begin
      if Verify('Back',xml) then begin
        CurRule.Attribs.Background := StrToIntDef(xml.CurContent, $FFFFFF);
        CurRule.Attribs.OldColorBackground := CurRule.Attribs.Background;
      end else
      if Verify('Fore',xml) then begin
        CurRule.Attribs.Foreground := StrToIntDef(xml.CurContent, 0);
        CurRule.Attribs.OldColorForeground := CurRule.Attribs.Foreground;
      end else
      if Verify('Style',xml) then
        CurRule.Attribs.Style := StrToFontStyle(xml.CurContent)
      else if Verify('ParentForeground',xml) then
        CurRule.Attribs.ParentForeground := LowerCase(xml.CurContent) = 'true'
      else if Verify('ParentBackground',xml) then
        CurRule.Attribs.ParentBackground := LowerCase(xml.CurContent) = 'true';
    end
    else if xml.CurPartType = ptEndTag then
      if SameText(xml.CurName, 'Attri') or SameText(xml.CurName, 'Def') then
        Exit;
  end;
end;

procedure TSynKeyList.LoadHglFromXml(xml: TXMLParser; SchCount,SchIndex: integer);
var
  TempSchIndex: integer;
begin
//  if curKw = nil then Exit;
  if xml = nil then Exit;

  if (xml.CurPartType = ptStartTag) and ( SameText('KW'{'Keywords'}, xml.CurName) ) then
    Name := getAttrValue('name', xml)
//    Attribs := fStyles.GetStyleDef(getAttrValue('style', xml), defaultattr);
  else
    raise Exception.Create(ClassName + '.LoadFromXml - no keywords to load!');

//  ClearAttributes();
//  for i := 0 to SchCount-1 do
//    AddAttribute();
//  ind := -1;
  TempSchIndex := SchIndex;

  KeyList.BeginUpdate;
  KeyList.Clear;
  try
    while xml.Scan do begin
      if xml.CurPartType = ptStartTag then begin
        if SameText(xml.CurName, 'Attri') or SameText(xml.CurName, 'Def') then begin
          if TempSchIndex >= 0 then LoadAttri(self, xml);
          dec(TempSchIndex);
        end else
        if Verify('Enabled',xml) then
          Enabled := LowerCase(xml.CurContent) = 'true'
        else
        if Verify('W',xml) then begin
          KeyList.Add(xml.CurContent);
        end;
      end else
      if xml.CurPartType = ptEndTag then if SameText(xml.CurName, 'KW') then
        Break;
    end;
  finally
    ind := SchIndex;
    KeyList.EndUpdate;
  end;
end;

procedure TSynSet.LoadHglFromXml(xml: TXMLParser; SchCount,SchIndex: integer);
var
  TempSchIndex: integer;
begin
//  if curSet = nil then Exit;
  if xml = nil then Exit;

  if (xml.CurPartType = ptStartTag) and ( SameText('Set', xml.CurName) ) then
    Name := getAttrValue('name', xml)
//    Attribs := fStyles.GetStyleDef(getAttrValue('style', xml), defaultattr);
  else
    raise Exception.Create(ClassName + '.LoadFromXml - no set to load!');

{  ClearAttributes();
  for i := 0 to SchCount-1 do
    AddAttribute();
  ind := -1;}
  TempSchIndex := SchIndex;

  while xml.Scan do begin
    if xml.CurPartType = ptStartTag then
      if SameText(xml.CurName, 'Attri') or SameText(xml.CurName, 'Def') then begin
        if TempSchIndex >= 0 then LoadAttri(self, xml);
        dec(TempSchIndex);
      end else
      if Verify('Enabled',xml) then
        Enabled := LowerCase(xml.CurContent) = 'true'
      else
      if Verify('S',xml) then
        SymbSet := StrToSet(xml.CurContent)
      else
    else
    if xml.CurPartType = ptEndTag then if SameText(xml.CurName, 'Set') then
      Break;
  end;

  ind := SchIndex;
end;

procedure TSynRange.LoadHglFromXml(xml: TXMLParser; SchCount, SchIndex: integer);
var
  NewSynRange: TSynRange;
  NewSynKeyList: TSynKeyList;
  NewSynSet: TSynSet;
  S: string;
  TempSchIndex: integer;
begin
  fRule.fOpenSymbol.BrakeType := btAny;
  if (xml.CurPartType = ptStartTag) and (SameText(xml.CurName, 'Range')) then begin
    S := GetAttrValue('name', xml);
    if S <> '' then
      Name := S;
  end else
    raise Exception.Create(ClassName + '.LoadFromXml - no range to load!');

{  ClearAttributes();
  for i := 0 to SchCount-1 do
    AddAttribute();
  ind := -1;}
  TempSchIndex := SchIndex;

  while xml.Scan do begin
    if xml.CurPartType = ptEndTag then if SameText(xml.CurName, 'Range') then begin
      ind := SchIndex;
      Exit;
    end;
    if (xml.CurPartType = ptStartTag) then begin
      if Verify('Enabled',xml) then
        Enabled := LowerCase(xml.CurContent) = 'true'
      else
      if Verify('CaseSensitive',xml) then
        CaseSensitive := LowerCase(xml.CurContent) = 'true'
      else
      if Verify('OpenSymbol',xml) then
        fRule.fOpenSymbol.Symbol := xml.CurContent
      else
      if Verify('CloseSymbol',xml) then
        fRule.fCloseSymbol.Symbol := xml.CurContent
      else
      if Verify('OpenSymbolFinishOnEol',xml) then
        if LowerCase(xml.CurContent) = 'true' then
          fRule.fOpenSymbol.Symbol := fRule.fOpenSymbol.Symbol + #0
        else
      else
      if Verify('CloseSymbolFinishOnEol',xml) then
        if LowerCase(xml.CurContent) = 'true' then
          fRule.fCloseSymbol.Symbol := fRule.fCloseSymbol.Symbol + #0
        else
      else
      if Verify('CloseOnTerm',xml) then
        fRule.fCloseOnTerm := LowerCase(xml.CurContent) = 'true'
      else
      if Verify('CloseOnEol',xml) then
        fRule.fCloseOnEol := LowerCase(xml.CurContent) = 'true'
      else
      if Verify('AllowPredClose',xml) then
        fRule.fAllowPredClose := LowerCase(xml.CurContent) = 'true'
      else
      if Verify('OpenSymbolStartLine',xml) then
        if LowerCase(xml.CurContent) = 'true' then
          fRule.fOpenSymbol.StartLine := slFirst
        else if LowerCase(xml.CurContent) = 'nonspace' then
          fRule.fOpenSymbol.StartLine := slFirstNonSpace
        else
          fRule.fOpenSymbol.StartLine := slNotFirst
      else
      if Verify('CloseSymbolStartLine',xml) then
        if LowerCase(xml.CurContent) = 'true' then
          fRule.fCloseSymbol.StartLine := slFirst
        else if LowerCase(xml.CurContent) = 'nonspace' then
          fRule.fCloseSymbol.StartLine := slFirstNonSpace
        else
          fRule.fCloseSymbol.StartLine := slNotFirst
      else
      if Verify('AnyTerm',xml) then
        if LowerCase(xml.CurContent) = 'true' then
          fRule.fOpenSymbol.BrakeType := btAny
        else
          fRule.fOpenSymbol.BrakeType := btTerm
//        if StrToBoolDef(xml.CurContent, false) then
//          fRule.fOpenSymbol.BrakeType := btTerm;
      else
      if Verify('OpenSymbolPartOfTerm',xml) then
        if LowerCase(xml.CurContent) = 'true' then begin
          fRule.fOpenSymbol.StartType := stAny;
          fRule.fOpenSymbol.BrakeType := btAny;
        end else if LowerCase(xml.CurContent) = 'left' then begin
          fRule.fOpenSymbol.StartType := stAny;
          fRule.fOpenSymbol.BrakeType := btTerm;
        end else if LowerCase(xml.CurContent) = 'right' then begin
          fRule.fOpenSymbol.StartType := stTerm;
          fRule.fOpenSymbol.BrakeType := btAny;
        end else begin
          fRule.fOpenSymbol.StartType := stTerm;
          fRule.fOpenSymbol.BrakeType := btTerm;
        end
      else
      if Verify('CloseSymbolPartOfTerm',xml) then
        if LowerCase(xml.CurContent) = 'true' then begin
          fRule.fCloseSymbol.StartType := stAny;
          fRule.fCloseSymbol.BrakeType := btAny;
        end else if LowerCase(xml.CurContent) = 'left' then begin
          fRule.fCloseSymbol.StartType := stAny;
          fRule.fCloseSymbol.BrakeType := btTerm;
        end else if LowerCase(xml.CurContent) = 'right' then begin
          fRule.fCloseSymbol.StartType := stTerm;
          fRule.fCloseSymbol.BrakeType := btAny;
        end else begin
          fRule.fCloseSymbol.StartType := stTerm;
          fRule.fCloseSymbol.BrakeType := btTerm;
        end
      else
      if Verify('DelimiterChars',xml) then
//        if SameText(GetAttrValue('spaces', xml), 'true') then
//          TermSymbols := String2Set(xml.CurContent) + [#32, #9, #13, #10]
//        else
        if xml.CurPartType = ptContent then
          TermSymbols := StrToSet(xml.CurContent)
        else
//        CloseOnTerm := true;
      else
{      else if SameText(xml.CurName, 'TextStyle') then
      begin
        DefaultAttri := fStyles.getStyleDef(xml.CurContent, defaultAttr);
        if (NumberAttri = DefaultAttr) or (NumberAttri = nil) then
          NumberAttri := DefaultAttri;
      end
      else if SameText(xml.CurName, 'NumberStyle') then
        NumberAttri := fStyles.getStyleDef(xml.CurContent, defaultAttr);}
      if SameText(xml.CurName, 'Attri') or SameText(xml.CurName, 'Def') then begin
        if TempSchIndex >= 0 then LoadAttri(self, xml);
        dec(TempSchIndex);
      end else
      if SameText(xml.CurName, 'Range') then begin
        NewSynRange := TSynRange.Create;
        AddRange(NewSynRange);
        NewSynRange.LoadHglFromXml(xml, SchCount, SchIndex);
      end else
      if SameText(xml.CurName, 'KW') then begin
        NewSynKeyList := TSynKeyList.Create;
        AddKeyList(NewSynKeyList);
        NewSynKeyList.LoadHglFromXml(xml, SchCount, SchIndex);
      end else
      if SameText(xml.CurName, 'Set') then begin
        NewSynSet := TSynSet.Create;
        AddSet(NewSynSet);
        NewSynSet.LoadHglFromXml(xml, SchCount, SchIndex);
      end;
    end;
  end;
end;

procedure TSynRange.LoadHglFromStream(aSrc: TStream);
var
  buf: PChar;
  BufSize: Integer;
  xml: TXMLParser;
  SchCount, SchIndex: integer;
begin
  buf := nil; // Чтобы убрать Warning компилятора
  try
    BufSize := aSrc.Size;
    SchCount := 0;   SchIndex := -1;
    GetMem(buf, BufSize);
    aSrc.ReadBuffer(buf^, BufSize);
    xml := TXMLParser.Create;
    if xml.LoadFromBuffer(buf) then begin
      xml.StartScan;
      while xml.Scan do if (xml.CurPartType = ptStartTag) then
        else if Verify('SchemeIndex',xml) then
          SchIndex := StrToInt(xml.CurContent)
        else if Verify('Schemes',xml) then
          while xml.Scan do begin
            if (xml.CurPartType = ptStartTag) and Verify('S',xml) then
              inc(SchCount)
            else
            if xml.CurPartType = ptEndTag then if SameText(xml.CurName, 'Schemes') then
              Break;
          end
        else if SameText(xml.CurName, 'Range') then
          LoadHglFromXml(xml, SchCount, SchIndex);
    end;
  finally
    FreeMem(buf);
  end;
end;
