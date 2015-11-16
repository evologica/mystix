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
unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvDockControlForm, JvDockVIDStyle,
  JvComponent, JvMouseGesture, SynEditPrint, JvTabBar, SynEditRegexSearch,
  SynEditMiscClasses, SynEditSearch, Menus, ImgList, ActnList,
  ComCtrls, ToolWin, uMyIniFiles, uMRU, uUtils, SynEditTypes, uDocuments,
  SynEdit, JvDockTree, JvComponentBase;

type
  TMainForm = class(TForm)
    actlMain: TActionList;
    mnuMain: TMainMenu;
    StatusBar: TStatusBar;
    tbMain: TToolBar;
    tbDocuments: TJvTabBar;
    miFile: TMenuItem;
    miEdit: TMenuItem;
    miSearch: TMenuItem;
    miView: TMenuItem;
    miHelp: TMenuItem;
    ToolButton1: TToolButton;
    FileNew: TAction;
    miNew: TMenuItem;
    FileOpen: TAction;
    FileSave: TAction;
    FileSaveAs: TAction;
    FileSaveAll: TAction;
    FileClose: TAction;
    FileCloseAll: TAction;
    FilePrint: TAction;
    FileExit: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    FileOpen1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    SaveAll1: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    CloseAll1: TMenuItem;
    N3: TMenuItem;
    Print1: TMenuItem;
    Exit1: TMenuItem;
    imglMain: TImageList;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    EditUndo: TAction;
    EditRedo: TAction;
    EditCut: TAction;
    EditPaste: TAction;
    EditCopy: TAction;
    EditDelete: TAction;
    EditSelectAll: TAction;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N5: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    SelectAll1: TMenuItem;
    EditIndent: TAction;
    EditUnindent: TAction;
    N6: TMenuItem;
    EditIndent1: TMenuItem;
    EditUnindent1: TMenuItem;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    SearchFind: TAction;
    SearchFindNext: TAction;
    SearchReplace: TAction;
    SearchGoToLine: TAction;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton26: TToolButton;
    SearchFind1: TMenuItem;
    SearchReplace1: TMenuItem;
    SearchFindNext1: TMenuItem;
    SearchGoToLine1: TMenuItem;
    HelpTopics: TAction;
    ToolButton25: TToolButton;
    ToolButton27: TToolButton;
    New1: TMenuItem;
    N7: TMenuItem;
    ViewCollapseAll: TAction;
    ViewUncollapseAll: TAction;
    oolbar1: TMenuItem;
    StatusBar1: TMenuItem;
    N8: TMenuItem;
    CollapseAll1: TMenuItem;
    UncollapseAll1: TMenuItem;
    miViewCollapseLevel: TMenuItem;
    miViewUncollapseLevel: TMenuItem;
    tbtnUncollapse: TToolButton;
    tbtnCollapse: TToolButton;
    ToolButton30: TToolButton;
    N9: TMenuItem;
    LineNumbers1: TMenuItem;
    ShowGutter1: TMenuItem;
    ShowIndentGuides1: TMenuItem;
    WordWrap1: TMenuItem;
    ShowRightMargin1: TMenuItem;
    miViewFont: TMenuItem;
    miEditorFont1: TMenuItem;
    miEditorFont2: TMenuItem;
    miEditorFont3: TMenuItem;
    miEditorFont4: TMenuItem;
    miEditorFont5: TMenuItem;
    miEditorFontSep: TMenuItem;
    ViewFont: TAction;
    Font2: TMenuItem;
    ViewToolbar: TAction;
    ViewStatusBar: TAction;
    ViewShowGutter: TAction;
    ViewShowLineNumbers: TAction;
    ViewShowRightMargin: TAction;
    ViewWordWrap: TAction;
    ViewShowIndentGuides: TAction;
    ViewSettings: TAction;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    N11: TMenuItem;
    Settings1: TMenuItem;
    HelpAbout: TAction;
    N12: TMenuItem;
    About1: TMenuItem;
    ViewCollapseLevel0: TAction;
    ViewCollapseLevel1: TAction;
    ViewCollapseLevel2: TAction;
    ViewCollapseLevel3: TAction;
    ViewCollapseLevel4: TAction;
    ViewCollapseLevel5: TAction;
    ViewCollapseLevel6: TAction;
    ViewCollapseLevel7: TAction;
    ViewCollapseLevel8: TAction;
    ViewCollapseLevel9: TAction;
    CollapseLevel01: TMenuItem;
    CollapseLevel11: TMenuItem;
    CollapseLevel21: TMenuItem;
    CollapseLevel31: TMenuItem;
    CollapseLevel41: TMenuItem;
    CollapseLevel51: TMenuItem;
    CollapseLevel61: TMenuItem;
    CollapseLevel71: TMenuItem;
    CollapseLevel81: TMenuItem;
    CollapseLevel91: TMenuItem;
    mnuCollapse: TPopupMenu;
    mnuUncollapse: TPopupMenu;
    CollapseAll2: TMenuItem;
    CollapseLevel02: TMenuItem;
    CollapseLevel12: TMenuItem;
    N13: TMenuItem;
    CollapseLevel22: TMenuItem;
    CollapseLevel32: TMenuItem;
    CollapseLevel42: TMenuItem;
    CollapseLevel52: TMenuItem;
    CollapseLevel62: TMenuItem;
    CollapseLevel72: TMenuItem;
    CollapseLevel82: TMenuItem;
    CollapseLevel92: TMenuItem;
    ViewUncollapseLevel0: TAction;
    ViewUncollapseLevel1: TAction;
    ViewUncollapseLevel2: TAction;
    ViewUncollapseLevel3: TAction;
    ViewUncollapseLevel4: TAction;
    ViewUncollapseLevel5: TAction;
    ViewUncollapseLevel6: TAction;
    ViewUncollapseLevel7: TAction;
    ViewUncollapseLevel8: TAction;
    ViewUncollapseLevel9: TAction;
    UncollapseLevel01: TMenuItem;
    UncollapseLevel11: TMenuItem;
    UncollapseLevel21: TMenuItem;
    UncollapseLevel31: TMenuItem;
    UncollapseLevel41: TMenuItem;
    UncollapseLevel51: TMenuItem;
    UncollapseLevel61: TMenuItem;
    UncollapseLevel71: TMenuItem;
    UncollapseLevel81: TMenuItem;
    UncollapseLevel91: TMenuItem;
    UncollapseLevel02: TMenuItem;
    UncollapseLevel12: TMenuItem;
    UncollapseLevel22: TMenuItem;
    UncollapseLevel32: TMenuItem;
    UncollapseLevel42: TMenuItem;
    UncollapseLevel52: TMenuItem;
    UncollapseLevel62: TMenuItem;
    UncollapseLevel72: TMenuItem;
    UncollapseLevel82: TMenuItem;
    UncollapseLevel92: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    miViewDocumentType: TMenuItem;
    miViewDocumentTypeMore: TMenuItem;
    N16: TMenuItem;
    DocumentType11: TMenuItem;
    dlgFont: TFontDialog;
    mnuEditor: TPopupMenu;
    Close2: TMenuItem;
    N17: TMenuItem;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Delete2: TMenuItem;
    SelectAll2: TMenuItem;
    N18: TMenuItem;
    Indent1: TMenuItem;
    Unindent1: TMenuItem;
    Open1: TMenuItem;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ViewDocumentType1: TAction;
    ViewDocumentType2: TAction;
    ViewDocumentType3: TAction;
    ViewDocumentType4: TAction;
    ViewDocumentType5: TAction;
    ViewDocumentType6: TAction;
    ViewDocumentType7: TAction;
    ViewDocumentType8: TAction;
    ViewDocumentType9: TAction;
    ViewDocumentType10: TAction;
    DocumentType21: TMenuItem;
    DocumentType31: TMenuItem;
    DocumentType41: TMenuItem;
    DocumentType51: TMenuItem;
    DocumentType61: TMenuItem;
    DocumentType71: TMenuItem;
    DocumentType81: TMenuItem;
    DocumentType91: TMenuItem;
    DocumentType101: TMenuItem;
    ViewDocumentType0: TAction;
    miViewDocumentTypeNone: TMenuItem;
    N10: TMenuItem;
    miFileRecentFiles: TMenuItem;
    Search: TSynEditSearch;
    RegexSearch: TSynEditRegexSearch;
    ViewShowSpecialCharacters: TAction;
    ShowSpecialCharacters1: TMenuItem;
    SearchReplaceNext: TAction;
    ReplaceNext1: TMenuItem;
    N4: TMenuItem;
    tmrStatusBar: TTimer;
    FileWorkspaceOpen: TAction;
    FileWorkspaceSave: TAction;
    FileWorkspaceSaveAs: TAction;
    FileWorkspaceClose: TAction;
    N19: TMenuItem;
    miFileWorkspace: TMenuItem;
    Open2: TMenuItem;
    Save2: TMenuItem;
    SaveAs2: TMenuItem;
    Close3: TMenuItem;
    ViewCollapseCurrent: TAction;
    N20: TMenuItem;
    CollapseCurrent1: TMenuItem;
    CollapseCurrent2: TMenuItem;
    miViewLanguage: TMenuItem;
    N21: TMenuItem;
    FunctionList1: TMenuItem;
    ViewFunctionList: TAction;
    EditDeleteWord: TAction;
    miEditDeleteMore: TMenuItem;
    DeleteWord1: TMenuItem;
    EditDeleteLine: TAction;
    EditDeleteToEndOfWord: TAction;
    EditDeleteToEndOfLine: TAction;
    EditDeleteWordBack: TAction;
    DeleteLine1: TMenuItem;
    DeletetoEndofWord1: TMenuItem;
    DeletetoEndofLine1: TMenuItem;
    DeleteWordBack1: TMenuItem;
    EditSelectWord: TAction;
    EditSelectLine: TAction;
    EditColumnSelect: TAction;
    miEditSelectMore: TMenuItem;
    SelectWord1: TMenuItem;
    SelectLine1: TMenuItem;
    ColumnSelect1: TMenuItem;
    ViewOutput: TAction;
    Output1: TMenuItem;
    JvModernTabBarPainter: TJvModernTabBarPainter;
    SynEditPrint: TSynEditPrint;
    dlgPrint: TPrintDialog;
    JvMouseGesture: TJvMouseGesture;
    tmrDelayClose: TTimer;
    JvDockServer: TJvDockServer;
    JvDockVIDStyle1: TJvDockVIDStyle;
    SearchFunctionList: TAction;
    N22: TMenuItem;
    FunctionList2: TMenuItem;
    miEditChangeCase: TMenuItem;
    EditChangeCaseUpper: TAction;
    EditChangeCaseLower: TAction;
    EditChangeCaseToggle: TAction;
    EditChangeCaseCapitalize: TAction;
    UpperCase1: TMenuItem;
    LowerCase1: TMenuItem;
    oggleCase1: TMenuItem;
    Capitalize1: TMenuItem;
    FileMRUClear: TAction;
    FileWorkspaceMRUClear: TAction;
    FileMRUOpenAll: TAction;
    procedure FileNewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileOpenExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure FileSaveAsExecute(Sender: TObject);
    procedure FileSaveAllExecute(Sender: TObject);
    procedure FileCloseExecute(Sender: TObject);
    procedure FileCloseAllExecute(Sender: TObject);
    procedure FilePrintExecute(Sender: TObject);
    procedure FileExitExecute(Sender: TObject);
    procedure EditUndoExecute(Sender: TObject);
    procedure EditRedoExecute(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure EditDeleteExecute(Sender: TObject);
    procedure EditSelectAllExecute(Sender: TObject);
    procedure EditIndentExecute(Sender: TObject);
    procedure EditUnindentExecute(Sender: TObject);
    procedure tbDocumentsTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure tbDocumentsTabClosed(Sender: TObject; Item: TJvTabBarItem);
    procedure FileSaveUpdate(Sender: TObject);
    procedure FileSaveAllUpdate(Sender: TObject);
    procedure EditUndoUpdate(Sender: TObject);
    procedure EditRedoUpdate(Sender: TObject);
    procedure SelAvailUpdate(Sender: TObject);
    procedure EditCopyUpdate(Sender: TObject);
    procedure EditPasteUpdate(Sender: TObject);
    procedure AnyDocumentOpenUpdate(Sender: TObject);
    procedure ViewToolbarExecute(Sender: TObject);
    procedure ViewStatusBarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ViewShowGutterExecute(Sender: TObject);
    procedure ViewShowLineNumbersExecute(Sender: TObject);
    procedure ViewShowRightMarginExecute(Sender: TObject);
    procedure ViewWordWrapExecute(Sender: TObject);
    procedure ViewFontExecute(Sender: TObject);
    procedure ViewShowIndentGuidesExecute(Sender: TObject);
    procedure CodeFoldingUpdate(Sender: TObject);
    procedure miEditorFont1Click(Sender: TObject);
    procedure ViewSettingsExecute(Sender: TObject);
    procedure ViewDocumentType1Execute(Sender: TObject);
    procedure miViewDocumentTypeClick(Sender: TObject);
    procedure ViewDocumentType0Execute(Sender: TObject);
    procedure miViewDocumentTypeMoreClick(Sender: TObject);
    procedure ViewDocumentType0Update(Sender: TObject);
    procedure DocumentTypeMoreClick(Sender: TObject);
    procedure RecentFilesClick(Sender: TObject);
    procedure ViewCollapseAllExecute(Sender: TObject);
    procedure ViewUncollapseAllExecute(Sender: TObject);
    procedure ViewCollapseLevel0Execute(Sender: TObject);
    procedure ViewUncollapseLevel0Execute(Sender: TObject);
    procedure SearchFindExecute(Sender: TObject);
    procedure SearchFindNextExecute(Sender: TObject);
    procedure SearchReplaceExecute(Sender: TObject);
    procedure SearchGoToLineExecute(Sender: TObject);
    procedure HelpTopicsExecute(Sender: TObject);
    procedure HelpAboutExecute(Sender: TObject);
    procedure ViewShowSpecialCharactersExecute(Sender: TObject);
    procedure SearchReplaceNextExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure tmrStatusBarTimer(Sender: TObject);
    procedure FileWorkspaceOpenExecute(Sender: TObject);
    procedure FileWorkspaceSaveExecute(Sender: TObject);
    procedure FileWorkspaceSaveAsExecute(Sender: TObject);
    procedure FileWorkspaceCloseExecute(Sender: TObject);
    procedure FileWorkspaceSaveUpdate(Sender: TObject);
    procedure RecentWorkspacesClick(Sender: TObject);
    procedure ViewCollapseCurrentExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miViewLanguageClick(Sender: TObject);
    procedure ViewFunctionListExecute(Sender: TObject);
    procedure ViewOutputExecute(Sender: TObject);
    procedure ViewFunctionListUpdate(Sender: TObject);
    procedure ViewOutputUpdate(Sender: TObject);
    procedure EditDeleteWordExecute(Sender: TObject);
    procedure EditDeleteLineExecute(Sender: TObject);
    procedure EditDeleteToEndOfWordExecute(Sender: TObject);
    procedure EditDeleteToEndOfLineExecute(Sender: TObject);
    procedure EditDeleteWordBackExecute(Sender: TObject);
    procedure EditSelectWordExecute(Sender: TObject);
    procedure EditSelectLineExecute(Sender: TObject);
    procedure EditColumnSelectExecute(Sender: TObject);
    procedure EditColumnSelectUpdate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvMouseGestureMouseGestureDown(Sender: TObject);
    procedure JvMouseGestureMouseGestureLeft(Sender: TObject);
    procedure JvMouseGestureMouseGestureRight(Sender: TObject);
    procedure JvMouseGestureMouseGestureUp(Sender: TObject);
    procedure tmrDelayCloseTimer(Sender: TObject);
    procedure SearchFunctionListExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditChangeCaseUpperExecute(Sender: TObject);
    procedure EditChangeCaseLowerExecute(Sender: TObject);
    procedure EditChangeCaseToggleExecute(Sender: TObject);
    procedure EditChangeCaseCapitalizeExecute(Sender: TObject);
    procedure FileMRUClearExecute(Sender: TObject);
    procedure FileWorkspaceMRUClearExecute(Sender: TObject);
    procedure FileMRUOpenAllExecute(Sender: TObject);
  private
    { Private declarations }
    fStatusBarColor: TColor;
    fStatusBarTextColor: TColor;
    fWorkspaceFile: String;
    fWorkspaceModified: Boolean;
    procedure FindReplaceForm(Replace: Boolean);
    procedure SetupDialogsFilter;
    procedure OpenWorkspace(FileName: String);
    procedure OnIdle(Sender: TObject; var Done: Boolean);
    procedure ReadLanguageData;
    procedure UpdateLanguageMenu;
    procedure LanguagesClick(Sender: TObject);
    procedure UpdateDynamicMenus;
    procedure UpdateFontMenu;
    procedure ReadSettings(FirstTime: Boolean = False);
    procedure UpdateDocumentTypeMenu;
    procedure WMOpenFile(var Message: TMessage); message WM_OPENFILE;
  public
    { Public declarations }
    procedure StatusMsg(Msg: String; BackColor: TColor = -1;
    	TextColor: TColor = -1; TimeInterval: Integer = -1;
      DoBeep: Boolean = False);
    procedure UpdateMRUFilesMenu;
    procedure UpdateMRUWorkspacesMenu;
    procedure WmMButtonUp(var Message: TMessage); message WM_MBUTTONUP;
    procedure SaveAs(aDocument: TDocument = nil);
  end;

function DocumentTypeForExt(Ext: String): String;
function GetDocumentTypeIndex(aType: String): Integer;

var
  MainForm: TMainForm;
  Settings: TMyIniFile;
  ActiveLanguage: String;
  DocTypes, CommonDocTypes, Languages: TStringList;
  MRUFiles, MRUFindText, MRUReplaceText, MRUWorkspaces: TMRUList;
  frFindText, frReplaceText: String;
  frWholeWords, frMatchCase, frRegExp, frFromCursor, frPrompt,
  frInAll, frDirUp, frSelOnly: Boolean;

const
  idXYPanel = 0; // Luciano
  idModifiedPanel = 1;
  idInsertModePanel = 2;
  idCapsPanel = 3;
  idNumPanel = 4;
  idScrollPanel = 5;
  idDocTypePanel = 6;
  idDocSizePanel = 7;
  idMsgPanel = 8;

implementation

uses uFind, uAbout, uReplace, uGoToLine, uProject, uFunctionList,
	uOutput, uOptions;
  
{$IFDEF MSWINDOWS}
	{$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
	{$R *.xfm}
{$ENDIF}

function DocumentTypeForExt(Ext: String): String;
var
	i: Integer;
  ExtStr: String;
  ExtList: TStringList;
begin
	ExtList := TStringList.Create;

  try
		for i := 1 to DocTypes.Count do
  	begin
    	ExtList.Clear;
  		ExtStr := Settings.ReadString('DocumentTypes', 'DocumentTypeExtensions' + IntToStr(i) , '');
    	ExtractStrings([';'], [], PChar(ExtStr), ExtList);

    	if ExtList.IndexOf(Ext) <> -1 then
    	begin
    		Result := DocTypes[i - 1];
      	Break;
    	end;
  	end;
  finally
  	ExtList.Free;
  end;
end;

function GetDocumentTypeIndex(aType: String): Integer;
begin
	Result := DocTypes.IndexOf(aType) + 1;
end;

procedure TMainForm.FileNewExecute(Sender: TObject);
begin
	DocumentFactory.New;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
	Application.OnIdle := OnIdle;
  JvMouseGesture.Active := True;
  fWorkspaceFile := '';
	AppPath := IncludeTrailPathSep( ExtractFileDir(Application.ExeName) );
  Settings := TMyIniFile.Create(AppPath + 'Settings.ini');
  Settings.WriteInteger('General', 'InstanceHandle', Handle);
  ReadSettings(True);

  // Docking windows
  FunctionListForm := TFunctionListForm.Create(Self);
  OutputForm := TOutputForm.Create(Self);
  LoadDockTreeFromFile(AppPath + 'DockWindows.ini');

  // Function List window
  if GetFormVisible(FunctionListForm) then
  	ShowDockForm(FunctionListForm);

  // Output window
  if GetFormVisible(OutputForm) then
  	ShowDockForm(OutputForm);
end;

procedure TMainForm.FileOpenExecute(Sender: TObject);
var
	i: Integer;
begin
	SetupDialogsFilter;

	with dlgOpen do
  begin
    if Document <> nil then // Luciano
    	InitialDir := ExtractFileDir(Document.FileName);

  	if Execute then
    	for i := 0 to Files.Count - 1 do
      	DocumentFactory.Open( PChar(Files[i]) );
  end;
end;

procedure TMainForm.FileSaveExecute(Sender: TObject);
begin
	if Document.Saved then
		Document.Save
  else
  	FileSaveAsExecute(nil);
end;

procedure TMainForm.FileSaveAsExecute(Sender: TObject);
begin
  SaveAs;
end;

procedure TMainForm.FileSaveAllExecute(Sender: TObject);
begin
	DocumentFactory.SaveAll;
end;

procedure TMainForm.FileCloseExecute(Sender: TObject);
begin
	if Document <> nil then
  	tmrDelayClose.Enabled := True;
end;

procedure TMainForm.FileCloseAllExecute(Sender: TObject);
begin
	DocumentFactory.CloseAll;
end;

procedure TMainForm.FilePrintExecute(Sender: TObject);
var
	PrintOptions: TPrintDialogOptions;
begin
	Document.Print;

	with dlgPrint do
	begin
		PrintOptions := Options;
		MinPage := 1;
		FromPage := 1;
		MaxPage := SynEditPrint.PageCount;
		ToPage := MaxPage;
	end;

	if not Document.SelAvail then
	begin
		Exclude(PrintOptions, poSelection);
		dlgPrint.PrintRange := prAllPages;
	end
	else
	begin
		Include(PrintOptions, poSelection);
		dlgPrint.PrintRange := prSelection;
	end;

	dlgPrint.Options := PrintOptions;

	if dlgPrint.Execute then
	begin
		SynEditPrint.Copies := dlgPrint.Copies;

		case dlgPrint.PrintRange of
			prSelection: SynEditPrint.SelectedOnly := True;
			prPageNums: SynEditPrint.PrintRange(dlgPrint.FromPage, dlgPrint.ToPage);
		end;

		SynEditPrint.Print;
	end;
end;

procedure TMainForm.FileExitExecute(Sender: TObject);
begin
	Close;
end;

procedure TMainForm.EditUndoExecute(Sender: TObject);
begin
	Document.Undo;
end;

procedure TMainForm.EditRedoExecute(Sender: TObject);
begin
	Document.Redo;
end;

procedure TMainForm.EditCutExecute(Sender: TObject);
begin
	Document.Cut;
end;

procedure TMainForm.EditCopyExecute(Sender: TObject);
begin
	Document.Copy;
end;

procedure TMainForm.EditPasteExecute(Sender: TObject);
begin
	Document.Paste;
end;

procedure TMainForm.EditDeleteExecute(Sender: TObject);
begin
	Document.Delete;
end;

procedure TMainForm.EditSelectAllExecute(Sender: TObject);
begin
	Document.SelectAll;
end;

procedure TMainForm.EditIndentExecute(Sender: TObject);
begin
	Document.Indent;
end;

procedure TMainForm.EditUnindentExecute(Sender: TObject);
begin
	Document.Unindent;
end;

procedure TMainForm.tbDocumentsTabSelected(Sender: TObject;
  Item: TJvTabBarItem);
begin
	if Item <> nil then
		TDocument(Item.Data).Activate;
end;

procedure TMainForm.tbDocumentsTabClosed(Sender: TObject;
  Item: TJvTabBarItem);
begin
	Document.Close;
end;

procedure TMainForm.FileSaveUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil) and (Document.CanSave);
end;

procedure TMainForm.FileSaveAllUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := DocumentFactory.CanSaveAll;
end;

procedure TMainForm.EditUndoUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil) and (Document.CanUndo);
end;

procedure TMainForm.EditRedoUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil) and (Document.CanRedo);
end;

procedure TMainForm.SelAvailUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil) and (Document.SelAvail);
end;

procedure TMainForm.EditCopyUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil) and (Document.SelAvail);
end;

procedure TMainForm.EditPasteUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil) and (Document.CanPaste);
end;

procedure TMainForm.AnyDocumentOpenUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := Document <> nil;
end;

procedure TMainForm.ViewToolbarExecute(Sender: TObject);
begin
	tbMain.Visible := (Sender as TAction).Checked;
end;

procedure TMainForm.ViewStatusBarExecute(Sender: TObject);
begin
	StatusBar.Visible := (Sender as TAction).Checked;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
	with Settings do
  begin
  	// Language
  	WriteString('General', 'ActiveLanguage', ActiveLanguage);

    // Window size/position
    if ReadBool('General', 'SaveWindowPosition', False) then
    begin
			WriteInteger('General', 'WindowState', Integer(WindowState));

    	if WindowState <> wsMaximized then
    	begin
      	WriteInteger('General', 'WindowLeft', Left);
      	WriteInteger('General', 'WindowTop', Top);
      	WriteInteger('General', 'WindowWidth', Width);
      	WriteInteger('General', 'WindowHeight', Height);
    	end;
    end;
  end;

  // Dock windows
  SaveDockTreeToFile(AppPath + 'DockWindows.ini');

  // MRU stuff
	MRUFiles.Free;
  MRUWorkspaces.Free;
  MRUFindText.Free;
  MRUReplaceText.Free;

  // Other stuff
	Settings.Free;
  DocTypes.Free;
  CommonDocTypes.Free;
end;

procedure TMainForm.ViewShowGutterExecute(Sender: TObject);
begin
	Settings.WriteBool('Editor', 'ShowGutter', ViewShowGutter.Checked);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.ViewShowLineNumbersExecute(Sender: TObject);
begin
	Settings.WriteBool('Editor', 'ShowLineNumbers', ViewShowLineNumbers.Checked);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.ViewShowRightMarginExecute(Sender: TObject);
begin
	Settings.WriteBool('Editor', 'ShowRightMargin', ViewShowRightMargin.Checked);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.ViewWordWrapExecute(Sender: TObject);
begin
	Settings.WriteBool('Editor', 'WordWrap', ViewWordWrap.Checked);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.ViewFontExecute(Sender: TObject);
begin
	with dlgFont do
  begin
  	Font.Name := Settings.ReadString('Editor', 'FontName', 'Courier New');
    Font.Size := Settings.ReadInteger('Editor', 'FontSize', 10);

  	if Execute then
    begin
			Settings.WriteString('Editor', 'FontName', Font.Name);
			Settings.WriteInteger('Editor', 'FontSize', Font.Size);
    end;
  end;

  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.ViewShowIndentGuidesExecute(Sender: TObject);
begin
	Settings.WriteBool('Editor', 'ShowIndentGuides', ViewShowIndentGuides.Checked);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.CodeFoldingUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := (Document <> nil)
  and (Document.Editor.CodeFolding.Enabled);
end;

procedure TMainForm.miEditorFont1Click(Sender: TObject);
var
	ItemCaption, FontName: String;
  FontSize: Integer;
begin
	ItemCaption := (Sender as TMenuItem).Caption;
  FontName := StringReplace( Copy( ItemCaption, 1, Pos(',', ItemCaption) - 1 ), '&', '', [] );
  FontSize := StrToInt( Copy( ItemCaption, Pos(',', ItemCaption) + 1, MaxInt ) );
	Settings.WriteString('Editor', 'FontName', FontName);
	Settings.WriteInteger('Editor', 'FontSize', FontSize);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.ViewSettingsExecute(Sender: TObject);
begin
	with TOptionsDialog.Create(Self) do
  try
  	if ShowModal = mrOK then
    begin
    	ReadSettings;
      DocumentFactory.ReadAllFromIni;
    end;
  finally
  	Free;
  end;
end;

procedure TMainForm.ViewDocumentType1Execute(Sender: TObject);
begin
	Document.DocumentType := CommonDocTypes[ (Sender as TAction).Tag ];
end;

procedure TMainForm.miViewDocumentTypeClick(Sender: TObject);
var
	i, TypeIndex: Integer;
begin
	if Document <> nil then
  begin
  	if Document.DocumentType <> '' then
    begin
			TypeIndex := CommonDocTypes.IndexOf(Document.DocumentType) + 1;

  		if TypeIndex > 0 then
  			TAction( FindComponent('ViewDocumentType' + IntToStr(TypeIndex)) ).Checked := True
      else
      	for i := 0 to CommonDocTypes.Count do
        	TAction( FindComponent('ViewDocumentType' + IntToStr(i)) ).Checked := False;
    end
    else
    	ViewDocumentType0.Checked := True;
  end
  else
  	ViewDocumentType0.Checked := True;
end;

procedure TMainForm.ViewDocumentType0Execute(Sender: TObject);
begin
	Document.DocumentType := '';
end;

procedure TMainForm.miViewDocumentTypeMoreClick(Sender: TObject);
var
  i, TypeIndex: Integer;
begin
  if Document.DocumentType <> '' then
  begin
  	TypeIndex := DocTypes.IndexOf(Document.DocumentType);

  	if TypeIndex > -1 then
  		miViewDocumentTypeMore.Items[TypeIndex].Checked := True;
  end
  else
  	for i := 0 to miViewDocumentTypeMore.Count - 1 do
    	miViewDocumentTypeMore.Items[i].Checked := False;
end;

procedure TMainForm.ViewDocumentType0Update(Sender: TObject);
begin
	(Sender as TAction).Enabled := Document <> nil;
  miViewDocumentTypeMore.Enabled := Document <> nil;
end;

procedure TMainForm.DocumentTypeMoreClick(Sender: TObject);
begin
	Document.DocumentType := DocTypes[ (Sender as TMenuItem).Tag ];
end;

procedure TMainForm.UpdateMRUFilesMenu;
var
	i: Integer;
  MenuItem: TMenuItem;
begin
	miFileRecentFiles.Clear;

  for i := 0 to MRUFiles.Count - 1 do
  begin
  	MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := '&' + IntToStr(i) + #32 + MRUFiles[i];
    MenuItem.Tag := i;
    MenuItem.OnClick := RecentFilesClick;
    miFileRecentFiles.Add(MenuItem);
  end;

  MenuItem := TMenuItem.Create(Self);
  MenuItem.Caption := '-';
  miFileRecentFiles.Add(MenuItem);
  MenuItem := TMenuItem.Create(Self);
  MenuItem.Action := FileMRUClear;
  miFileRecentFiles.Add(MenuItem);
  MenuItem := TMenuItem.Create(Self);
  MenuItem.Action := FileMRUOpenAll;
  miFileRecentFiles.Add(MenuItem);
end;

procedure TMainForm.RecentFilesClick(Sender: TObject);
begin
	DocumentFactory.Open( PChar(MRUFiles[(Sender as TMenuItem).Tag]) );
end;

procedure TMainForm.ViewCollapseAllExecute(Sender: TObject);
begin
	Document.CollapseAll;
end;

procedure TMainForm.ViewUncollapseAllExecute(Sender: TObject);
begin
	Document.UncollapseAll;
end;

procedure TMainForm.ViewCollapseLevel0Execute(Sender: TObject);
begin
	Document.CollapseLevel( (Sender as TAction).Tag );
end;

procedure TMainForm.ViewUncollapseLevel0Execute(Sender: TObject);
begin
	Document.UncollapseLevel( (Sender as TAction).Tag );
end;

procedure TMainForm.SearchFindExecute(Sender: TObject);
begin
	FindReplaceForm(False);
end;

procedure TMainForm.SearchFindNextExecute(Sender: TObject);
begin
	if frFindText <> '' then
		if not Document.FindNext then
      StatusMsg( PChar( Format(sStrings[siNotFound], [frFindText]) ), ErrorMsgColor, clWhite,
      	4000, False );
end;

procedure TMainForm.SearchReplaceExecute(Sender: TObject);
begin
	FindReplaceForm(True);
end;

procedure TMainForm.SearchGoToLineExecute(Sender: TObject);
begin
	with TGoToLineDialog.Create(Self) do
  try
  	if ShowModal = mrOk then
    	Document.GoToLine( StrToInt(txtLine.Text) );
  finally
  	Free;
  end;
end;

procedure TMainForm.HelpTopicsExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.HelpAboutExecute(Sender: TObject);
begin
	with TAboutDialog.Create(Self) do
  try
  	ShowModal;
  finally
  	Free;
  end;
end;

procedure TMainForm.ViewShowSpecialCharactersExecute(Sender: TObject);
begin
	Settings.WriteBool('Editor', 'ShowSpecialChars', ViewShowSpecialCharacters.Checked);
  DocumentFactory.ReadAllFromIni;
end;

procedure TMainForm.SearchReplaceNextExecute(Sender: TObject);
begin
	if frFindText <> '' then
		if not Document.ReplaceNext then
  		StatusMsg( PChar( Format(sStrings[siNotFound], [frFindText]) ), ErrorMsgColor, clWhite,
      	4000, False );
end;

procedure TMainForm.FindReplaceForm(Replace: Boolean);
begin
	if Replace then
  	FindDialog := TReplaceDialog.Create(Self)
  else
  	FindDialog := TFindDialog.Create(Self);

  FindDialog.chkWhole.Checked := frWholeWords;
  FindDialog.chkCase.Checked := frMatchCase;
  FindDialog.chkRegExp.Checked := frRegExp;
  FindDialog.chkFromCursor.Checked := frFromCursor;
  FindDialog.chkInAll.Checked := frInAll;
  FindDialog.rbUp.Checked := frDirUp;
  FindDialog.rbDown.Checked := not frDirUp;

  if Document.SelAvail then
  	FindDialog.chkSelOnly.Checked := True
  else
  	FindDialog.chkSelOnly.Enabled := False;

  if Replace then
  	with TReplaceDialog(FindDialog) do
    begin
    	chkPrompt.Checked := frPrompt;
    end;

	FindDialog.Show;
end;

procedure TMainForm.StatusMsg(Msg: String; BackColor, TextColor: TColor;
  TimeInterval: Integer; DoBeep: Boolean);
begin
	if BackColor = -1 then
  	fStatusBarColor := clBtnFace
  else
  begin
  	fStatusBarColor := BackColor;
    StatusBar.Panels[idMsgPanel].Style := psOwnerDraw;
  end;

	if TextColor = -1 then
  	fStatusBarTextColor := clWindowText
  else
  begin
  	fStatusBarTextColor := TextColor;
    StatusBar.Panels[idMsgPanel].Style := psOwnerDraw;
  end;

	if TimeInterval <> -1 then
  begin
  	tmrStatusBar.Interval := TimeInterval;
  	tmrStatusBar.Enabled := True;
  end;

	StatusBar.Panels[idMsgPanel].Text := Msg;

  if DoBeep then
  	Beep;
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
	if Panel.Index = idMsgPanel then
  begin
		StatusBar.Canvas.Brush.Color := fStatusBarColor;
		StatusBar.Canvas.FillRect(Rect);
    StatusBar.Canvas.Font.Color := fStatusBarTextColor;
    StatusBar.Canvas.TextOut(Rect.Left + 2, Rect.Top + 1, Panel.Text);
  end;
end;

procedure TMainForm.tmrStatusBarTimer(Sender: TObject);
begin
	StatusBar.Panels[idMsgPanel].Style := psText;
	StatusMsg('');
  tmrStatusBar.Enabled := False;
end;

procedure TMainForm.SetupDialogsFilter;
var
	i: Integer;
  Filter: String;
begin
	i := 1;

	while Settings.ValueExists('Filters', 'Filter' + IntToStr(i)) do
	begin
		Filter := Filter + Settings.ReadString('Filters', 'Filter' + IntToStr(i), '');
		Inc(i);
	end;

	dlgOpen.Filter := Filter;
	dlgSave.Filter := Filter;
end;

procedure TMainForm.FileWorkspaceOpenExecute(Sender: TObject);
begin
	with dlgOpen do
  begin
  	Filter := 'Mystix workspace (*.mws)|*.mws|';

    if Execute then
    begin
    	DocumentFactory.CloseAll;
    	OpenWorkspace(FileName);
    end;
  end;
end;

procedure TMainForm.FileWorkspaceSaveExecute(Sender: TObject);
var
	i: Integer;
	WorkspaceFiles: TStringList;
begin
	if fWorkspaceFile = '' then
  	FileWorkspaceSaveAsExecute(nil)
  else
  begin
  	fWorkspaceModified := False;
  	WorkspaceFiles := TStringList.Create;

    try
    	for i := 0 to DocumentFactory.Count - 1 do
      	WorkspaceFiles.Add(DocumentFactory.Documents[i].FileName);

      WorkspaceFiles.SaveToFile(fWorkspaceFile);
    finally
    	WorkspaceFiles.Free;
    end;
	end;
end;

procedure TMainForm.FileWorkspaceSaveAsExecute(Sender: TObject);
begin
	with dlgSave do
  begin
  	Filter := 'Mystix workspace (*.mws)|*.mws|';
    DefaultExt := 'mws';

    if Execute then
    begin
    	fWorkspaceFile := FileName;
      fWorkspaceModified := False;
      Caption := Copy( ExtractFileName(fWorkspaceFile) , 1,
      	Length( ExtractFileName(fWorkspaceFile) ) - 4 ) + ' - Mystix';
      FileWorkspaceSaveExecute(nil);
    end;
  end;
end;

procedure TMainForm.FileWorkspaceCloseExecute(Sender: TObject);
var
	i: Integer;
const
	sMessage = 'Do you want to save changes in current workspace?';
begin
	if fWorkspaceModified then
  	if Application.MessageBox(sMessage, 'Confirm', MB_ICONQUESTION or MB_YESNO) = IDYES then
    	FileWorkspaceSaveExecute(nil);

	for i := DocumentFactory.Count - 1 downto 0 do
  	if DocumentFactory.Documents[i].Saved then
    	DocumentFactory.Documents[i].Close;

  MRUWorkspaces.Add(fWorkspaceFile);
  UpdateMRUWorkspacesMenu;
  fWorkspaceFile := '';
  Caption := 'Mystix';
end;

procedure TMainForm.FileWorkspaceSaveUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := fWorkspaceFile <> '';
end;

procedure TMainForm.UpdateMRUWorkspacesMenu;
var
	i: Integer;
  MenuItem: TMenuItem;
begin
  for i := miFileWorkspace.Count - 1 downto 5 do
  	miFileWorkspace.Delete(i);

  for i := 0 to MRUWorkspaces.Count - 1 do
  begin
  	MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := '&' + IntToStr(i) + #32 + MRUWorkspaces[i];
    MenuItem.Tag := i;
    MenuItem.OnClick := RecentWorkspacesClick;
    miFileWorkspace.Add(MenuItem);
  end;

  MenuItem := TMenuItem.Create(Self);
  MenuItem.Caption := '-';
  miFileWorkspace.Add(MenuItem);
  MenuItem := TMenuItem.Create(Self);
  MenuItem.Action := FileWorkspaceMRUClear;
  miFileWorkspace.Add(MenuItem);
end;

procedure TMainForm.RecentWorkspacesClick(Sender: TObject);
begin
	OpenWorkspace( PChar(MRUWorkspaces[(Sender as TMenuItem).Tag]) );
end;

procedure TMainForm.OpenWorkspace(FileName: String);
var
	WorkspaceFiles: TStringList;
  i: Integer;
begin
	if DocumentFactory.CloseAll then
  begin
		fWorkspaceFile := FileName;
		fWorkspaceModified := False;
		Caption := Copy( ExtractFileName(fWorkspaceFile), 1,
    	Length( ExtractFileName(fWorkspaceFile) ) - 4 ) + ' - Mystix';
		WorkspaceFiles := TStringList.Create;

		try
			WorkspaceFiles.LoadFromFile(fWorkspaceFile);

			for i := 0 to WorkspaceFiles.Count - 1 do
				DocumentFactory.Open( PChar(WorkspaceFiles[i]) );
		finally
			WorkspaceFiles.Free;
		end;
  end;
end;

procedure TMainForm.ViewCollapseCurrentExecute(Sender: TObject);
begin
	Document.CollapseCurrent;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i, j: Integer;
begin
  if fWorkspaceFile <> '' then
    Settings.WriteString('General', 'LastWorkspace', fWorkspaceFile)
  else
  begin
    Settings.EraseSection('LastOpenFiles');
    j := 0;

    for i := 0 to DocumentFactory.Count - 1 do
      if DocumentFactory[i].Saved then
      begin
        Settings.WriteString('LastOpenFiles', IntToStr(j),
          DocumentFactory[i].FileName);
        Inc(j);
      end;
  end;

	CanClose := DocumentFactory.CloseAll;
end;

procedure TMainForm.OnIdle(Sender: TObject; var Done: Boolean);
begin // Luciano
  if GetKeyState(VK_NUMLOCK) = 1 then
    StatusBar.Panels[idNumPanel].Text := 'NUM'
  else
    StatusBar.Panels[idNumPanel].Text := '';

  if GetKeyState(VK_CAPITAL) = 1 then
    StatusBar.Panels[idCapsPanel].Text := 'CAPS'
  else
    StatusBar.Panels[idCapsPanel].Text := '';

  if GetKeyState(VK_SCROLL) = 1 then
    StatusBar.Panels[idScrollPanel].Text := 'SCRL'
  else
    StatusBar.Panels[idScrollPanel].Text := '';
end;

procedure TMainForm.ReadLanguageData;
var
	i: Integer;
  Msg: String;
begin
	with TMyIniFile.Create(Languages.Values[ActiveLanguage]) do
  try
    // Menus
    for i := 0 to ComponentCount - 1 do
    	if Components[i] is TMenuItem then
      	with TMenuItem(Components[i]) do
        	if (Action = nil) and (Caption <> '-') then
          	Caption := ReadString(Self.Name,
            	Self.Components[i].Name + '.Caption', '');

  	// Action List
    for i := 0 to actlMain.ActionCount - 1 do
    	TAction(actlMain.Actions[i]).Caption := ReadString(Name,
      	actlMain.Actions[i].Name + '.Caption', '');

    // Const strings
		for i := 0 to StringsCount do
    	sStrings[i] := ReadString('Strings', Format('String%d', [i]), '');

    if ReadString('Language', 'Version', '') <> ProjectVersion then
    begin
      if sStrings[siWrongLangVersion] = '' then
        Msg := 'Selected language is not up to date'
      else
        Msg := sStrings[siWrongLangVersion];

      StatusMsg(Msg, ErrorMsgColor, clHighlightText, 4000, True);
    end;
  finally
		Free;
  end;

  if FunctionListForm <> nil then
  	FunctionListForm.ReadLanguageData;

  if OutputForm <> nil then
  	OutputForm.ReadLanguageData;

  tbtnCollapse.Width := 36;
  tbtnUncollapse.Width := 36;
  UpdateDynamicMenus;

  if Document <> nil then
  	Document.Activate;
end;

procedure TMainForm.UpdateLanguageMenu;
var
	i: Integer;
  MenuItem: TMenuItem;
begin
	miViewLanguage.Clear;
  
  for i := 0 to Languages.Count - 1 do
  begin
  	MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := Languages.Names[i];
    MenuItem.RadioItem := True;
    MenuItem.GroupIndex := 1;
    MenuItem.Tag := i;
    MenuItem.OnClick := LanguagesClick;
    miViewLanguage.Add(MenuItem);
  end;
end;

procedure TMainForm.LanguagesClick(Sender: TObject);
begin
	ActiveLanguage := Languages.Names[(Sender as TMenuItem).Tag];
	ReadLanguageData;
end;

procedure TMainForm.UpdateDynamicMenus;
begin
	UpdateLanguageMenu;
  UpdateFontMenu;
  UpdateDocumentTypeMenu;
  UpdateMRUFilesMenu;
  UpdateMRUWorkspacesMenu;
end;

procedure TMainForm.UpdateFontMenu;
var
	i: Integer;
begin
	for i := 1 to 5 do
		if Settings.ValueExists('EditorFonts', 'FontName' + IntToStr(i)) then
			with TMenuItem( FindComponent('miEditorFont' + IntToStr(i)) ) do
			begin
				Caption := Format('%s, %d', [Settings.ReadString('EditorFonts', 'FontName' + IntToStr(i), ''),
					Settings.ReadInteger('EditorFonts', 'FontSize' + IntToStr(i), 0)]);
				Visible := True;
			end
		else
			Break;
end;

procedure TMainForm.miViewLanguageClick(Sender: TObject);
var
	i: Integer;
begin
	for i := 0 to Languages.Count - 1 do
  	if SameText(ActiveLanguage, Languages.Names[i]) then
    begin
    	miViewLanguage.Items[i].Checked := True;
      Break;
    end;
end;

procedure TMainForm.ViewFunctionListExecute(Sender: TObject);
begin
	if GetFormVisible(FunctionListForm) then
  	HideDockForm(FunctionListForm)
  else
  	ShowDockForm(FunctionListForm);
end;

procedure TMainForm.ViewOutputExecute(Sender: TObject);
begin
	if GetFormVisible(OutputForm) then
  	HideDockForm(OutputForm)
  else
  	ShowDockForm(OutputForm);
end;

procedure TMainForm.ViewFunctionListUpdate(Sender: TObject);
begin
	(Sender as TAction).Checked := GetFormVisible(FunctionListForm);
end;

procedure TMainForm.ViewOutputUpdate(Sender: TObject);
begin
	(Sender as TAction).Checked := GetFormVisible(OutputForm);
end;

procedure TMainForm.EditDeleteWordExecute(Sender: TObject);
begin
	Document.DeleteWord;
end;

procedure TMainForm.EditDeleteLineExecute(Sender: TObject);
begin
	Document.DeleteLine;
end;

procedure TMainForm.EditDeleteToEndOfWordExecute(Sender: TObject);
begin
	Document.DeleteToEndOfWord;
end;

procedure TMainForm.EditDeleteToEndOfLineExecute(Sender: TObject);
begin
	Document.DeleteToEndOfLine;
end;

procedure TMainForm.EditDeleteWordBackExecute(Sender: TObject);
begin
	Document.DeleteWordBack;
end;

procedure TMainForm.EditSelectWordExecute(Sender: TObject);
begin
	Document.SelectWord;
end;

procedure TMainForm.EditSelectLineExecute(Sender: TObject);
begin
	Document.SelectLine;
end;

procedure TMainForm.EditColumnSelectExecute(Sender: TObject);
begin
	Document.ColumnSelect;
end;

procedure TMainForm.EditColumnSelectUpdate(Sender: TObject);
begin
	(Sender as TAction).Enabled := Document <> nil;

  if (Sender as TAction).Enabled then
  	(Sender as TAction).Checked := Document.Editor.SelectionMode = smColumn;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if Button = mbRight then
		JvMouseGesture.StartMouseGesture(X, Y);
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	if JvMouseGesture.TrailActive then
		JvMouseGesture.TrailMouseGesture(X, Y);
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if JvMouseGesture.TrailActive then
		JvMouseGesture.EndMouseGesture;

  if (Button = mbRight) and (Document <> nil) then
    mnuEditor.Popup(X, Y);
end;

procedure TMainForm.JvMouseGestureMouseGestureDown(Sender: TObject);
var
	Action: TAction;
begin
	try
  	Action := TAction(FindComponent(Settings.ReadString('Mouse', 'GestureDown', '')));

    if Action.Enabled then
			Action.OnExecute(Action);
  except

  end;
end;

procedure TMainForm.JvMouseGestureMouseGestureLeft(Sender: TObject);
var
	Action: TAction;
begin
	try
  	Action := TAction(FindComponent(Settings.ReadString('Mouse', 'GestureLeft', '')));
    
    if Action.Enabled then
			Action.OnExecute(Action);
  except

  end;
end;

procedure TMainForm.JvMouseGestureMouseGestureRight(Sender: TObject);
var
	Action: TAction;
begin
	try
  	Action := TAction(FindComponent(Settings.ReadString('Mouse', 'GestureRight', '')));
    
    if Action.Enabled then
			Action.OnExecute(Action);
  except

  end;
end;

procedure TMainForm.JvMouseGestureMouseGestureUp(Sender: TObject);
var
	Action: TAction;
begin
	try
  	Action := TAction(FindComponent(Settings.ReadString('Mouse', 'GestureUp', '')));

    if Action.Enabled then
			Action.OnExecute(Action);
  except

  end;
end;

procedure TMainForm.tmrDelayCloseTimer(Sender: TObject);
begin
	tmrDelayClose.Enabled := False;
	Document.Close;
end;

procedure TMainForm.ReadSettings(FirstTime: Boolean = False);
var
	i: Integer;
  LanguageFiles: TStringList;
begin
	with Settings do
  begin
    // Document types
    if FirstTime then
    	DocTypes := TStringList.Create
    else
    	DocTypes.Clear;

    i := 1;

    while ValueExists('DocumentTypes', 'DocumentTypeName' + IntToStr(i)) do
    begin
    	DocTypes.Add( ReadString('DocumentTypes', 'DocumentTypeName' + IntToStr(i), 'Unknown') );
      Inc(i);
    end;

    // Common document types
		if FirstTime then
    	CommonDocTypes := TStringList.Create
    else
  		CommonDocTypes.Clear;
      
    // Read MRU
    MRUFiles := TMRUList.Create(Settings, 10, 'MRUFiles');
    UpdateMRUFilesMenu;
    MRUWorkspaces := TMRUList.Create(Settings, 10, 'MRUWorkspaces');
    UpdateMRUWorkspacesMenu;
    MRUFindText := TMRUList.Create(Settings, 30, 'MRUFindText');
    MRUReplaceText := TMRUList.Create(Settings, 30, 'MRUFReplaceText');

  	// Language related
    ActiveLanguage := ReadString('General', 'ActiveLanguage', 'English');
  	Languages := TStringList.Create;
  	FileListInDir(AppPath + 'Languages' + PathSep, '*.ini', 0, LanguageFiles);

  	for i := 0 to LanguageFiles.Count - 1 do
  		with TMyIniFile.Create(LanguageFiles[i]) do
    	try
  			Languages.Add( ReadString('Language', 'Name', '') + '=' + LanguageFiles[i] );
    	finally
    		Free;
    	end;

    Languages.Sort;
    ReadLanguageData;

  	// Read general settings
    if (FirstTime) and (ReadBool('General', 'SaveWindowPosition', False)) then
    begin
    	WindowState := TWindowState(ReadInteger('General', 'WindowState', 2));

    	if WindowState = wsMinimized then
    		WindowState := wsMaximized;

    	if WindowState <> wsMaximized then
    	begin
    		Left := ReadInteger('General', 'WindowLeft', 0);
    		Top := ReadInteger('General', 'WindowTop', 0);
    		Width := ReadInteger('General', 'WindowWidth', Screen.Width div 2);
    		Height := ReadInteger('General', 'WindowHeight', Screen.Height div 2);
    	end;
    end;

    // View menu
    ViewToolbar.Checked := ReadBool('General', 'ShowToolbar', True);
    ViewStatusBar.Checked := ReadBool('General', 'ShowStatusBar', True);

    // Read editor settings
    ViewShowGutter.Checked := ReadBool('Editor', 'ShowGutter', True);
    ViewShowLineNumbers.Checked := ReadBool('Editor', 'ShowLineNumbers', True);
    ViewShowRightMargin.Checked := ReadBool('Editor', 'ShowRightMargin', True);
    ViewShowSpecialCharacters.Checked := ReadBool('Editor', 'ShowSpecialChars', True);
    ViewWordWrap.Checked := ReadBool('Editor', 'WordWrap', True);
    ViewShowIndentGuides.Checked := ReadBool('Editor', 'ShowIndentGuides', True);

    // Read open/save dialog filters
    SetupDialogsFilter;

    // Read shortcuts
    for i := 0 to actlMain.ActionCount - 1 do
    	TAction(actlMain.Actions[i]).ShortCut := TextToShortCut(ReadString('Keyboard',
      	actlMain.Actions[i].Name, ''));

    // Call some procedures to make changes visible
    ViewToolbarExecute(ViewToolbar);
    ViewStatusBarExecute(ViewStatusBar);
  end;
end;

procedure TMainForm.UpdateDocumentTypeMenu;
var
	i: Integer;
  MenuItem: TMenuItem;
begin
	miViewDocumentTypeMore.Clear;

  for i := 0 to DocTypes.Count - 1 do
  begin
  	MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := DocTypes[i];
    MenuItem.RadioItem := True;
    Menuitem.Tag := i;
    MenuItem.OnClick := DocumentTypeMoreClick;
    miViewDocumentTypeMore.Add(MenuItem);
  end;

	i := 1;

	while Settings.ValueExists('CommonDocumentTypes', 'DocumentType'
	+ IntToStr(i)) do
	begin
		CommonDocTypes.Add( Settings.ReadString('CommonDocumentTypes',
			'DocumentType' + IntToStr(i), 'Unknown' ) );

		with TAction( FindComponent('ViewDocumentType' + IntToStr(i)) ) do
		begin
			Caption := CommonDocTypes[CommonDocTypes.Count - 1];
			Visible := True;
		end;

		Inc(i);
	end;

	while i < 10 do
	begin
		TAction(FindComponent('ViewDocumentType' + IntToStr(i))).Visible := False;
		Inc(i);
	end;
end;

procedure TMainForm.SearchFunctionListExecute(Sender: TObject);
begin
	Document.UpdateFunctionList;
end;

procedure TMainForm.WmMButtonUp(var Message: TMessage);
var
	Action: TAction;
begin
  try
    Action := TAction(FindComponent(Settings.ReadString('Mouse', 'MiddleButton', '')));

    if Action.Enabled then
      Action.OnExecute(Action);
  except end;
end;

procedure TMainForm.SaveAs(aDocument: TDocument);
var
	DefExt, Buffer: String;
  i, p: Integer;
begin
  if aDocument = nil then
    aDocument := Document;
    
	SetupDialogsFilter;

	with dlgSave do
  begin
    if aDocument.Saved then
      FileName := ExtractFileName(aDocument.FileName)
    else
      FileName := aDocument.FileName;

		if Execute then
    begin
    	if ExtractFileExt(FileName) = '' then
      begin
      	Buffer := Filter;
      	i := 1;

        while i < FilterIndex do
        begin
        	p := Pos('|*.', Buffer);
          Delete(Buffer, 1, p + 2);
          p := Pos('|', Buffer);
          Delete(Buffer, 1, p);
          Inc(i);
        end;

        p := Pos('|*.', Buffer);
        Delete(Buffer, 1, p + 2);

        i := 1;

        while not (Buffer[i] in [';', '|']) do
        	Inc(i);

        DefExt := Copy(Buffer, 1, i - 1);

        if DefExt = '*' then
        	DefExt := Settings.ReadString('General', 'DefaultExtension', 'txt');

        DefExt := '.' + DefExt;
      end
      else
      	DefExt := '';

    	aDocument.Saved := True;
      aDocument.FileName := FileName + DefExt;
      aDocument.Save;
    end;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i: Integer;
  Names: TStringList;
begin
  if Settings.ReadBool('General', 'ReopenLastWorkspace', False) then
    OpenWorkspace(Settings.ReadString('General', 'LastWorkspace', ''))
  else if Settings.ReadBool('General', 'ReopenLastFiles', False) then
  begin
    Names := TStringList.Create;

    try
      Settings.ReadSection('LastOpenFiles', Names);

      for i := 0 to Names.Count - 1 do
        DocumentFactory.Open(Settings.ReadString('LastOpenFiles', Names[i], ''));
    finally
      Names.Free;
    end;
  end
  else if Settings.ReadBool('General', 'CreateEmptyDocument', False) then
    DocumentFactory.New;

  for i := 1 to ParamCount do
    DocumentFactory.Open(ParamStr(i));
end;

procedure TMainForm.EditChangeCaseUpperExecute(Sender: TObject);
begin
  Document.UpperCase;
end;

procedure TMainForm.EditChangeCaseLowerExecute(Sender: TObject);
begin
  Document.LowerCase;
end;

procedure TMainForm.EditChangeCaseToggleExecute(Sender: TObject);
begin
  Document.ToggleCase;
end;

procedure TMainForm.EditChangeCaseCapitalizeExecute(Sender: TObject);
begin
  Document.Capitalize;
end;

procedure TMainForm.FileMRUClearExecute(Sender: TObject);
begin
  MRUFiles.Clear;
  UpdateMRUFilesMenu;
end;

procedure TMainForm.FileWorkspaceMRUClearExecute(Sender: TObject);
begin
  MRUWorkspaces.Clear;
  UpdateMRUWorkspacesMenu;
end;

procedure TMainForm.FileMRUOpenAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to MRUFiles.Count - 1 do
    DocumentFactory.Open(MRUFiles[i]);
end;

procedure TMainForm.WMOpenFile(var Message: TMessage);
var
	FileName: PChar;
begin
	SetForegroundWindow(Self.Handle);
	BringWindowToTop(Self.Handle);
	GetMem(FileName, 255);
	GlobalGetAtomName(Message.wParam, FileName, 255);
	DocumentFactory.Open(FileName);
	GlobalDeleteAtom(Message.wParam);
	FreeMem(FileName);
end;

end.
