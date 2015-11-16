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
@abstract(Provides a universal highlighter for SynEdit)
@authors(Fantasist [walking_in_the_sky@yahoo.com], Vit [nevzorov@yahoo.com],
         Vitalik [vetal-x@mail.ru], Quadr0 [quadr02005@yahoo.com])
@created(2003)
@lastmod(2005-07-17)
SynUniHighlighter is a main TSynUniSyn package unit provides syntax
highlighting handling. It's a main unit need to be included to
use TSynUniSyn class.
}

unit SynUniHighlighter;

{I SynEdit.inc}

interface

uses
  SysUtils,
  Classes,
{$IFDEF SYN_CLX}
  Types,
  QGraphics,
{$ELSE}
  Windows,
  Graphics,
  Registry,
{$ENDIF}
  SynEditTypes,
  SynEditHighlighter,
  SynUniClasses,
  SynUniRules,
  SynUniParser,
  //### Code Folding ###
  SynEditCodeFolding;
  //### End Code Folding ###

Const
  { Localizable names }
  _Root = 'Root';
  _New = 'New';

type
  { Main class of TSynUniSyn package.
  It is a TSynCustomHighlighter class and it need to be assigned to
  TSynEdit component as other highlighters do. Contains all highlighters
  handling routines: loading, saving, ranges, sets and keywords handling. }
  TSynUniSyn = class(TSynCustomHighlighter)
  private
    procedure ReadSyntax(Reader: TReader);
    procedure WriteSyntax(Writer: TWriter);
  protected
    { Main rules container }
    fMainRules: TSynRange;
    { End Of Line indentifier }
    fEol: boolean;
    fPrEol: boolean;
    fLine: PChar;
    fLineNumber: Integer;
    Run: LongInt;
    fTokenPos: Integer;
    fCurrToken: TSynSymbol;
    fCurrentRule: TSynRange;
    SymbolList: array[char] of TAbstractSymbol;
    fPrepared: boolean;

    { List of color shemes defined in highlighting scheme }
    fSchemes: TStringList;
    fSchemeIndex: integer;

    fImportFormats: TList;

    procedure SpaceProc;
    { Gets TSynIdentChars }
    function GetIdentChars: TSynIdentChars; override;
    procedure DefineProperties(Filer: TFiler); override;
    { Gets SampleSource text defined in highlighting scheme }
    function GetSampleSource: string; override;
    { Set sample source }
    procedure SetSampleSource(Value: string); override;
  public
    { Gets highlighting scheme language name which for scheme is designed }
    class function GetLanguageName: string; override;
  public
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;
    { Returns default attribute }
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    { Returns current Range }
    function GetRange: Pointer; override;
    { Returns current token (string from fTokenPos to Run) }
    function GetToken: string; override;
    { Returns attribute of current token }
    function GetTokenAttribute: TSynHighlighterAttributes; override; {Abstract}
    { Return ID of current token }
    function GetTokenID: Integer;
    function GetTokenKind: integer; override;
    { Returns position of current token }
    function GetTokenPos: Integer; override;
    //function IsKeyword(const AKeyword: string): boolean; override;
    { Goes to the next token and open/close ranges }
    procedure Next; override;
    { Reset current range to MainRules }
    procedure ResetRange; override;
    { Set current line in SynEdit for highlighting }
    procedure SetLine(NewValue: string; LineNumber: Integer); override;
    procedure SetRange(Value: Pointer); override;
    { Reset of SynUniSyn is Reset of SynUniSyn.MainRules }
    procedure Reset;
    procedure Clear;
    { Prepare of SynUniSyn is Prepare of SynUniSyn.fMailRules }
    procedure Prepare;
    { Create sample rools }
    procedure CreateStandardRules;
    { Reads color schemes defined in highlighting scheme }
    procedure ReadSchemes(xml: TXMLParser);

    //### Code Folding ###
    { Reads code folding settings }
    procedure ReadCodeFolding(xml: TXMLParser;	ParentFold: TFoldRegionItem);
    //### End Code Folding ###

    { Reads information about highlighting scheme }
    
    //### Mystix ###
    procedure ReadInfo(xml: TXMLParser);
    //### End Mystix ###

    { Loads HGL highlighting scheme from XML-based HLR file }
    procedure LoadHglFromXml(xml: TXMLParser);
    { Loads HGL highlighting scheme from stream }
    procedure LoadHglFromStream(Stream: TStream);
    { Loads HGL highlighting scheme from file which format will be detected automatically }
    procedure LoadHglFromFile(FileName: string);

    { Saves HGL highlighting scheme to stream }
    procedure SaveHglToStream(Stream: TStream);
    { Saves HGL highlighting scheme to file}
    procedure SaveHglToFile(FileName: string);

    { Loads highlighting scheme from XML-based HLR file}
    procedure LoadFromXml(xml: TXMLParser);
    { Loads highlighting scheme from stream which format will be detected automatically }
    procedure LoadFromStream(Stream: TStream; FreeStream: boolean = True);
    { Loads highlighting scheme from file which format will be detected automatically }
    procedure LoadFromFile(FileName: string);

    { Gets highlighting scheme properties from stream }
    function GetAsStream: TMemoryStream;
    { Saves highlighting scheme to stream }
    procedure SaveToStream(Stream: TStream; Rule: TSynRule = nil);
    { Saves highlighting scheme to file }
    procedure SaveToFile(FileName: string; Rule: TSynRule = nil);

  public
    { Information about highlighting scheme }
    Info: TSynInfo;
    { Styles defined in highlighting schemes }
    Styles: TSynUniStyles;
    { Highlighting scheme full file name }
    SchemeFileName: string;
    SchemeName: string;
    property MainRules: TSynRange read fMainRules;
    property SchemesList: TStringList read fSchemes write fSchemes; //Vitalik 2004
    property SchemeIndex: integer read fSchemeIndex write fSchemeIndex; //Vitalik 2004
  end;

implementation

const
  SYNS_AttrTest = 'Test';

//------------------------ TSynUniSyn ------------------------------------------
constructor TSynUniSyn.Create(AOwner: TComponent);
var
  fTestAttri: TSynHighlighterAttributes;
begin
  inherited Create(AOwner);
  Info := TSynInfo.Create;
  Info.History := TStringList.Create;
  Info.Sample := TStringList.Create;
  fPrepared := False;

  //��� ��� ��� ����� ��� �������� ����� ���������!
  //������ ��� ����� ��� � ���������� [Underline + Italic]
  fTestAttri := TSynHighLighterAttributes.Create(SYNS_AttrTest);
  fTestAttri.Style := [fsUnderline, fsItalic];
  fTestAttri.Foreground := clBlue;
  fTestAttri.Background := clSilver;
  AddAttribute(fTestAttri);

  fSchemes := TStringList.Create;
  fSchemeIndex := -1;

  fMainRules := TSynRange.Create;
  MainRules.Name := _Root;
  fEol := False;
  fPrEol := False;
  fCurrentRule := MainRules;
  //AddNewScheme('Noname');
  fImportFormats := TList.Create;
end;

destructor TSynUniSyn.Destroy;
begin
  MainRules.Free;
  Info.History.Free;
  Info.Sample.Free;
  Info.Free;
  fSchemes.Free;
  fImportFormats.Free;
  inherited;
end;

procedure TSynUniSyn.SetLine(NewValue: string; LineNumber: Integer);

  function HaveNodeAnyStart(Node: TSymbolNode): boolean;
  var
    i: integer;
  begin
    Result := False;
    if Node.StartType = stAny then
    begin
      Result := True;
      Exit;
    end;
    for i := 0 to Node.NextSymbs.Count-1 do
      if (Node.NextSymbs.Nodes[i].StartType = stAny) or HaveNodeAnyStart(Node.NextSymbs.Nodes[i]) then
      begin
        Result := True;
        Exit;
      end
  end;

var i: integer;
begin
  if LineNumber = 1 then begin
    MainRules.ResetParents(MainRules);
    MainRules.ClearParsingFields();
  end;
  if not fCurrentRule.Prepared then begin //: If current Range isn't ready,
    Prepare;                              //: then prepare it and its sub-ranges
(*{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
!!!!!!! ��� � ����� � ��� �����-�� ����� !!!!!!!!!!!!!!!!!!!!!!!!*)
  for i := 0 to 255 do
    if (SymbolList[char(i)] <> nil) {temp}and (TSymbols(SymbolList[char(i)]).HeadNode <> nil){/temp} then
      fCurrentRule.HasNodeAnyStart[char(i)] := HaveNodeAnyStart(TSymbols(SymbolList[fCurrentRule.CaseFunct(char(i))]).HeadNode);
(*}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}*)
  end;
{begin} //Vitalik 2004
{was:
  fTrueLine := PChar(NewValue);
  l := Length(NewValue);
  ReallocMem(fLine, l+1);
  for i := 0 to l do
    fLine[i] := fCurrentRule.CaseFunct(fTrueLine[i]);
}
  fLine := PChar(NewValue);     //: Current string of SynEdit
{end} //Vitalik 2004
  Run := 0;                     //: Set Position of "parser" at the first char of string
  fTokenPos := 0;               //: Set Position of current token at the first char of string
  fLineNumber := LineNumber;    //: Number of current line in SynEdit
  fEol := False;                //: ???
  fPrEol := False;              //: ???
  Next;                         //: Find first token in the line
end;

procedure TSynUniSyn.Next;
var
  ParentCycle, CurrentParent: TSynRange;
  RangeLink: TSynRangeLink;
  isFindSame: boolean;
begin
  if fPrEol then //: if it was end of line then
  begin            //: if current range close on end of line then
    if (fCurrentRule.fRule.fCloseOnEol) or (fCurrentRule.fRule.fCloseOnTerm) then begin
      if fCurrentRule.OpenCount > 0 then
        fCurrentRule.OpenCount := fCurrentRule.OpenCount - 1
      else
        if fCurrentRule.ParentBackup <> nil then
          fCurrentRule.Parent := fCurrentRule.ParentBackup;
      if fCurrentRule.fRule.fAllowPredClose then begin
        fCurrentRule := fCurrentRule.Parent;
        while (fCurrentRule.fRule.fCloseOnEol) or (fCurrentRule.fRule.fCloseOnTerm) do
          fCurrentRule := fCurrentRule.Parent;
      end else
        fCurrentRule := fCurrentRule.Parent;
    end;
    fEol := True;    //: ???
    Exit;
  end;

  fTokenPos := Run; //: Start of cf current token is end of previsious
  //: if current range close on delimeter and current symbol is delimeter then
  if (fCurrentRule.fRule.fCloseOnTerm) and (fLine[Run] in fCurrentRule.fTermSymbols) then begin
    if fCurrentRule.OpenCount > 0 then
      fCurrentRule.OpenCount := fCurrentRule.OpenCount - 1
    else
      if fCurrentRule.ParentBackup <> nil then
        fCurrentRule.Parent := fCurrentRule.ParentBackup;
    if fCurrentRule.fRule.fAllowPredClose then begin
      fCurrentRule := fCurrentRule.Parent;
      while (fCurrentRule.fRule.fCloseOnTerm) do
        fCurrentRule := fCurrentRule.Parent;
    end
    else
      fCurrentRule := fCurrentRule.Parent;
  end;

  //: if we can't find token from current position:
  if not fCurrentRule.SymbolList[fCurrentRule.CaseFunct(fLine[Run])].GetToken(fCurrentRule, fLine, Run, fCurrToken) then //Vitalik 2004
  begin
    fCurrToken := fCurrentRule.fDefaultSynSymbol; //: Current token is just default symbol
    while not ((fLine[Run] in fCurrentRule.fTermSymbols) or fCurrentRule.HasNodeAnyStart[fCurrentRule.CaseFunct(fLine[Run])]) do
      inc(Run);   //: goes to the first non-delimeter symbol
  end
  else //: else (we find token!)
  if (fCurrentRule.fClosingSymbol = fCurrToken) then begin //: if current token close current range
//  if (fCurrentRule.fClosingSymbol <> nil) and (fCurrentRule.fClosingSymbol.Symbol = fCurrToken.Symbol) then
    if fCurrentRule.OpenCount > 0 then
      fCurrentRule.OpenCount := fCurrentRule.OpenCount - 1
    else
      if fCurrentRule.ParentBackup <> nil then
        fCurrentRule.Parent := fCurrentRule.ParentBackup;
    if fCurrentRule.fRule.fAllowPredClose then begin
      fCurrentRule := fCurrentRule.Parent;
      while (fCurrentRule.fClosingSymbol <> nil) and (fCurrentRule.fClosingSymbol.Symbol = fCurrToken.Symbol) do
        fCurrentRule := fCurrentRule.Parent;
    end else
      fCurrentRule := fCurrentRule.Parent
  end else
  if fCurrToken.fOpenRule <> nil then begin //: else if current token open range then
    CurrentParent := fCurrentRule;
    if fCurrToken.fOpenRule is TSynRangeLink then begin
      RangeLink := TSynRangeLink(fCurrToken.fOpenRule);
      fCurrentRule := RangeLink.Range;
      ParentCycle := CurrentParent;
      isFindSame := False;
      while ParentCycle <> nil do begin // ���� ���� �� � ���. ������� ����� �� ��������
        if ParentCycle = fCurrentRule then begin
          if RangeLink.Range.OpenCount = 0 then begin // ������ �������� ���������� � ���� �������.
            fCurrentRule.ParentBackup := RangeLink.Range.Parent;
            fCurrentRule.Parent := CurrentParent;
            RangeLink.Range.OpenCount := 1;
          end else begin
            RangeLink.Range.OpenCount := RangeLink.Range.OpenCount + 1;
          end;
          isFindSame := True;
          break;
        end;
        ParentCycle := ParentCycle.Parent;
      end;
     if not isFindSame then begin
{        fCurrentRule.ParentBackup := RangeLink.Range.Parent;
        fCurrentRule.Parent := CurrentParent;
        RangeLink.Range.OpenCount := 1;
//      fCurrentRule.Parent := RangeLink.Parent;}
      end
    end
    else if fCurrToken.fOpenRule is TSynRange then begin
      fCurrentRule := TSynRange(fCurrToken.fOpenRule);  //: open range
      fCurrentRule.Parent := CurrentParent;
    end;
  end;

  if fLine[Run] = #0 then //: If end of line
    fPrEol := True;         //: ???

end;

procedure TSynUniSyn.SpaceProc;
//! Never used!!! SSS
begin
  repeat
    Inc(Run);
  until (fLine[Run] > #32) or (fLine[Run] in [#0, #10, #13]);
end;

{
function TSynUniSyn.IsKeyword(const aKeyword: string): boolean;
//! Never used!!!! ??? SSS
begin
  Result := fSymbols.FindSymbol(aKeyword) <> nil;
end;
}

function TSynUniSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT:    Result := fCurrentRule.Attribs;
    SYN_ATTR_IDENTIFIER: Result := fCurrentRule.Attribs;
    SYN_ATTR_KEYWORD:    Result := fCurrentRule.Attribs;
    SYN_ATTR_STRING:     Result := fCurrentRule.Attribs;
    SYN_ATTR_WHITESPACE: Result := fCurrentRule.Attribs;
  else
    Result := nil;
  end;
end;

function TSynUniSyn.GetEol: Boolean;
begin
  Result := fEol;
end;

function TSynUniSyn.GetRange: Pointer;
begin
  Result := fCurrentRule;
end;

function TSynUniSyn.GetToken: string;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  Setstring(Result, (fLine + fTokenPos), Len);                                  
end;

function TSynUniSyn.GetTokenID: Integer;
//: ??? ��������� ��� ���������� �������������? ����� �� �� ���������� � �� ������������!
//: ������ ���-���� � ��� �������...
begin
  Result := 1; //# CODE_REVIEW fCurrToken.ID;
end;

function TSynUniSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
//  fCurrToken.Attr.Style := fCurrToken.Attr.Style + [fsUnderline];
//  if GetEol then
//    Result := nil
    Result := fCurrToken.Attributes;
end;

function TSynUniSyn.GetTokenKind: integer;
//~ ����� � Kind � ������ fCurrToken ������� ��� ��� ?: ����� ��� Range ��� Set
begin
  Result := 1; //# CODE_REVIEW   fCurrToken.ID;
end;

function TSynUniSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

procedure TSynUniSyn.ResetRange;
begin
  fCurrentRule := MainRules;
end;

procedure TSynUniSyn.SetRange(Value: Pointer);
//: Set current range
begin
  fCurrentRule := TSynRange(Value);
end;

class function TSynUniSyn.GetLanguageName: string;
begin
  Result := 'UniLanguage';
end;

procedure TSynUniSyn.Clear;
begin
  MainRules.Clear;
  Info.Clear;
end;

procedure TSynUniSyn.CreateStandardRules;
var r: TSynRange;
    kw: TSynKeyList;
begin
  self.MainRules.Clear;
  self.MainRules.Attribs.Foreground := clBlack;
  self.MainRules.Attribs.Background := clWhite;
  self.MainRules.CaseSensitive := False;

  r := TSynRange.Create('''', '''');
  r.Name := 'Strings ''..''';
  r.Attribs.Foreground := clRed;
  r.Attribs.Background := clWhite;
  r.CaseSensitive := False;
  r.fRule.fOpenSymbol.BrakeType := btAny;
  self.MainRules.AddRange(r);

  r := TSynRange.Create('"', '"');
  r.Name := 'Strings ".."';
  r.Attribs.Foreground := clRed;
  r.Attribs.Background := clWhite;
  r.CaseSensitive := False;
  r.fRule.fOpenSymbol.BrakeType := btAny;
  self.MainRules.AddRange(r);

  r := TSynRange.Create('{', '}');
  r.Name := 'Remarks {..}';
  r.Attribs.Foreground := clNavy;
  r.Attribs.Background := clWhite;
  r.CaseSensitive := False;
  r.fRule.fOpenSymbol.BrakeType := btAny;
  self.MainRules.AddRange(r);

  r := TSynRange.Create('(*', '*)');
  r.Name := 'Remarks (*..*)';
  r.Attribs.Foreground := clNavy;
  r.Attribs.Background := clWhite;
  r.CaseSensitive := False;
  r.fRule.fOpenSymbol.BrakeType := btAny;
  self.MainRules.AddRange(r);

  r := TSynRange.Create('/*', '*/');
  r.Name := 'Remarks /*..*/';
  r.Attribs.Foreground := clNavy;
  r.Attribs.Background := clWhite;
  r.CaseSensitive := False;
  r.fRule.fOpenSymbol.BrakeType := btAny;
  self.MainRules.AddRange(r);

  kw := TSynKeyList.Create('');
  kw.Name := 'Key words';
  kw.Attribs.Foreground := clGreen;
  kw.Attribs.Background := clWhite;
  self.MainRules.AddKeyList(kw);
end;

procedure TSynUniSyn.Prepare;
  function HaveNodeAnyStart(Node: TSymbolNode): boolean;
  var
    i: integer;
  begin
    Result := False;
    if Node.StartType = stAny then
    begin
      Result := True;
      Exit;
    end;
    for i := 0 to Node.NextSymbs.Count-1 do
      if (Node.NextSymbs.Nodes[i].StartType = stAny) or HaveNodeAnyStart(Node.NextSymbs.Nodes[i]) then
      begin
        Result := True;
        Exit;
      end
  end;

var i: integer;
begin
  MainRules.Prepare(MainRules);
//  for i := 0 to 255 do
//  if (MainRules.SymbolList[char(i)] <> MainRules.fDefaultTermSymbol) and (MainRules.SymbolList[char(i)] <> MainRules.fDefaultSymbols) then
//    MessageBox(0,PChar(TSymbols(MainRules.SymbolList[char(i)]).HeadNode.tkSynSymbol.Symbol),'1',0);
  for i := 0 to 255 do
//    if (MainRules.SymbolList[char(i)] <> nil) {temp}and (TSymbols(MainRules.SymbolList[char(i)]).HeadNode <> nil){/temp} then
    if (MainRules.SymbolList[char(i)] <> MainRules.fDefaultTermSymbol) and (MainRules.SymbolList[char(i)] <> MainRules.fDefaultSymbols) and (TSymbols(MainRules.SymbolList[char(i)]).HeadNode <> nil) then
      MainRules.HasNodeAnyStart[char(i)] := HaveNodeAnyStart(TSymbols(MainRules.SymbolList[MainRules.CaseFunct(char(i))]).HeadNode);
end;

procedure TSynUniSyn.Reset;
begin
  MainRules.Reset;
end;

procedure TSynUniSyn.DefineProperties(Filer: TFiler);
//! Never used ????
var
  iHasData: boolean;
begin
  inherited;
  if Filer.Ancestor <> nil then
    iHasData := True
  else
    iHasData := MainRules.RangeCount > 0;
  Filer.DefineProperty( 'Syntax', ReadSyntax, WriteSyntax, {True}iHasData );
end;

procedure TSynUniSyn.ReadSyntax(Reader: TReader);
//: This is some metods for reading ??? ??? ???
var
  iBuffer: TStringStream;
begin
//  iBuffer := nil;
//  try
    iBuffer := TStringStream.Create( Reader.ReadString );
    iBuffer.Position := 0;
    LoadFromStream( iBuffer );
//  finally
//    iBuffer.Free;
//  end;
end;

procedure TSynUniSyn.WriteSyntax(Writer: TWriter);
//: This is some metods for writing ??? ??? ???
var
  iBuffer: TStringStream;
begin
  iBuffer := TStringStream.Create( '' );
  try
    SaveToStream( iBuffer );
    iBuffer.Position := 0;
    Writer.WriteString( iBuffer.DataString );
  finally
    iBuffer.Free;
  end;
end;

function TSynUniSyn.GetIdentChars: TSynIdentChars;
//: Return IdentChars - hmm... What for ??? word selection?
begin
  Result := [#32..#255] - fCurrentRule.TermSymbols;
end;

function TSynUniSyn.GetSampleSource: string;
begin
  Result := Info.Sample.Text;
end;

procedure TSynUniSyn.SetSampleSource(Value: string);
begin
  Info.Sample.Text := Value;
end;

procedure TSynUniSyn.LoadFromXml(xml: TXMLParser);
var
  i: integer;
  Key, Value: string;
begin
  Clear;
  while xml.Scan do begin
    if (xml.CurPartType = ptStartTag) or (xml.CurPartType = ptEmptyTag) then
      if SameText(xml.CurName, 'UniHighlighter') then
        if xml.CurAttr.Count = 0 then begin
          LoadHglFromXml(xml);
          Exit;
        end else
      else
      if SameText(xml.CurName, 'Info') then
        Info.LoadFromXml(xml)
      else
      if SameText(xml.CurName, 'Scheme') then begin
        SchemeFileName := '';   SchemeName := '';
        for i := 0 to xml.CurAttr.Count - 1 do begin
          Key := xml.CurAttr.Name(i);   Value := xml.CurAttr.Value(i);
          if SameText('File', Key) then SchemeFileName := Value else
          if SameText('Name', Key) then SchemeName := Value;
        end;
        if FileExists(SchemeFileName) then begin
          if Styles <> nil then
            Styles.Free;
          Styles := TSynUniStyles.Create;
          Styles.FileName := SchemeFileName;
          Styles.Load;
        end;
      end else
      if SameText(xml.CurName, 'Range') then begin
//        fMainRules.SetStyles(fStyles);
        fMainRules.Styles := Styles;
        fMainRules.LoadFromXml(xml);
        Break;
      end
  end
end;

procedure TSynUniSyn.LoadFromStream(Stream: TStream; FreeStream: boolean);
var
  buf: PChar;
  BufSize: Integer;
  xml: TXMLParser;
begin
  buf := nil; // ����� ������ Warning �����������
  try
    BufSize := Stream.Size;
    GetMem(buf, BufSize+1);
    Stream.ReadBuffer(buf^, BufSize);
    buf[BufSize] := #0;
    xml := TXMLParser.Create;
    if xml.LoadFromBuffer(buf) then begin
      xml.StartScan;
      LoadFromXml(xml);
    end;
  finally
    FreeMem(buf);
    if FreeStream then Stream.Free;
    DefHighlightChange(Self);    
  end;
end;

procedure TSynUniSyn.LoadFromFile(FileName: string);
var
  xml: TXMLParser;
begin
  if not FileExists(FileName) then
    raise Exception.Create(ClassName + '.LoadFromFile - "'+FileName+'" does not exists.');
  xml := TXMLParser.Create;
  try
    if xml.LoadFromFile(FileName) then begin
      xml.StartScan;
      LoadFromXml(xml);
      SchemeFileName := FileName; //����� ��� Quadr0
    end;
  finally
    xml.Free;
    DefHighlightChange( Self );
  end;
end;

procedure TSynUniSyn.SaveToStream(Stream: TStream; Rule: TSynRule);
var
  StreamWriter: TStreamWriter;
begin
  StreamWriter := TStreamWriter.Create(Stream);
  with StreamWriter do begin
    WriteTag(0, 'UniHighlighter');
    WriteParam('version', '1.8', CloseStartTag);
    Info.SaveToStream(StreamWriter, 2);
    WriteTag(2, 'Scheme');
    WriteParam('File', SchemeFileName);
    WriteParam('Name', SchemeName, CloseEmptyTag);
    if Rule = nil then
      MainRules.SaveToStream(StreamWriter, 2)
    else
      Rule.SaveToStream(StreamWriter, 2);
    InsertTag(2, 'CopyRight','Rule file for UniHighlighter Delphi component (Copyright(C) Fantasist(walking_in_the_sky@yahoo.com), Vit(nevzorov@yahoo.com), Vitalik(vetal-x@mail.ru), Quadr0(quadr02005@yahoo.com) 2002-2005)');
    WriteTag(0, '/UniHighlighter', True);
  end;
  StreamWriter.Free;
end;

function TSynUniSyn.GetAsStream: TMemoryStream;
begin
  Result := TMemoryStream.Create;
  SaveToStream(Result);
end;

procedure TSynUniSyn.SaveToFile(FileName: string; Rule: TSynRule);
var
  F: TFileStream;
begin
  if FileName = '' then
    raise exception.Create(ClassName + '.SaveToFile - FileName is empty');
  F := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(F, Rule)
  finally
    F.Free;
  end;
end;

procedure TSynUniSyn.SaveHglToStream(Stream: TStream);
//: Save Highlighter to stream
  procedure WriteString(const aStr: string);
  begin
    Stream.Write( aStr[1], Length(aStr) );
    Stream.Write( #10#13, 1 );
  end;

  function Indent(i: integer): string;
  begin
    SetLength( Result, i );
    FillChar( Result[1], i, #32 );
  end;

  function GetValidValue(Value: string): string;
  begin
    Value := StringReplace(Value, '&', '&amp;', [rfReplaceAll, rfIgnoreCase]);
    Value := StringReplace(Value, '<', '&lt;', [rfReplaceAll, rfIgnoreCase]);
    Value := StringReplace(Value, '"', '&quot;', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Value, '>', '&gt;', [rfReplaceAll, rfIgnoreCase]);
  end;

  procedure InsertTag(Ind: integer; Name: string; Value: string);
  begin
    WriteString( Format('%s<%s>%s</%s>', [Indent(Ind), Name, GetValidValue(Value), Name]) );
  end;

  procedure OpenTag(Ind: integer; Name: string; Param: string = ''; ParamValue: string = '');
  begin
    if Param = '' then
      WriteString(Format('%s<%s>', [Indent(Ind), Name]))
    else
      WriteString(Format('%s<%s %s="%s">', [Indent(Ind), Name, Param, GetValidValue(ParamValue)]));
  end;

  procedure SaveColor(MainTag: string; Ind, Fore, Back: integer; Style: TFontStyles; PFore, PBack: boolean);
    procedure InsertTagBool(Ind: integer; Name: string; Value: Boolean);
    begin
      if Value then
        WriteString(Format('%s<%s>True</%s>', [Indent(Ind), Name, Name]))
      else
        WriteString(Format('%s<%s>False</%s>', [Indent(Ind), Name, Name]))
    end;
  begin
    OpenTag(Ind, MainTag);
    InsertTag(Ind+1, 'Back', Inttostr(Back));
    InsertTag(Ind+1, 'Fore', Inttostr(Fore));
    InsertTag(Ind+1, 'Style', FontStyleToStr(Style));
    InsertTagBool(Ind+1, 'ParentForeground', PFore);
    InsertTagBool(Ind+1, 'ParentBackground', PBack);
    OpenTag(Ind, '/'+MainTag);
  end;

  procedure SaveKWGroup(Ind: integer; G: TSynKeyList);
  var i: integer;
    procedure InsertTagBool(Ind: integer; Name: string; Value: Boolean);
    begin
      if Value then
        WriteString(Format('%s<%s>True</%s>', [Indent(Ind), Name, Name]))
      else
        WriteString(Format('%s<%s>False</%s>', [Indent(Ind), Name, Name]))
    end;
  begin
    OpenTag(Ind, 'KW', 'Name', G.Name);
    for i := 0 to fSchemes.Count-1 do begin
      G.ind := i;
      SaveColor('Attri', Ind+1, G.Attribs.Foreground, G.Attribs.Background, G.Attribs.Style, G.Attribs.ParentForeground, G.Attribs.ParentBackground);
    end;
    G.ind := fSchemeIndex;
	InsertTagBool(Ind+1, 'Enabled', G.Enabled);
    For i := 0 to G.KeyList.Count-1 do InsertTag(Ind+1, 'W', G.KeyList[i]);
    OpenTag(Ind, '/KW');
  end;

  procedure SaveSet(Ind: integer; S: TSynSet);
  var i: integer;
    procedure InsertTagBool(Ind: integer; Name: string; Value: Boolean);
    begin
      if Value then
        WriteString(Format('%s<%s>True</%s>', [Indent(Ind), Name, Name]))
      else
        WriteString(Format('%s<%s>False</%s>', [Indent(Ind), Name, Name]))
    end;
  begin
    OpenTag(Ind, 'Set', 'Name', S.Name);
    for i := 0 to fSchemes.Count-1 do begin
      S.ind := i;
      SaveColor('Attri', Ind+1, S.Attribs.Foreground, S.Attribs.Background, S.Attribs.Style, S.Attribs.ParentForeground, S.Attribs.ParentBackground);
    end;
    S.ind := fSchemeIndex;
    InsertTagBool(Ind+1, 'Enabled', S.Enabled);
{    if S.StartType = stAny then
      if S.BrakeType = btAny then
        InsertTag(Ind+1, 'SymbolSetPartOfTerm', 'True')
      else
        InsertTag(Ind+1, 'SymbolSetPartOfTerm', 'Left')
    else
      if S.BrakeType = btAny then
        InsertTag(Ind+1, 'SymbolSetPartOfTerm', 'Right')
      else
        InsertTag(Ind+1, 'SymbolSetPartOfTerm', 'False');}

    InsertTag(Ind+1, 'S', SetToStr(S.SymbSet));
    OpenTag(Ind, '/Set');
  end;

  procedure SaveRange(Ind: integer; R: TSynRange);
  var i: integer;
    procedure InsertTagBool(Ind: integer; Name: string; Value: Boolean);
    begin
      if Value then
        WriteString(Format('%s<%s>True</%s>', [Indent(Ind), Name, Name]))
      else
        WriteString(Format('%s<%s>False</%s>', [Indent(Ind), Name, Name]))
    end;

  begin
    OpenTag(Ind, 'Range', 'Name', R.Name);
    for i := 0 to fSchemes.Count-1 do begin
      R.ind := i;
      SaveColor('Attri', Ind, R.Attribs.Foreground, R.Attribs.Background, R.Attribs.Style, R.Attribs.ParentForeground, R.Attribs.ParentBackground);
    end;
    R.ind := fSchemeIndex;
    InsertTagBool(Ind, 'Enabled', R.Enabled);
    if (Length(R.fRule.fOpenSymbol.Symbol) > 0) and (R.fRule.fOpenSymbol.Symbol[Length(R.fRule.fOpenSymbol.Symbol)] = #0) then begin
       InsertTag(Ind, 'OpenSymbol', copy(R.fRule.fOpenSymbol.Symbol,1,Length(R.fRule.fOpenSymbol.Symbol)-1));
       InsertTagBool(Ind, 'OpenSymbolFinishOnEol', true);
    end else begin
       InsertTag(Ind, 'OpenSymbol', R.fRule.fOpenSymbol.Symbol);
       InsertTagBool(Ind, 'OpenSymbolFinishOnEol', false);
    end;

    if (Length(R.fRule.fCloseSymbol.Symbol) > 0) and (R.fRule.fCloseSymbol.Symbol[Length(R.fRule.fCloseSymbol.Symbol)] = #0) then begin
       InsertTag(Ind, 'CloseSymbol', copy(R.fRule.fCloseSymbol.Symbol,1,Length(R.fRule.fCloseSymbol.Symbol)-1));
       InsertTagBool(Ind, 'CloseSymbolFinishOnEol', true);
    end else begin
       InsertTag(Ind, 'CloseSymbol', R.fRule.fCloseSymbol.Symbol);
       InsertTagBool(Ind, 'CloseSymbolFinishOnEol', false);
    end;
    if R.fRule.fOpenSymbol.StartLine = slFirst then
      InsertTag(Ind, 'OpenSymbolStartLine', 'True')
      else if R.fRule.fOpenSymbol.StartLine = slFirstNonSpace then
        InsertTag(Ind, 'OpenSymbolStartLine', 'NonSpace')
        else
          InsertTag(Ind, 'OpenSymbolStartLine', 'False');
    if R.fRule.fCloseSymbol.StartLine = slFirst then
      InsertTag(Ind, 'CloseSymbolStartLine', 'True')
      else if R.fRule.fCloseSymbol.StartLine = slFirstNonSpace then
        InsertTag(Ind, 'CloseSymbolStartLine', 'NonSpace')
        else
          InsertTag(Ind, 'CloseSymbolStartLine', 'False');
    InsertTag(Ind, 'DelimiterChars', SetToStr(R.TermSymbols));

    if R.fRule.fOpenSymbol.StartType = stAny then
      if R.fRule.fOpenSymbol.BrakeType = btAny then
        InsertTag(Ind, 'OpenSymbolPartOfTerm', 'True')
      else
        InsertTag(Ind, 'OpenSymbolPartOfTerm', 'Left')
    else
      if R.fRule.fOpenSymbol.BrakeType = btAny then
        InsertTag(Ind, 'OpenSymbolPartOfTerm', 'Right')
      else
        InsertTag(Ind, 'OpenSymbolPartOfTerm', 'False');
    if R.fRule.fCloseSymbol.StartType = stAny then
      if R.fRule.fCloseSymbol.BrakeType = btAny then
        InsertTag(Ind, 'CloseSymbolPartOfTerm', 'True')
      else
        InsertTag(Ind, 'CloseSymbolPartOfTerm', 'Left')
    else
      if R.fRule.fCloseSymbol.BrakeType = btAny then
        InsertTag(Ind, 'CloseSymbolPartOfTerm', 'Right')
      else
        InsertTag(Ind, 'CloseSymbolPartOfTerm', 'False');

    InsertTagBool(Ind, 'CloseOnTerm', R.fRule.fCloseOnTerm);
    InsertTagBool(Ind, 'CloseOnEol', R.fRule.fCloseOnEol);
    InsertTagBool(Ind, 'AllowPredClose', R.fRule.fAllowPredClose);
    InsertTagBool(Ind, 'CaseSensitive', R.CaseSensitive);
    For i := 0 to R.KeyListCount-1 do SaveKWGroup(Ind, R.KeyLists[i]);
    For i := 0 to R.SetCount-1 do SaveSet(Ind, R.Sets[i]);
    For i := 0 to R.RangeCount-1 do SaveRange(Ind+1, R.Ranges[i]);
    OpenTag(Ind, '/Range');
  end;

  procedure SaveInfo;
    var i: integer;
  begin
    OpenTag(1, 'Info');

    OpenTag(2, 'General');
    InsertTag(3, 'Name', info.General.Name);
    InsertTag(3, 'FileTypeName', info.General.Extensions);
//    InsertTag(3, 'Layout', info.General.Layout);
    OpenTag(2, '/General');

    OpenTag(2, 'Author');
    InsertTag(3, 'Name', Info.Author.Name);
    InsertTag(3, 'Email', Info.Author.Email);
    InsertTag(3, 'Web', Info.Author.Web);
    InsertTag(3, 'Copyright', Info.Author.Copyright);
    InsertTag(3, 'Company', Info.Author.Company);
    InsertTag(3, 'Remark', Info.Author.Remark);
    OpenTag(2, '/Author');

    OpenTag(2, 'Version');
    InsertTag(3, 'Version', IntToStr(Info.Version.Version));
    InsertTag(3, 'Revision', IntToStr(Info.Version.Revision));
    InsertTag(3, 'Date', FloatToStr(Info.Version.ReleaseDate));
    case Info.Version.VersionType of
      vtInternalTest: InsertTag(3, 'Type', 'Internal Test');
      vtBeta: InsertTag(3, 'Type', 'Beta');
      vtRelease: InsertTag(3, 'Type', 'Release');
    end;
    OpenTag(2, '/Version');

    OpenTag(2, 'History');
    for i := 0 to Info.history.count-1 do InsertTag(3, 'H', Info.history[i]);
    OpenTag(2, '/History');

    OpenTag(2, 'Sample');
    for i := 0 to Info.Sample.count-1 do InsertTag(3, 'S', Info.Sample[i]);
    OpenTag(2, '/Sample');

    OpenTag(1, '/Info');
  end;

  procedure SaveSchemes;
  var
    i: integer;
  begin
    InsertTag(1, 'SchemeIndex', IntToStr(fSchemeIndex));
    OpenTag(1, 'Schemes');
    for i := 0 to self.SchemesList.Count-1 do
      InsertTag(2, 'S', fSchemes.Strings[i]);
    OpenTag(1, '/Schemes');
  end;

begin
  OpenTag(0, 'UniHighlighter');
  OpenTag(1, 'ImportantInfo');
  WriteString(Indent(2)+'******* Please read carefully *************************');
  WriteString(Indent(2)+'* Please, make any changes in this file very carefuly!*');
  WriteString(Indent(2)+'* It is much more convinient to use native designer!  *');
  WriteString(Indent(2)+'*******************************************************');
  OpenTag(1, '/ImportantInfo');
  SaveInfo;
  SaveSchemes;
  SaveRange(1, self.MainRules);
  InsertTag(1, 'CopyRight','Rule file for UniHighlighter Delphi component (Copyright(C) Fantasist(walking_in_the_sky@yahoo.com), Vit(nevzorov@yahoo.com), Vitalik(vetal-x@mail.ru), 2002-2004)');
  OpenTag(0, '/UniHighlighter');
end;

procedure TSynUniSyn.LoadHglFromXml(xml: TXMLParser);
begin
  Clear;
  SchemeIndex := 0;
  while xml.Scan do begin
    if (xml.CurPartType = ptStartTag) then
      if Verify('Info',xml) then
        ReadInfo(xml)
      else
      if Verify('SchemeIndex',xml) then
        SchemeIndex := StrToInt(xml.CurContent)
      else
      if Verify('Schemes',xml) then
        ReadSchemes(xml)
      else
      //### Code Folding ###
      if Verify('CodeFolding',xml) then
        ReadCodeFolding(xml, nil)
      else
      //### End Code Folding ###
      if SameText(xml.CurName, 'Range') then begin
        fMainRules.LoadHglFromXml(xml, fSchemes.Count, SchemeIndex);
        Break;
      end
  end
end;

//### Mystix ###
// Removed some bolating tags
procedure TSynUniSyn.ReadInfo(xml: TXMLParser);
begin
  while xml.Scan do
  begin
    if (xml.CurPartType = ptStartTag) then
    begin
      if Verify('General',xml) then
        while xml.Scan do
          if (xml.CurPartType = ptStartTag) then
          begin
            if Verify('Name', xml) then
            	Info.General.Name := xml.CurContent
            else if Verify('FileTypeName', xml) then
            	Info.General.Extensions := xml.CurContent
					end
          else if (xml.CurPartType = ptEndTag) and SameText(xml.CurName, 'General') then
						Break;
    end
    else if (xml.CurPartType = ptEndTag) and SameText(xml.CurName, 'Info') then
    	Exit;
  end;
end;
//### End Mystix ###

procedure TSynUniSyn.ReadSchemes(xml: TXMLParser);
begin
  if fSchemes <> nil then begin
    fSchemes.Clear();
    //MainRules.ClearAttributes();
  end
  else
    raise Exception.Create(ClassName + '.ReadSchemes - property Schemes not initialized.');

  while xml.Scan do begin
    if (xml.CurPartType = ptStartTag) and Verify('S',xml) then
      fSchemes.Add(xml.curContent)
    else
    if xml.CurPartType = ptEndTag then if SameText(xml.CurName, 'Schemes') then
      Exit
  end;
end;

//### Code Folding ###
procedure TSynUniSyn.ReadCodeFolding(xml: TXMLParser;
	ParentFold: TFoldRegionItem);
var
	AddCloseKeyWord, AllowNoSubFolds, WholeWords: Boolean;
  FoldRegionType: TFoldRegionType;
  OpenKeyWord, CloseKeyWord, OpenRegExp, CloseRegExp: String;
  OpenUseRegExp, CloseUseRegExp: Boolean;
  FoldRegion: TFoldRegionItem;

  function Entities2Chars(S: String): String;
  var
    i: Integer;
  const
    sEntities: array[0..3] of String = ('&quot;', '&lt;', '&gt;', '&apos;');
    sChars: array[0..3] of String = ('"', '<', '>', '''');
  begin
    Result := S;

    for i := 0 to 3 do
      Result := StringReplace(Result, sEntities[i], sChars[i], [rfReplaceAll]);
  end;
begin
	// Stuff to shut up the compiler
  AddCloseKeyWord := False;
  AllowNoSubFolds := False;
  WholeWords := False;
  FoldRegionType := rtChar;

	while xml.Scan do
  begin
  	if xml.CurPartType = ptStartTag then
    begin
    	if Verify('FoldRegion',xml) then
      begin
      	AddCloseKeyWord := StrToBool( xml.CurAttr.Value('AddCloseKeyword') );
        AllowNoSubFolds := StrToBool( xml.CurAttr.Value('AllowNoSubFolds') );
        FoldRegionType := TFoldRegionType( StrToInt( xml.CurAttr.Value('Type') ) );
        WholeWords := StrToBool(xml.CurAttr.Value('WholeWords') );
      end
      else if Verify('SkipRegions',xml) then
      	// Iterate through skip regions
      	while xml.Scan do
        begin
        	if (xml.CurPartType = ptEmptyTag) then
          begin
            if (Verify('String',xml)) then
          	  FoldRegions.SkipRegions.Add(
                Entities2Chars(xml.CurAttr.Value('Open')),
          		  Entities2Chars(xml.CurAttr.Value('Close')),
                Entities2Chars(xml.CurAttr.Value('Escape')),
                itString)
            else if (Verify('MultiLineComment',xml)) then
          	  FoldRegions.SkipRegions.Add(
                Entities2Chars(xml.CurAttr.Value('Open')),
          		  Entities2Chars(xml.CurAttr.Value('Close')),
                '',
                itMultiLineComment)
            else if (Verify('SingleLineComment',xml)) then
          	  FoldRegions.SkipRegions.Add(
                Entities2Chars(xml.CurAttr.Value('Open')),
          		  '',
                '',
                itSingleLineComment);
          end
          else if (xml.CurPartType = ptEndTag) and (Verify('SkipRegions',xml)) then
            Break;
        end
      else if Verify('SubFoldRegions',xml) then
      begin
      	if ParentFold = nil then
        	FoldRegion := FoldRegions.Add(FoldRegionType, AddCloseKeyWord,
          	AllowNoSubFolds, WholeWords, PChar(OpenKeyWord), PChar(CloseKeyWord),
            ParentFold)
        else
        	FoldRegion := ParentFold.SubFoldRegions.Add(FoldRegionType,
          	AddCloseKeyWord, AllowNoSubFolds, WholeWords, PChar(OpenKeyWord),
          	PChar(CloseKeyWord), ParentFold);

        ReadCodeFolding(xml, FoldRegion);
      end;
    end
    else if xml.CurPartType = ptEmptyTag then
    begin
    	if Verify('Open',xml) then
      begin
      	OpenKeyWord := xml.CurAttr.Value('Keyword');
        OpenRegExp := xml.CurAttr.Value('RegExp');
        OpenUseRegExp := StrToBool( xml.CurAttr.Value('UseRegExp') );
      end
      else if Verify('Close',xml) then
      begin
      	CloseKeyWord := xml.CurAttr.Value('Keyword');
        CloseRegExp := xml.CurAttr.Value('RegExp');
        CloseUseRegExp := StrToBool( xml.CurAttr.Value('UseRegExp') );
      end;
    end
    else if (xml.CurPartType = ptEndTag)
    and ((xml.CurName = 'SubFoldRegions') or (xml.CurName = 'CodeFolding')) then
    	Exit;
  end;
end;
//### End Code Folding ###

procedure TSynUniSyn.LoadHglFromFile(FileName: string);
//: Load Highlighter'a from file
var
//  F: TFileStream;
  xml: TXMLParser;
begin
{  if FileName = '' then
    raise exception.Create('FileName is empty');
  F := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadHglFromStream( F, OnlyInfo );
  finally
    F.Free;
  end;}
  if not fileExists(FileName) then
    raise Exception.Create(ClassName + '.LoadHglFromFile - "'+FileName+'" does not exists.');
  xml := TXMLParser.Create;
  try
    if xml.LoadFromFile(FileName) then begin
      xml.StartScan;
      LoadHglFromXml(xml);
    end;
  finally
    xml.Free;
    DefHighlightChange( Self );
  end;
end;

procedure TSynUniSyn.SaveHglToFile(FileName: string);
//: Save Highlighter to file
var
  F: TFileStream;
begin
  if FileName = '' then
    raise exception.Create(ClassName + '.SaveHglToFile - FileName is empty');
  F := TFileStream.Create(FileName, fmCreate);
  try
    SaveHglToStream( F );
  finally
    F.Free;
  end;
end;

procedure TSynUniSyn.LoadHglFromStream(Stream: TStream);
var
  buf: PChar;
  BufSize: Integer;
  xml: TXMLParser;
begin
  buf := nil; // ����� ������ Warning �����������
  try
    BufSize := Stream.Size;
    GetMem(buf, BufSize);
    Stream.ReadBuffer(buf^, BufSize);
    xml := TXMLParser.Create;
    if xml.LoadFromBuffer(buf) then begin
      xml.StartScan;
      LoadHglFromXml(xml);
    end;
  finally
    FreeMem(buf);
  end;
  DefHighlightChange( Self );
end;

initialization
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynUniSyn);
{$ENDIF}
end.
