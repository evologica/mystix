{
Mystix
Copyright (C) 2005  Piotr Jura

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

You can contact with me by e-mail: pjura@o2.pl
}
unit uDocuments;

interface

uses
	SysUtils, Classes, Graphics, Controls, Forms, JvTabBar, SynEdit,
  SynEditKeyCmds, SynUniHighlighter, SynEditTypes, SynEditMiscClasses, Windows,
  uExSynEdit;

type
  TDocument = class
  private
    fEditor: TExSynEdit;
    fFileName: String;
    fHighlighter: TSynUniSyn;
    fSaved: Boolean;
    fTab: TJvTabBarItem;
    fType: String;
    fFunctionRegExp: String;
    procedure SetDocumentType(const Value: String);
    function GetModified: Boolean;
    procedure SetModified(const Value: Boolean);
    function GetCode: String;
    procedure SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
		procedure SynEditReplaceText(Sender: TObject; const ASearch, AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
    procedure SynEditChange(Sender: TObject);
  public
  	constructor Create;
    destructor Destroy; override;

    function CanPaste: Boolean;
    function CanRedo: Boolean;
    function CanSave: Boolean;
    function CanUndo: Boolean;
    function FindNext: Boolean;
    function FindText(Text: String; WholeWords, MatchCase, RegExp, SelOnly, FromCursor, DirUp: Boolean): Boolean;
    function ReplaceNext: Boolean;
    function ReplaceText(Text, ReplaceWith: String; WholeWords, MatchCase, RegExp, SelOnly, FromCursor, Prompt, DirUp, ReplaceAll: Boolean): Boolean;
    function SelAvail: Boolean;
    procedure Activate;
    function Close: Integer;
    procedure CollapseAll;
    procedure CollapseCurrent;
    procedure CollapseLevel(Level: Integer);
    procedure ColumnSelect;
    procedure Copy;
    procedure Cut;
    procedure Delete;
    procedure DeleteWord;
    procedure DeleteLine;
    procedure DeleteToEndOfWord;
    procedure DeleteToEndOfLine;
    procedure DeleteWordBack;
    procedure Indent;
    procedure Open(aFileName: String);
    procedure Paste;
    procedure Print;
    procedure ReadFromIni;
    procedure Redo;
    procedure Save;
    procedure SelectAll;
    procedure SelectWord;
    procedure SelectLine;
    procedure SetupOptions(var Options: TSynSearchOptions; WholeWords, MatchCase, RegExp, SelOnly, FromCursor, DirUp: Boolean);
    procedure UncollapseAll;
    procedure UncollapseLevel(Level: Integer);
    procedure Undo;
    procedure Unindent;
    procedure UpdateCaption;
    procedure UpdateType;
    procedure GoToLine(Line: Integer);
    procedure UpdateFunctionList;
    procedure UpperCase;
    procedure LowerCase;
    procedure ToggleCase;
    procedure Capitalize;

    property FileName: String read fFileName write fFileName;
    property Saved: Boolean read fSaved write fSaved;
    property DocumentType: String read fType write SetDocumentType;
    property Editor: TExSynEdit read fEditor;
    property Modified: Boolean read GetModified write SetModified;
    property Code: String read GetCode;
    property FunctionRegExp: String read fFunctionRegExp write fFunctionRegExp;
  end;

  TDocumentFactory = class
  private
    fDocuments: TList;
    fUntitledIndex: Integer;
    fLastSearchedForText: String;
    function GetDocument(Index: Integer): TDocument;
    function GetCount: Integer;
  public
  	constructor Create;
    destructor Destroy; override;

    function AddDocument: TDocument;
    function CanSaveAll: Boolean;
    function CloseAll: Boolean;
    procedure New;
    procedure Open(aFileName: String);
    procedure ReadAllFromIni;
    procedure RemoveDocument(aDocument: TDocument);
    procedure SaveAll;
    function IsSearchedForTheFirstTime(S: String): Boolean;

    property Documents[Index: Integer]: TDocument read GetDocument; default;
    property Count: Integer read GetCount;
  end;

var
	DocumentFactory: TDocumentFactory;
  Document: TDocument;

implementation

uses uMain, IniFiles, uUtils, uFunctionList, uConfirmReplace, uFind;

{ TDocument }

procedure TDocument.Activate;
begin
	Document := Self;
  fTab.Selected := True;
  fEditor.BringToFront;
  SynEditStatusChange(fEditor, [scAll]);

  try
    fEditor.SetFocus;
  except end;

  fEditor.OnChange(nil);

  if fType <> '' then
		MainForm.StatusBar.Panels[idDocTypePanel].Text := fType
  else
  	with MainForm do
    	StatusBar.Panels[idDocTypePanel].Text :=
      	StringReplace(ViewDocumentType0.Caption, '&', '', []);

  FunctionListForm.Clear;
end;

function TDocument.CanPaste: Boolean;
begin
	Result := fEditor.CanPaste;
end;

function TDocument.CanRedo: Boolean;
begin
	Result := fEditor.CanRedo;
end;

function TDocument.CanSave: Boolean;
begin
	Result := fEditor.Modified;
end;

function TDocument.CanUndo: Boolean;
begin
	Result := fEditor.CanUndo;
end;

procedure TDocument.Capitalize;
begin
  fEditor.ExecuteCommand(ecTitleCase, #0, nil);
end;

function TDocument.Close: Integer;
var
	i: Integer;
begin
	Result := IDNO;

  if Modified then
  	with Application do
    	case MessageBox( PChar( Format(sStrings[siAskSaveChanges], [fFileName]) ) , 'Confirm',
			MB_YESNOCANCEL or MB_ICONQUESTION) of
      	IDYES:
        	begin
          	Result := IDYES;
          	Save;
          end;
        IDCANCEL:
        	begin
          	Result := IDCANCEL;
          	Exit;
          end;
      end;

	if fSaved then
  begin
  	MRUFiles.Add(fFileName);
    MainForm.UpdateMRUFilesMenu;
  end;

  Document := nil;
  fEditor.Free;
  fTab.Free;
	DocumentFactory.RemoveDocument(Self);

  if DocumentFactory.Count = 0 then
  begin
  	for i := 0 to MainForm.StatusBar.Panels.Count - 1 do
    	MainForm.StatusBar.Panels[i].Text := '';

    FunctionListForm.Clear;
  end;
end;

procedure TDocument.CollapseAll;
begin
	fEditor.CollapseAll;
end;

procedure TDocument.CollapseCurrent;
begin
	fEditor.CollapseCurrent;
end;

procedure TDocument.CollapseLevel(Level: Integer);
begin
	fEditor.CollapseLevel(Level);
end;

procedure TDocument.ColumnSelect;
begin
	if fEditor.SelectionMode = smColumn then
		fEditor.SelectionMode := smNormal
  else
		fEditor.SelectionMode := smColumn;
end;

procedure TDocument.Copy;
begin
	fEditor.CommandProcessor(ecCopy, #0, nil);
end;

constructor TDocument.Create;
begin
	fSaved := False;
  fFileName := '';
  fType := '';
	fEditor := TExSynEdit.Create(nil);

  with fEditor do
  begin
  	Align := alClient;
  	Top := 49;
  	Gutter.AutoSize := True;
  	Gutter.DigitCount := 3;
    Gutter.LeftOffset := 0;
    Gutter.Font.Name := 'Tahoma';
    Gutter.Font.Size := 8;
  	WantTabs := True;
  	Highlighter := fHighlighter;
    OnChange := SynEditChange;
  	OnStatusChange := SynEditStatusChange;
  	OnReplaceText := SynEditReplaceText;
  	OnMouseDown := MouseDown;
  	OnMouseMove := MouseMove;
  	OnMouseUp := MouseUp;
    OnMButtonUp := MainForm.WmMButtonUp;
    OnKeyDown := MainForm.OnKeyDown;
  end;

  fHighlighter := TSynUniSyn.Create(nil);

  with MainForm do
  begin
    fEditor.Width := Width;
    fEditor.Height := Height;
    //fEditor.PopupMenu := mnuEditor;
  end;

  ReadFromIni;
  fEditor.Parent := MainForm;
	fTab := TJvTabBar(MainForm.tbDocuments).AddTab('');
  fTab.Data := Self;
end;

procedure TDocument.Cut;
begin
	fEditor.CommandProcessor(ecCut, #0, nil);
end;

procedure TDocument.Delete;
begin
	fEditor.CommandProcessor(ecDeleteChar, #0, nil);
end;

procedure TDocument.DeleteLine;
begin
	fEditor.CommandProcessor(ecDeleteLine, #0, nil);
end;

procedure TDocument.DeleteToEndOfLine;
begin
	fEditor.CommandProcessor(ecDeleteEOL, #0, nil);
end;

procedure TDocument.DeleteToEndOfWord;
begin
	fEditor.CommandProcessor(ecDeleteWord, #0, nil);
end;

procedure TDocument.DeleteWord;
var
	Left, Right, Len: Integer;
  Line: String;
  LeftDone, RightDone: Boolean;
  ptBefore, ptAfter: TBufferCoord;
begin
	Line := fEditor.LineText;
	Len := Length(Line);
  LeftDone := False;
  RightDone := False;
	fEditor.BeginUpdate;

	try
		if Len > 0 then
		begin
			Left := fEditor.CaretX;
			Right := fEditor.CaretX;

			repeat
				if (not LeftDone) and (Left - 1 > 0)
        and (Line[Left - 1] in TSynValidStringChars) then
					Dec(Left)
				else
					LeftDone := True;

				if (not RightDone) and (Right + 1 <= Len)
        and (Line[Right + 1] in TSynValidStringChars) then
					Inc(Right)
				else
					RightDone := True;
				
			until (LeftDone) and (RightDone);

			if Right - Left > 0 then
			begin
      	Inc(Right);
				ptBefore.Char := Left;
        ptBefore.Line := fEditor.CaretY;
        ptAfter.Char := Right;
        ptAfter.Line := fEditor.CaretY;
        fEditor.SetCaretAndSelection(ptBefore, ptBefore, ptAfter);
				fEditor.CommandProcessor(ecDeleteChar, #0, nil);
			end;
		end;
	finally
		fEditor.EndUpdate;
	end;
end;

procedure TDocument.DeleteWordBack;
begin
	fEditor.CommandProcessor(ecDeleteLastWord, #0, nil);
end;

destructor TDocument.Destroy;
begin
	fHighlighter.Free;
  inherited;
end;

function TDocument.FindNext: Boolean;
var
	Options: TSynSearchOptions;
begin
  SetupOptions(Options, frWholeWords, frMatchCase, frRegExp, frSelOnly, frFromCursor, frDirUp);
	Exclude(Options, ssoEntireScope);
	Result := fEditor.SearchReplace(frFindText, '', Options) <> 0;
end;

function TDocument.FindText(Text: String; WholeWords, MatchCase, RegExp,
	SelOnly, FromCursor, DirUp: Boolean): Boolean;
var
	Options: TSynSearchOptions;
begin
	SetupOptions(Options, WholeWords, MatchCase, RegExp, SelOnly, FromCursor, DirUp);
	Result := fEditor.SearchReplace(Text, '', Options) <> 0;
end;

function TDocument.GetCode: String;
begin
	Result := fEditor.Text;
end;

function TDocument.GetModified: Boolean;
begin
	Result := fEditor.Modified;
end;

procedure TDocument.GoToLine(Line: Integer);
begin
  fEditor.GotoLineAndCenter(Line);
end;

procedure TDocument.Indent;
begin
	fEditor.CommandProcessor(ecBlockIndent, #0, nil);
end;

procedure TDocument.LowerCase;
begin
  if SelAvail then
    fEditor.ExecuteCommand(ecLowerCaseBlock, #0, nil)
  else
    fEditor.ExecuteCommand(ecLowerCase, #0, nil);
end;

procedure TDocument.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	MainForm.OnMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TDocument.MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	MainForm.OnMouseMove(Sender, Shift, X, Y);
end;

procedure TDocument.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	MainForm.OnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TDocument.Open(aFileName: String);
begin
	fSaved := True;
	fFileName := aFileName;
  fEditor.Lines.LoadFromFile(aFileName);
  UpdateCaption;
  UpdateType;
end;

procedure TDocument.Paste;
begin
	fEditor.CommandProcessor(ecPaste, #0, nil);
end;

procedure TDocument.Print;
begin
	with MainForm.SynEditPrint do
	begin
		SynEdit := fEditor;
		Highlighter := fEditor.Highlighter;
		TabWidth := fEditor.TabWidth;
	end;
end;

procedure TDocument.ReadFromIni;
var
	Options: TSynEditorOptions;
begin
	with Settings do
  begin
  	if ReadBool('Editor', 'HighlightActiveLine', True) then
    	fEditor.ActiveLineColor := ReadColor('Editor', 'ActiveLineColor', clYellow)
    else
			fEditor.ActiveLineColor := clNone;

  	fEditor.CodeFolding.Enabled := ReadBool('Editor', 'CodeFolding', True);
    fEditor.CodeFolding.IndentGuides := ReadBool('Editor', 'ShowIndentGuides',
    	True);
    fEditor.CodeFolding.FolderBarColor := ReadColor('Editor',
    	'FoldingBarColor', clDefault);
    fEditor.CodeFolding.FolderBarLinesColor := ReadColor('Editor',
    	'FoldingBarLinesColor', clDefault);
    fEditor.CodeFolding.CollapsingMarkStyle := TSynCollapsingMarkStyle(ReadInteger('Editor',
    	'FoldingButtonStyle', 0));
    fEditor.ExtraLineSpacing := ReadInteger('Editor', 'ExtraLineSpacing', 0);
  	fEditor.Font.Name := ReadString('Editor', 'FontName', 'Courier New');
    fEditor.Font.Size := ReadInteger('Editor', 'FontSize', 10);
  	fEditor.Gutter.Visible := ReadBool('Editor', 'ShowGutter', True);
    fEditor.Gutter.ShowLineNumbers := ReadBool('Editor', 'ShowLineNumbers', True);

    if ReadBool('Editor', 'ShowRightMargin', True) then
    	fEditor.RightEdge := ReadInteger('Editor', 'RightMarginPosition', 80)
    else
    	fEditor.RightEdge := 0;

    fEditor.WordWrap := ReadBool('Editor', 'WordWrap', True);
    fEditor.InsertCaret := TSynEditCaretType(ReadInteger('Editor', 'InsertCaret', 0));
    fEditor.InsertMode := ReadBool('Editor', 'InsertMode', True);
    fEditor.Gutter.LeadingZeros := ReadBool('Editor', 'ShowLeadingZeros', False);
    fEditor.MaxUndo := ReadInteger('Editor', 'MaxUndo', 1024);
    fEditor.OverwriteCaret := TSynEditCaretType(ReadInteger('Editor', 'OverwriteCaret', 0));
    fEditor.Gutter.ZeroStart := ReadBool('Editor', 'ZeroStart', False);
    fEditor.TabWidth := ReadInteger('Editor', 'TabWidth', 4);

    if ReadColor('Editor', 'GutterColor', clDefault) <> clDefault then
    	fEditor.Gutter.Color := ReadColor('Editor', 'GutterColor', clBtnFace)
    else
    	fEditor.Gutter.Color := clBtnFace;

    Options := [];

    if ReadBool('Editor', 'AutoIndent', True) then
    	Include(Options, eoAutoIndent);

    if ReadBool('Editor', 'GroupUndo', True) then
    	Include(Options, eoGroupUndo);

    if ReadBool('Editor', 'ScrollPastEOF', False) then
    	Include(Options, eoScrollPastEof);

    if ReadBool('Editor', 'ScrollPastEOL', False) then
    	Include(Options, eoScrollPastEol);

    if ReadBool('Editor', 'ShowSpecialChars', False) then
    	Include(Options, eoShowSpecialChars);

    if ReadBool('Editor', 'TabsToSpaces', False) then
    	Include(Options, eoTabsToSpaces);

    if ReadBool('Editor', 'TrimTrailingSpaces', True) then
    	Include(Options, eoTrimTrailingSpaces);

    fEditor.Options := Options;
  end;
end;

procedure TDocument.Redo;
begin
	fEditor.CommandProcessor(ecRedo, #0, nil);
end;

function TDocument.ReplaceNext: Boolean;
var
	Options: TSynSearchOptions;
begin
  SetupOptions(Options, frWholeWords, frMatchCase, frRegExp, frSelOnly, frFromCursor, frDirUp);
	Exclude(Options, ssoEntireScope);
	Result := fEditor.SearchReplace(frFindText, frReplaceText, Options) <> 0;
end;

function TDocument.ReplaceText(Text, ReplaceWith: String; WholeWords, MatchCase,
	RegExp, SelOnly, FromCursor, Prompt, DirUp, ReplaceAll: Boolean): Boolean;
var
	Options: TSynSearchOptions;
begin
	SetupOptions(Options, WholeWords, MatchCase, RegExp, SelOnly, FromCursor, DirUp);
  Include(Options, ssoReplace);

  if Prompt then
  	Include(Options, ssoPrompt);

  if ReplaceAll then
  begin
  	Include(Options, ssoReplaceAll);
    DocumentFactory.fLastSearchedForText := '';
  end;

  Result := fEditor.SearchReplace(Text, ReplaceWith, Options) <> 0;
end;

procedure TDocument.Save;
begin
  if fSaved then
  begin
	  fSaved := True;
    fEditor.Modified := False;
    fEditor.GetUncollapsedStrings.SaveToFile(fFileName);
    UpdateCaption;
    UpdateType;
  end
  else
    MainForm.SaveAs(Self);
end;

function TDocument.SelAvail: Boolean;
begin
	Result := fEditor.SelAvail;
end;

procedure TDocument.SelectAll;
begin
	fEditor.CommandProcessor(ecSelectAll, #0, nil);
end;

procedure TDocument.SelectLine;
begin
	fEditor.BeginUpdate;

  try
  	fEditor.CommandProcessor(ecLineStart, #0, nil);
    fEditor.CommandProcessor(ecSelLineEnd, #0, nil);
  finally
  	fEditor.EndUpdate;
  end;
end;

procedure TDocument.SelectWord;
var
	Left, Right, Len: Integer;
  Line: String;
  LeftDone, RightDone: Boolean;
  ptBefore, ptAfter: TBufferCoord;
begin
	Line := fEditor.LineText;
	Len := Length(Line);
  LeftDone := False;
  RightDone := False;
	fEditor.BeginUpdate;

	try
		if Len > 0 then
		begin
			Left := fEditor.CaretX;
			Right := fEditor.CaretX;

			repeat
				if (not LeftDone) and (Left - 1 > 0)
        and (Line[Left - 1] in TSynValidStringChars) then
					Dec(Left)
				else
					LeftDone := True;

				if (not RightDone) and (Right + 1 <= Len)
        and (Line[Right + 1] in TSynValidStringChars) then
					Inc(Right)
				else
					RightDone := True;
				
			until (LeftDone) and (RightDone);

			if Right - Left > 0 then
			begin
      	Inc(Right);
				ptBefore.Char := Left;
        ptBefore.Line := fEditor.CaretY;
        ptAfter.Char := Right;
        ptAfter.Line := fEditor.CaretY;
        fEditor.SetCaretAndSelection(ptBefore, ptBefore, ptAfter);
			end;
		end;
	finally
		fEditor.EndUpdate;
	end;
end;

procedure TDocument.SetDocumentType(const Value: String);
var
	TypeFile: String;
  DocumentTypeIndex: Integer;
begin
	fType := Value;

  if fType <> '' then
  begin
  	DocumentTypeIndex := DocTypes.IndexOf(Value) + 1;
  	TypeFile := Settings.ReadString('DocumentTypes', 'DocumentTypeSyntaxFile'
    	+ IntToStr( DocumentTypeIndex ), '');

    if FileExists(AppPath + 'DocumentTypes\' + TypeFile) then
    begin
  		TSynUniSyn(fHighlighter).LoadHglFromFile(AppPath + 'DocumentTypes\' + TypeFile);
			fEditor.Highlighter := fHighlighter;
    end;

    fFunctionRegExp := Settings.ReadString('DocumentTypes',
			'DocumentTypeFunctionRegExp' + IntToStr( DocumentTypeIndex ), '');
  end
  else
  	fEditor.Highlighter := nil;

  fEditor.InitCodeFolding;
  Activate;
end;

procedure TDocument.SetModified(const Value: Boolean);
begin
	fEditor.Modified := Value;
end;

procedure TDocument.SetupOptions(var Options: TSynSearchOptions;
  WholeWords, MatchCase, RegExp, SelOnly, FromCursor, DirUp: Boolean);
begin
	Options := [];

	if MatchCase then
		Include(Options, ssoMatchCase);

	if WholeWords then
		Include(Options, ssoWholeWord);

	if DirUp then
		Include(Options, ssoBackwards);

	if SelOnly then
		Include(Options, ssoSelectedOnly);

	if not FromCursor then
		Include(Options, ssoEntireScope);

  if not RegExp then
		fEditor.SearchEngine := MainForm.Search
	else
		fEditor.SearchEngine := MainForm.RegexSearch;
end;

procedure TDocument.SynEditChange(Sender: TObject);
var
  Size : Double;
  Aux  : String;
begin // Luciano
  Size := Length(fEditor.Text) / 1024;

  if Size > 0 then
  begin
    Aux := 'KB';

    if Size > 999 then
    begin
      Aux := 'MB';
      Size := Size / 1024;
    end;

    MainForm.StatusBar.Panels[idDocSizePanel].Text := FormatFloat('0.00',Size) + ' ' + Aux;
  end
  else
    MainForm.StatusBar.Panels[idDocSizePanel].Text := '';
end;

procedure TDocument.SynEditReplaceText(Sender: TObject; const ASearch,
  AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
var
  P: TPoint;
  C: TDisplayCoord;
begin
	if frPrompt then
  begin
		C.Row := fEditor.LineToRow(Line);
  	C.Column := Column;
  	P := fEditor.RowColumnToPixels(C);
  	Inc(P.Y, fEditor.LineHeight);

  	if P.X + 337 > fEditor.Width then
  		P.X := P.X - ((P.X + 337) - fEditor.Width);

  	if P.Y + 125 > fEditor.Height then
  		P.Y := P.Y - (125 + fEditor.LineHeight);

		P := fEditor.ClientToScreen(P);

  	case TConfirmReplaceDialog.Create(MainForm).Execute(P.X, P.Y,
    ASearch, AReplace) of
  		mrCancel: Action := raCancel;
  		mrIgnore: Action := raSkip;
  		mrYes: Action := raReplace;
  		mrAll: Action := raReplaceAll;
  	end;
  end
  else
  	Action := raReplace;
end;

procedure TDocument.SynEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin // Luciano
	if Changes * [scAll, scCaretX, scCaretY] <> [] then
  begin
  	if  (fEditor.CaretX > 0) and (fEditor.CaretY > 0) then
    	with fEditor do
  			MainForm.StatusBar.Panels[idXYPanel].Text := Format('%6d:%3d',
        	[GetRealLineNumber(CaretY), CaretX])
    else
      MainForm.StatusBar.Panels[idXYPanel].Text := '';
  end;

  if Changes * [scAll, scInsertMode, scReadOnly] <> [] then
  begin
    if fEditor.ReadOnly then
      MainForm.StatusBar.Panels[idInsertModePanel].Text := sStrings[siReadOnly]
    else
    begin
    	if fEditor.InsertMode then
      	MainForm.StatusBar.Panels[idInsertModePanel].Text := sStrings[siInsertMode]
      else
      	MainForm.StatusBar.Panels[idInsertModePanel].Text := sStrings[siOverwriteMode]
    end;
  end;

  if Changes * [scAll, scModified] <> [] then
  begin
  	fTab.Modified := fEditor.Modified;

    if fEditor.Modified then
    	MainForm.StatusBar.Panels[idModifiedPanel].Text := sStrings[siModified]
    else
			MainForm.StatusBar.Panels[idModifiedPanel].Text := '';
  end;

  if scSelection in Changes then
  begin
  	if (fEditor.SelAvail) then
			MainForm.StatusMsg(Format(sStrings[siLinesSelected],
      [Abs(fEditor.BlockBegin.Line - fEditor.BlockEnd.Line) + 1]))
    else
    	MainForm.StatusMsg('');

    if FindDialog <> nil then
			FindDialog.chkSelOnly.Enabled := fEditor.SelAvail;
  end;
end;

procedure TDocument.ToggleCase;
begin
  if SelAvail then
    fEditor.ExecuteCommand(ecToggleCaseBlock, #0, nil)
  else
    fEditor.ExecuteCommand(ecToggleCase, #0, nil)
end;

procedure TDocument.UncollapseAll;
begin
	fEditor.UncollapseAll;
end;

procedure TDocument.UncollapseLevel(Level: Integer);
begin
	fEditor.UncollapseLevel(Level);
end;

procedure TDocument.Undo;
begin
	fEditor.CommandProcessor(ecUndo, #0, nil);
end;

procedure TDocument.Unindent;
begin
	fEditor.CommandProcessor(ecBlockUnindent, #0, nil);
end;

procedure TDocument.UpdateCaption;
begin
	if fSaved then
  	fTab.Caption := ExtractFileName(fFileName)
  else
  	fTab.Caption := fFileName;
end;

procedure TDocument.UpdateFunctionList;
begin
	FunctionListForm.RegExp := fFunctionRegExp;
	FunctionListForm.UpdateFuncList;
end;

procedure TDocument.UpdateType;
var
	fNewType: String;
begin
	fNewType := DocumentTypeForExt( SysUtils.UpperCase( ExtractFileExt(fFileName) ) );

  if fNewType <> fType then
		DocumentType := fNewType;
end;

procedure TDocument.UpperCase;
begin
  if SelAvail then
    fEditor.ExecuteCommand(ecUpperCaseBlock, #0, nil)
  else
    fEditor.ExecuteCommand(ecUpperCase, #0, nil);
end;

{ TDocumentFactory }

function TDocumentFactory.AddDocument: TDocument;
begin
	Result := TDocument.Create;
  fDocuments.Add(Result);
  Result.Activate;
end;

function TDocumentFactory.CanSaveAll: Boolean;
var
	i: Integer;
begin
	Result := False;

  for i := 0 to Count - 1 do
  	if Documents[i].Modified then
    begin
    	Result := True;
      Break;
    end;
end;

function TDocumentFactory.CloseAll: Boolean;
var
	i: Integer;
begin
	Result := True;

	for i := Count - 1 downto 0 do
		if Documents[i].Close = IDCANCEL then
    begin
    	Result := False;
      Exit;
    end;
end;

constructor TDocumentFactory.Create;
begin
	fDocuments := TList.Create;
  fUntitledIndex := 1;
end;

destructor TDocumentFactory.Destroy;
begin
	fDocuments.Free;
  inherited;
end;

function TDocumentFactory.GetDocument(Index: Integer): TDocument;
begin
	Result := TDocument( fDocuments[Index] );
end;

function TDocumentFactory.IsSearchedForTheFirstTime(S: String): Boolean;
begin
	Result := fLastSearchedForText <> S;

  if Result = True then
  	fLastSearchedForText := S;
end;

procedure TDocumentFactory.New;
var
	DefDocType: String;
begin
	with AddDocument do
  	FileName := Format(sStrings[siUntitled], [fUntitledIndex]);

  Document.UpdateCaption;
  Inc(fUntitledIndex);

  DefDocType := Settings.ReadString('General', 'DefaultDocumentType', '');

  if DefDocType <> '' then
  	Document.DocumentType := DefDocType;
end;

procedure TDocumentFactory.Open(aFileName: String);
var
	i: Integer;
begin
	// Check if this file isn't already open
  for i := 0 to Count - 1 do
  	if SameText(Documents[i].FileName, aFileName) then
    begin
    	Documents[i].Activate;
      Exit;
    end;

  with AddDocument do
  	Open(aFileName);
end;

procedure TDocumentFactory.ReadAllFromIni;
var
	i: Integer;
begin
	for i := 0 to Count - 1 do
  	Documents[i].ReadFromIni;
end;

procedure TDocumentFactory.RemoveDocument(aDocument: TDocument);
begin
	fDocuments.Remove(aDocument);
end;

procedure TDocumentFactory.SaveAll;
var
	i: Integer;
begin
	for i := 0 to Count - 1 do
  	Documents[i].Save;
end;

function TDocumentFactory.GetCount: Integer;
begin
	Result := fDocuments.Count;
end;

initialization
	DocumentFactory := TDocumentFactory.Create;

finalization
	DocumentFactory := nil;

end.          
