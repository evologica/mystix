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
unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, CheckLst, uMyIniFiles, ActnList,
  Menus, Registry;

type
  TOptionsDialog = class(TForm)
    pctrlOptions: TPageControl;
    btnOK: TButton;
    btnCancel: TButton;
    tsGeneral: TTabSheet;
    tsEditor: TTabSheet;
    chkSaveWindowPos: TCheckBox;
    lblInterfaceLanguage: TLabel;
    cmbLanguage: TComboBox;
    lblDefExtension: TLabel;
    txtDefExt: TEdit;
    chkReopenWorkspace: TCheckBox;
    chkReopenLastFiles: TCheckBox;
    chkCreateEmpty: TCheckBox;
    lblDefDocumentType: TLabel;
    cmbDocType: TComboBox;
    tsDocumentTypes: TTabSheet;
    gbGeneral: TGroupBox;
    chkAutoIndent: TCheckBox;
    chkGroupUndo: TCheckBox;
    chkHighlightLine: TCheckBox;
    chkInsertMode: TCheckBox;
    chkScrollPastEOF: TCheckBox;
    chkScrollPastEOL: TCheckBox;
    chkIndentGuides: TCheckBox;
    chkSpecialCharacters: TCheckBox;
    chkTabsToSpaces: TCheckBox;
    chkWordWrap: TCheckBox;
    gbGutterMargin: TGroupBox;
    lblActiveLine: TLabel;
    cbActiveLine: TColorBox;
    lblExtraLine: TLabel;
    Edit2: TEdit;
    udExtraSpacing: TUpDown;
    lblInsertCaret: TLabel;
    cmbInsertCaret: TComboBox;
    lblOverwriteCaret: TLabel;
    cmbOverwriteCaret: TComboBox;
    Edit3: TEdit;
    udMaxUndo: TUpDown;
    lblMaxUndo: TLabel;
    lblTabWidth: TLabel;
    Edit4: TEdit;
    udTabWidth: TUpDown;
    chkShowGutter: TCheckBox;
    chkShowRightMargin: TCheckBox;
    chkShowLineNumbers: TCheckBox;
    chkShowLeadingZeros: TCheckBox;
    chkZeroStart: TCheckBox;
    lblRightMarginPos: TLabel;
    Edit5: TEdit;
    udRightMargin: TUpDown;
    lblGutterColor: TLabel;
    cbGutter: TColorBox;
    lblFoldingBarColor: TLabel;
    cbFoldingBar: TColorBox;
    lblFoldingLinesColor: TLabel;
    cbFoldingLines: TColorBox;
    chkHighlightGuides: TCheckBox;
    btnFont: TButton;
    lstDocTypes: TListBox;
    gbDocTypeProperties: TGroupBox;
    lblDocTypeName: TLabel;
    txtDocTypeName: TEdit;
    txtExtensions: TEdit;
    lblDocTypeExtensions: TLabel;
    lblDocTypeSyntaxFile: TLabel;
    txtSyntax: TEdit;
    chkCodeFolding: TCheckBox;
    lblFoldingButton: TLabel;
    cmbFoldingButton: TComboBox;
    lblDocTypeRegExp: TLabel;
    txtRegExp: TEdit;
    btnSyntax: TButton;
    btnAddDocType: TButton;
    btnDeleteDocType: TButton;
    gbCommonDocTypes: TGroupBox;
    lstCommonDocTypes: TCheckListBox;
    lblCommonDocTypesIntro: TLabel;
    dlgOpen: TOpenDialog;
    tsKeyboard: TTabSheet;
    dlgFont: TFontDialog;
    gbKeyboard: TGroupBox;
    lblKeyCategories: TLabel;
    lstKeyCat: TListBox;
    lstKeyCmd: TListBox;
    lblKeyCommands: TLabel;
    lblShortcutKey: TLabel;
    gbMouse: TGroupBox;
    lblGestureUp: TLabel;
    cmbGestureUp: TComboBox;
    lblGestureLeft: TLabel;
    cmbGestureLeft: TComboBox;
    lblGestureDown: TLabel;
    cmbGestureDown: TComboBox;
    lblGestureRight: TLabel;
    cmbGestureRight: TComboBox;
    lblMiddleButton: TLabel;
    cmbMiddleButton: TComboBox;
    lblShortCutAssigned: TLabel;
    lblShortCutAssignedTo: TLabel;
    btnHelp: TButton;
    chkDefEditor: TCheckBox;
    chkSysContext: TCheckBox;
    chkOneCopy: TCheckBox;
    chkCtrl: TCheckBox;
    chkShift: TCheckBox;
    chkAlt: TCheckBox;
    cmbShortCut: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure lstDocTypesClick(Sender: TObject);
    procedure btnAddDocTypeClick(Sender: TObject);
    procedure btnDeleteDocTypeClick(Sender: TObject);
    procedure txtDocTypeNameExit(Sender: TObject);
    procedure txtExtensionsExit(Sender: TObject);
    procedure txtSyntaxExit(Sender: TObject);
    procedure txtRegExpExit(Sender: TObject);
    procedure btnSyntaxClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure lstKeyCatClick(Sender: TObject);
    procedure lstKeyCmdClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lstCommonDocTypesMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chkDefEditorClick(Sender: TObject);
    procedure chkSysContextClick(Sender: TObject);
    procedure chkCtrlClick(Sender: TObject);
    procedure chkShiftClick(Sender: TObject);
    procedure chkAltClick(Sender: TObject);
    procedure cmbShortCutChange(Sender: TObject);
  private
    { Private declarations }
    fSettingsCopy: TMyIniFile;
    fSettingShortCut: Boolean;
    
    procedure SetDocumentTypeProperty(PropertyName, Value: Variant);
    procedure ReadLanguageData;
    procedure ShortcutAssigned;
    procedure ShortcutChanged;
    function ShortcutGet: String;
    function IsDefaultEditorOf(DocumentType: String): Boolean;
    function IsInContextMenuOf(DocumentType: String): Boolean;
    function GetClassNameFor(Extension: String): String;
    procedure MakeDefaultEditor(Index: Integer; Associate: Boolean);
    procedure AddToSysContext(Index: Integer; Associate: Boolean);
    procedure GetExtensions(Index: Integer; Extensions: TStringList);
  public
    { Public declarations }
  end;

var
  OptionsDialog: TOptionsDialog;
  CommandNames: TStringList;

const
	DocTypeKeyNames: array[0..3] of String = ('Name', 'Extensions', 'SyntaxFile',
  	'FunctionRegExp');

implementation

uses uMain, IniFiles, uUtils;

{$R *.dfm}

procedure TOptionsDialog.FormCreate(Sender: TObject);
var
	i: Integer;
  TempFileName: String;
begin
	ReadLanguageData;
	TempFileName := PChar(ExtractFilePath(Settings.FileName) + 'SettingsCopy.ini');
	CopyFile(PChar(Settings.FileName), PChar(TempFileName), False);
	fSettingsCopy := TMyIniFile.Create(TempFileName);
  
	with fSettingsCopy do
  begin
  	// General
    // Setup controls
    cmbLanguage.Items.BeginUpdate;

    try
    	for i := 0 to Languages.Count - 1 do
    		cmbLanguage.Items.Add(Languages.Names[i]);
    finally
    	cmbLanguage.Items.EndUpdate;
    end;

    cmbDocType.Items.BeginUpdate;

    try
    	cmbDocType.Items.Add(sStrings[siNoDocType]);
      
    	for i := 0 to DocTypes.Count - 1 do
    		cmbDocType.Items.Add(DocTypes[i]);
    finally
    	cmbDocType.Items.EndUpdate;
    end;

    // Read data
    chkOneCopy.Checked := ReadBool('General', 'OnlyOneCopy', False);
  	chkSaveWindowPos.Checked := ReadBool('General', 'SaveWindowPosition', False);
    chkReopenWorkspace.Checked := ReadBool('General', 'ReopenLastWorkspace', False);
    chkReopenLastFiles.Checked := ReadBool('General', 'ReopenLastFiles', False);
    chkCreateEmpty.Checked := ReadBool('General', 'CreateEmptyDocument', False);
    cmbLanguage.ItemIndex := cmbLanguage.Items.IndexOf(ActiveLanguage);
    cmbDocType.ItemIndex := cmbDocType.Items.IndexOf(
    	ReadString('General', 'DefaultDocumentType', ''));
      
    if cmbDocType.ItemIndex = -1 then
    	cmbDocType.ItemIndex := 0;

    txtDefExt.Text := ReadString('General', 'DefaultExtension', 'txt');

		// Editor
    // Setup controls
    for i := 8 to 11 do
    begin
    	cmbInsertCaret.Items.Add(sStrings[i]);
      cmbOverwriteCaret.Items.Add(sStrings[i]);
    end;

    for i := 16 to 17 do
    	cmbFoldingButton.Items.Add(sStrings[i]);

    // Read data
    chkAutoIndent.Checked := ReadBool('Editor', 'AutoIndent', False);
    chkCodeFolding.Checked := ReadBool('Editor', 'CodeFolding', False);
    chkGroupUndo.Checked := ReadBool('Editor', 'GroupUndo', False);
    chkHighlightLine.Checked := ReadBool('Editor', 'HighlightActiveLine', False);
    chkHighlightGuides.Checked := ReadBool('Editor', 'HighlightIndentGuides', False);
    chkInsertMode.Checked := ReadBool('Editor', 'InsertMode', False);
    chkScrollPastEOF.Checked := ReadBool('Editor', 'ScrollPastEOF', False);
    chkScrollPastEOL.Checked := ReadBool('Editor', 'ScrollPastEOL', False);
    chkIndentGuides.Checked := ReadBool('Editor', 'ShowIndentGuides', False);
    chkSpecialCharacters.Checked := ReadBool('Editor', 'ShowSpecialCharacters', False);
    chkTabsToSpaces.Checked := ReadBool('Editor', 'TabsToSpaces', False);
    chkWordWrap.Checked := ReadBool('Editor', 'WordWrap', False);

    cbActiveLine.Selected := ReadColor('Editor', 'ActiveLineColor', clYellow);
    udExtraSpacing.Position := ReadInteger('Editor', 'ExtraLineSpacing', 0);
    udMaxUndo.Position := ReadInteger('Editor', 'MaximumUndo', 1024);
    cmbInsertCaret.ItemIndex := ReadInteger('Editor', 'InsertCaret', 0);
    cmbOverwriteCaret.ItemIndex := ReadInteger('Editor', 'OverwriteCaret', 0);
    cmbFoldingButton.ItemIndex := ReadInteger('Editor', 'FoldingButtonStyle', 0);
    udTabWidth.Position := ReadInteger('Editor', 'TabWidth', 4);
    dlgFont.Font.Name := ReadString('Editor', 'FontName', '');
    dlgFont.Font.Size := ReadInteger('Editor', 'FontSize', 10);
    btnFont.Caption := Format(sStrings[siFontButton],
    	[dlgFont.Font.Name, dlgFont.Font.Size]);

		chkShowGutter.Checked := ReadBool('Editor', 'ShowGutter', False);
    chkShowRightMargin.Checked := ReadBool('Editor', 'ShowRightMargin', False);
    chkShowLineNumbers.Checked := ReadBool('Editor', 'ShowLineNumbers', False);
    chkShowLeadingZeros.Checked := ReadBool('Editor', 'ShowLeadingZeros', False);
    chkZeroStart.Checked := ReadBool('Editor', 'ZeroStart', False);

		udRightMargin.Position := ReadInteger('Editor', 'RightMarginPosition', 80);
    cbGutter.Selected := ReadColor('Editor', 'GutterColor', clBtnFace);
    cbFoldingBar.Selected := ReadColor('Editor', 'FoldingBarColor', clDefault);
    cbFoldingLines.Selected := ReadColor('Editor', 'FoldingBarLinesColor', clDefault);

    // Document types
    // Read data
    lstDocTypes.Items.BeginUpdate;
    lstCommonDocTypes.Items.BeginUpdate;

    try
    	i := 1;

    	while ValueExists('DocumentTypes', 'DocumentTypeName' + IntToStr(i)) do
      begin
    		lstDocTypes.Items.Add(ReadString('DocumentTypes', 'DocumentTypeName'
        	+ IntToStr(i), ''));
        lstCommonDocTypes.Items.Add(ReadString('DocumentTypes', 'DocumentTypeName'
        	+ IntToStr(i), ''));
      	Inc(i);
      end;

      if lstDocTypes.Count > 0 then
      begin
      	lstDocTypes.ItemIndex := 0;
        lstDocTypesClick(nil);
      end;

      i := 1;
      
      while ValueExists('CommonDocumentTypes', 'DocumentType' + IntToStr(i)) do
      begin
    		lstCommonDocTypes.Checked[lstCommonDocTypes.Items.IndexOf(
        	ReadString('CommonDocumentTypes', 'DocumentType'
          + IntToStr(i), '') )] := True;
      	Inc(i);
      end;
    finally
    	lstDocTypes.Items.EndUpdate;
      lstCommonDocTypes.Items.EndUpdate;
    end;

    // Keyboard & Mouse
    // Setup controls
		with MainForm.actlMain do
    begin
    	lstKeyCat.Items.BeginUpdate;

    	try
    		for i := 0 to ActionCount - 1 do
      		if lstKeyCat.Items.IndexOf(Actions[i].Category) = -1 then
        		lstKeyCat.Items.Add(Actions[i].Category);

        if lstKeyCat.Count > 0 then
        begin
        	lstKeyCat.ItemIndex := 0;
          lstKeyCatClick(nil);
        end;
      finally
      	lstKeyCat.Items.EndUpdate;
      end;

      CommandNames := TStringList.Create;

      for i := 0 to ActionCount - 1 do
      	CommandNames.Add(Actions[i].Name);

      CommandNames.Sort;
      cmbGestureUp.Items.Assign(CommandNames);
      cmbGestureLeft.Items.Assign(CommandNames);
      cmbGestureDown.Items.Assign(CommandNames);
      cmbGestureRight.Items.Assign(CommandNames);
      cmbMiddleButton.Items.Assign(CommandNames);
    end;

    // Read data
    with cmbGestureDown do
    	ItemIndex := Items.IndexOf(ReadString('Mouse', 'GestureDown', ''));

    with cmbGestureLeft do
    	ItemIndex := Items.IndexOf(ReadString('Mouse', 'GestureLeft', ''));

    with cmbGestureRight do
    	ItemIndex := Items.IndexOf(ReadString('Mouse', 'GestureRight', ''));

    with cmbGestureUp do
    	ItemIndex := Items.IndexOf(ReadString('Mouse', 'GestureUp', ''));

    with cmbMiddleButton do
    	ItemIndex := Items.IndexOf(ReadString('Mouse', 'MiddleButton', ''));
  end;
end;

procedure TOptionsDialog.btnOKClick(Sender: TObject);
var
	i, j, Index: Integer;
  SortedList: TStringList;
begin
	with fSettingsCopy do
  begin
  	// General
    WriteBool('General', 'OnlyOneCopy', chkOneCopy.Checked);
  	WriteBool('General', 'SaveWindowPosition', chkSaveWindowPos.Checked);
    WriteBool('General', 'ReopenLastWorkspace', chkReopenWorkspace.Checked);
    WriteBool('General', 'ReopenLastFiles', chkReopenLastFiles.Checked);
    WriteBool('General', 'CreateEmptyDocument', chkCreateEmpty.Checked);
    WriteString('General', 'ActiveLanguage',
    	cmbLanguage.Items[cmbLanguage.ItemIndex]);
    ActiveLanguage := cmbLanguage.Items[cmbLanguage.ItemIndex];

    if cmbDocType.ItemIndex = 0 then
    	WriteString('General', 'DefaultDocumentType', '')
    else
    	WriteString('General', 'DefaultDocumentType',
    		cmbDocType.Items[cmbDocType.ItemIndex]);

    WriteString('General', 'DefaultExtension', txtDefExt.Text);

    // Editor
    WriteBool('Editor', 'AutoIndent', chkAutoIndent.Checked);
    WriteBool('Editor', 'CodeFolding', chkCodeFolding.Checked);
    WriteBool('Editor', 'GroupUndo', chkGroupUndo.Checked);
    WriteBool('Editor', 'HighlightActiveLine', chkHighlightLine.Checked);
    WriteBool('Editor', 'HighlightIndentGuides', chkIndentGuides.Checked);
    WriteBool('Editor', 'InsertMode', chkInsertMode.Checked);
    WriteBool('Editor', 'ScrollPastEOF', chkScrollPastEOF.Checked);
    WriteBool('Editor', 'ScrollPastEOL', chkScrollPastEOL.Checked);
    WriteBool('Editor', 'ShowIndentGuides', chkIndentGuides.Checked);
    WriteBool('Editor', 'ShowSpecialCharacters', chkSpecialCharacters.Checked);
    WriteBool('Editor', 'TabsToSpaces', chkTabsToSpaces.Checked);
    WriteBool('Editor', 'WordWrap', chkWordWrap.Checked);

    WriteColor('Editor', 'ActiveLineColor', cbActiveLine.Selected);
    WriteInteger('Editor', 'ExtraLineSpacing', udExtraSpacing.Position);
    WriteInteger('Editor', 'MaximumUndo', udMaxUndo.Position);
    WriteInteger('Editor', 'InsertCaret', cmbInsertCaret.ItemIndex);
    WriteInteger('Editor', 'OverwriteCaret', cmbOverwriteCaret.ItemIndex);
    WriteInteger('Editor', 'FoldingButtonStyle', cmbFoldingButton.ItemIndex);
    WriteInteger('Editor', 'TabWidth', udTabWidth.Position);
    WriteString('Editor', 'FontName', dlgFont.Font.Name);
    WriteInteger('Editor', 'FontSize', dlgFont.Font.Size);

    WriteBool('Editor', 'ShowGutter', chkShowGutter.Checked);
    WriteBool('Editor', 'ShowRightMargin', chkShowRightMargin.Checked);
    WriteBool('Editor', 'ShowLineNumbers', chkShowLineNumbers.Checked);
    WriteBool('Editor', 'ShowLeadingZeros', chkShowLeadingZeros.Checked);
    WriteBool('Editor', 'ZeroStart', chkZeroStart.Checked);
    WriteInteger('Editor', 'RightMarginPosition', udRightMargin.Position);
    WriteColor('Editor', 'GutterColor', cbGutter.Selected);
    WriteColor('Editor', 'FoldingBarColor', cbFoldingBar.Selected);
    WriteColor('Editor', 'FoldingBarLinesColor', cbFoldingLines.Selected);

    // Document types
    for i := 0 to lstDocTypes.Count - 1 do
    begin
      if ReadBool('DocumentTypes', 'DocumentTypeDefEditor'
      + IntToStr(i + 1), False) then
        MakeDefaultEditor(i + 1, True)
      else
        MakeDefaultEditor(i + 1, False);

      if ReadBool('DocumentTypes', 'DocumentTypeSysContext'
      + IntToStr(i + 1), False) then
        AddToSysContext(i + 1, True)
      else
        AddToSysContext(i + 1, False);
    end;

    // Common document types
    EraseSection('CommonDocumentTypes');
    Index := 1;

		for i := 0 to lstCommonDocTypes.Count - 1 do
   		if lstCommonDocTypes.Checked[i] then
      begin
    		WriteString('CommonDocumentTypes', 'DocumentType' + IntToStr(Index),
      		lstCommonDocTypes.Items[i]);
        Inc(Index);
      end;

    // Keyboard & Mouse
    WriteString('Mouse', 'GestureDown',
    	cmbGestureDown.Items[cmbGestureDown.ItemIndex]);
    WriteString('Mouse', 'GestureLeft',
    	cmbGestureLeft.Items[cmbGestureLeft.ItemIndex]);
    WriteString('Mouse', 'GestureRight',
    	cmbGestureRight.Items[cmbGestureRight.ItemIndex]);
    WriteString('Mouse', 'GestureUp',
    	cmbGestureUp.Items[cmbGestureUp.ItemIndex]);
    WriteString('Mouse', 'MiddleButton',
    	cmbMiddleButton.Items[cmbMiddleButton.ItemIndex]);
  end;

  DeleteFile(Settings.FileName);
  CopyFile(PChar(fSettingsCopy.FileName), PChar(Settings.FileName), False);

  with Settings do
  begin
  	// Document types
    EraseSection('DocumentTypes');
    SortedList := TStringList.Create;

    try
    	SortedList.Assign(lstDocTypes.Items);
      SortedList.Sort;

      for i := 0 to SortedList.Count -1 do
      begin
      	Index := Succ( lstDocTypes.Items.IndexOf(SortedList[i]) );

        for j := 0 to 3 do
        	WriteString('DocumentTypes', 'DocumentType' + DocTypeKeyNames[j]
						+ IntToStr(i + 1), fSettingsCopy.ReadString('DocumentTypes',
            'DocumentType' + DocTypeKeyNames[j] + IntToStr(Index), ''));
      end;
    finally
    	SortedList.Free;
    end;
  end;

  DeleteFile(fSettingsCopy.FileName);
	ModalResult := mrOK;
end;

procedure TOptionsDialog.lstDocTypesClick(Sender: TObject);
var
	Index: String;
begin
	if lstDocTypes.ItemIndex <> -1 then
  begin
  	Index := IntToStr(lstDocTypes.ItemIndex + 1);

  	with fSettingsCopy do
    begin
    	txtDocTypeName.Text := ReadString('DocumentTypes', 'DocumentTypeName'
      	+ Index, '');
      txtExtensions.Text := ReadString('DocumentTypes', 'DocumentTypeExtensions'
      	+ Index, '');
      txtSyntax.Text := ReadString('DocumentTypes', 'DocumentTypeSyntaxFile'
      	+ Index, '');
      txtRegExp.Text := ReadString('DocumentTypes', 'DocumentTypeFunctionRegExp'
      	+ Index, '');

      if not ValueExists('DocumentTypes', 'DocumentTypeDefEditor' + Index) then
      begin
        fSettingsCopy.WriteBool('DocumentTypes', 'DocumentTypeDefEditor' + Index,
          IsDefaultEditorOf(lstDocTypes.Items[lstDocTypes.ItemIndex]));

        fSettingsCopy.WriteBool('DocumentTypes', 'DocumentTypeSysContext' + Index,
          IsInContextMenuOf(lstDocTypes.Items[lstDocTypes.ItemIndex]));
      end;

      chkDefEditor.Checked := ReadBool('DocumentTypes', 'DocumentTypeDefEditor'
        + Index, False);
      chkSysContext.Checked := ReadBool('DocumentTypes', 'DocumentTypeSysContext'
        + Index, False);
    end;
  end;
end;

procedure TOptionsDialog.btnAddDocTypeClick(Sender: TObject);
var
	Index: String;
begin
	Index := IntToStr(lstDocTypes.Count + 1);

	with fSettingsCopy do
  begin
  	WriteString('DocumentTypes', 'DocumentTypeName' + Index,
    	'Document Type' + Index);
    lstDocTypes.Items.Add('Document Type' + Index);
    lstDocTypes.ItemIndex := lstDocTypes.Count - 1;
    lstDocTypesClick(nil);
    lstCommonDocTypes.Items.Add('Document Type' + Index);
    cmbDocType.Items.Add('Document Type' + Index);
    txtDocTypeName.Text := 'Document Type' + Index;
    txtDocTypeName.SetFocus;
  end;
end;

procedure TOptionsDialog.btnDeleteDocTypeClick(Sender: TObject);
var
	Index, Count, i, j: Integer;
begin
	Index := lstDocTypes.ItemIndex + 1;

  if Index <> 0 then
  begin
		with fSettingsCopy do
  	begin
      Count := lstDocTypes.Count - 1;

      // Move document types by one position
      for i := Index to Count do
      	for j := 0 to 3 do
        begin
      		WriteString('DocumentTypes', 'DocumentType' + DocTypeKeyNames[j] + IntToStr(i),
          	ReadString('DocumentTypes', 'DocumentType' + DocTypeKeyNames[j]
            + IntToStr(i + 1), ''));
      	end;

      // Delete last item
      Inc(Count);
      
      for i := 0 to 3 do
  			DeleteKey('DocumentTypes', 'DocumentType' + DocTypeKeyNames[i]
        	+ IntToStr(Count));
  	end;

    // Delete list items
    lstCommonDocTypes.Items.Delete(lstDocTypes.ItemIndex);
    cmbDocType.Items.Delete(lstDocTypes.ItemIndex + 1);
    lstDocTypes.DeleteSelected;

    if lstDocTypes.Count > 0 then
    begin
    	lstDocTypes.ItemIndex := 0;
      lstDocTypesClick(nil);
    end;
  end;
end;

procedure TOptionsDialog.txtDocTypeNameExit(Sender: TObject);
begin
  if lstDocTypes.Items.IndexOf(txtDocTypeName.Text) = -1 then
  begin
	  SetDocumentTypeProperty('Name', txtDocTypeName.Text);

    if lstDocTypes.ItemIndex <> -1 then
    begin
  	  lstDocTypes.Items[lstDocTypes.ItemIndex] := txtDocTypeName.Text;
      lstCommonDocTypes.Items[lstDocTypes.ItemIndex] := txtDocTypeName.Text;
      cmbDocType.Items[lstDocTypes.ItemIndex + 1] := txtDocTypeName.Text;
    end;
  end
  else
    txtDocTypeName.SetFocus;
end;

procedure TOptionsDialog.txtExtensionsExit(Sender: TObject);
begin
	SetDocumentTypeProperty('Extensions', txtExtensions.Text);
end;

procedure TOptionsDialog.txtSyntaxExit(Sender: TObject);
begin
	SetDocumentTypeProperty('SyntaxFile', txtSyntax.Text);
end;

procedure TOptionsDialog.txtRegExpExit(Sender: TObject);
begin
	SetDocumentTypeProperty('FunctionRegExp', txtRegExp.Text);
end;

procedure TOptionsDialog.btnSyntaxClick(Sender: TObject);
begin
	dlgOpen.InitialDir := AppPath + 'DocumentTypes';
  
	if dlgOpen.Execute then
  begin
  	txtSyntax.Text := ExtractFileName(dlgOpen.FileName);
		SetDocumentTypeProperty('SyntaxFile', ExtractFileName(dlgOpen.FileName));
  end;
end;

procedure TOptionsDialog.SetDocumentTypeProperty(PropertyName, Value: Variant);
begin
	if lstDocTypes.ItemIndex <> -1 then
    if VarType(Value) = varString	then
		  fSettingsCopy.WriteString('DocumentTypes', 'DocumentType' + PropertyName
        + IntToStr(lstDocTypes.ItemIndex + 1), Value)
    else if VarType(Value) = varBoolean	then
		  fSettingsCopy.WriteBool('DocumentTypes', 'DocumentType' + PropertyName
        + IntToStr(lstDocTypes.ItemIndex + 1), Value);
end;

procedure TOptionsDialog.btnFontClick(Sender: TObject);
begin
	if dlgFont.Execute then
  	btnFont.Caption := Format(sStrings[siFontButton],
    	[dlgFont.Font.Name, dlgFont.Font.Size]);
end;

procedure TOptionsDialog.ReadLanguageData;
var
	i: Integer;
begin
	with TMyIniFile.Create(Languages.Values[ActiveLanguage]) do
  try
  	Caption := ReadString('OptionsDialog', 'Caption', '');

  	for i := 0 to ComponentCount - 1 do
    	if (Components[i] is TControl) then
				(Components[i] as TControl).SetTextBuf( PChar(ReadString('OptionsDialog',
        	Components[i].Name + '.Caption', '')) );
  finally
		Free;
  end;
end;

procedure TOptionsDialog.lstKeyCatClick(Sender: TObject);
var
	i: Integer;
  Category: String;
begin
	if lstKeyCat.ItemIndex <> -1 then
  begin
  	lstKeyCmd.Clear;
  	Category := lstKeyCat.Items[lstKeyCat.ItemIndex];

  	with MainForm.actlMain do
    	for i := 0 to ActionCount - 1 do
      	if SameText(Category, Actions[i].Category) then
        	lstKeyCmd.AddItem(Actions[i].Name, Actions[i]);

    if lstKeyCmd.Count > 0 then
    begin
    	lstKeyCmd.ItemIndex := 0;
      lstKeyCmdClick(nil);
    end;  
  end;
end;

procedure TOptionsDialog.lstKeyCmdClick(Sender: TObject);
var
  Shortcut: String;
  P: Integer;
begin
  fSettingShortCut := True;
	Shortcut := fSettingsCopy.ReadString('Keyboard',
  	lstKeyCmd.Items[lstKeyCmd.ItemIndex], '');

  chkCtrl.Checked := Pos('Ctrl', Shortcut) > 0;
  chkShift.Checked := Pos('Shift', Shortcut) > 0;
  chkAlt.Checked := Pos('Alt', Shortcut) > 0;

  repeat
    P := Pos('+', Shortcut);
    
    if P = 0 then
      cmbShortCut.ItemIndex := cmbShortCut.Items.IndexOf(
        Copy(Shortcut, 1, MaxInt))
    else
      Delete(Shortcut, 1, P);
  until P = 0;

  fSettingShortCut := False;
  lblShortCutAssignedTo.Caption := '';
end;

procedure TOptionsDialog.FormDestroy(Sender: TObject);
begin
	CommandNames.Free;
end;

procedure TOptionsDialog.btnCancelClick(Sender: TObject);
begin
	DeleteFile(fSettingsCopy.FileName);
  ModalResult := mrCancel;
end;

procedure TOptionsDialog.lstCommonDocTypesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	P: TPoint;
  i, j, c: Integer;
begin
	P.X := X;
  P.Y := Y;
	i := lstCommonDocTypes.ItemAtPos(P, True);
  c := 0;

  for j := 0 to lstCommonDocTypes.Count - 1 do
  	if lstCommonDocTypes.Checked[j] then
    	Inc(c);

  if c = 10 then
  begin
  	Application.MessageBox( PChar(sStrings[siTenDocTypes]), 'Information',
    	MB_OK or MB_ICONINFORMATION);
  	lstCommonDocTypes.Checked[i] := False;
  end;
end;

procedure TOptionsDialog.chkDefEditorClick(Sender: TObject);
begin
	SetDocumentTypeProperty('DefEditor', chkDefEditor.Checked);
end;

procedure TOptionsDialog.chkSysContextClick(Sender: TObject);
begin
	SetDocumentTypeProperty('SysContext', chkSysContext.Checked);
end;

procedure TOptionsDialog.ShortcutAssigned;
var
	i: Integer;
  Shortcut: String;
begin
  lblShortCutAssignedTo.Caption := '';

  if not fSettingShortCut then
  begin
    Shortcut := ShortcutGet;

	  with MainForm.actlMain do
  	  for i := 0 to ActionCount - 1 do
  		  if (TAction(Actions[i]).ShortCut = TextToShortCut(Shortcut))
        and (Shortcut <> '') then
      	  lblShortCutAssignedTo.Caption := Actions[i].Name;
  end;
end;

procedure TOptionsDialog.ShortcutChanged;
begin
  if not fSettingShortCut then
	  fSettingsCopy.WriteString('Keyboard', lstKeyCmd.Items[lstKeyCmd.ItemIndex],
  	  ShortcutGet);
end;

function TOptionsDialog.ShortcutGet: String;
begin
  if chkCtrl.Checked then
    Result := 'Ctrl+';

  if chkShift.Checked then
    Result := Result + 'Shift+';

  if chkAlt.Checked then
    Result := Result + 'Alt+';

  if cmbShortCut.Items[cmbShortCut.ItemIndex] <> '' then
    Result := Result + cmbShortCut.Items[cmbShortCut.ItemIndex]
  else
    Result := '';
end;

procedure TOptionsDialog.chkCtrlClick(Sender: TObject);
begin
  ShortcutAssigned;
  ShortcutChanged;
end;

procedure TOptionsDialog.chkShiftClick(Sender: TObject);
begin
  ShortcutAssigned;
  ShortcutChanged;
end;

procedure TOptionsDialog.chkAltClick(Sender: TObject);
begin
  ShortcutAssigned;
  ShortcutChanged;
end;

procedure TOptionsDialog.cmbShortCutChange(Sender: TObject);
begin
  ShortcutAssigned;
  ShortcutChanged;
end;

function TOptionsDialog.GetClassNameFor(Extension: String): String;
begin
  Result := '';
  
  with TRegistry.Create do
  try
    RootKey := HKEY_CLASSES_ROOT;

    if OpenKey(Extension, False) then
    begin
      Result := ReadString('');
      CloseKey;
    end;
  finally
    Free;
  end;
end;

function TOptionsDialog.IsDefaultEditorOf(DocumentType: String): Boolean;
var
  DefEditor, RegClass: String;
  Extensions: TStringList;
  i: Integer;
begin
  Result := False;
  
  with TRegistry.Create do
  try
    RootKey := HKEY_CLASSES_ROOT;
    Extensions := TStringList.Create;
    GetExtensions(lstDocTypes.Items.IndexOf(DocumentType) + 1, Extensions);

    for i := 0 to Extensions.Count -1 do
    begin
      RegClass := GetClassNameFor(Extensions[i]);

      if (RegClass <> '')
      and (OpenKey(RegClass + '\shell\open\command', False)) then
      begin
        DefEditor := ReadString('');

        if i = 0 then
          Result := Pos(Application.ExeName, DefEditor) > 0
        else
          Result := (Result) and (Pos(Application.ExeName, DefEditor) > 0);
        CloseKey;
      end;
    end;
  finally
    Free;
  end;
end;

function TOptionsDialog.IsInContextMenuOf(DocumentType: String): Boolean;
var
  i: Integer;
  Extensions: TStringList;
begin
  Result := False;
  
  with TRegistry.Create do
  try
    RootKey := HKEY_CLASSES_ROOT;
    Extensions := TStringList.Create;
    GetExtensions(lstDocTypes.Items.IndexOf(DocumentType) + 1, Extensions);

    for i := 0 to Extensions.Count -1 do
      if i = 0 then
        Result := KeyExists(GetClassNameFor(Extensions[i]) + '\shell\Mystix')
      else
        Result := (Result) and (KeyExists(GetClassNameFor(Extensions[i]) + '\shell\Mystix'));
  finally
    Free;
  end;
end;

procedure TOptionsDialog.AddToSysContext(Index: Integer; Associate: Boolean);
var
	RegIniFile: TRegIniFile;
  Extensions: TStringList;
  i: Integer;
  RegClass: String;
begin
	RegIniFile := TRegIniFile.Create;

	with RegIniFile do
	try
		RootKey := HKEY_CLASSES_ROOT;
    Extensions := TStringList.Create;
    GetExtensions(Index, Extensions);

    for i := 0 to Extensions.Count - 1 do
    begin
      RegClass := GetClassNameFor(Extensions[i]);
      
		  if Associate then
		  begin
        if not KeyExists(RegClass + '\shell\Mystix') then
        begin
			    CreateKey(RegClass + '\shell\Mystix');
			    WriteString(RegClass + '\shell\Mystix', '', '&Mystix');
			    WriteString(RegClass + '\shell\Mystix\command', '',
				    '"' + Application.ExeName + '" "%1"');
        end;
		  end
		  else
			  TRegistry(RegIniFile).DeleteKey(RegClass + '\shell\Mystix');
    end;
	finally
		Free;
	end;
end;

procedure TOptionsDialog.MakeDefaultEditor(Index: Integer; Associate: Boolean);
var
	OldProgram: String;
  Extensions: TStringList;
  i: Integer;
begin
	with TRegistry.Create do
	try
		RootKey := HKEY_CLASSES_ROOT;
    Extensions := TStringList.Create;
    GetExtensions(Index, Extensions);

    for i := 0 to Extensions.Count - 1 do
		  if OpenKey(GetClassNameFor(Extensions[i]) + '\shell\open\command', True) then
		  begin
			  if Associate then
			  begin
				  OldProgram := ReadString('');

          if Pos(Application.ExeName, OldProgram) = 0 then
          begin
				    WriteString('OldProgram', OldProgram);
				    WriteString('', '"' + Application.ExeName + '" "%1"');
          end;
			  end
			  else
			  begin
				  OldProgram := ReadString('OldProgram');
				  WriteString('', OldProgram);
				  DeleteValue('OldProgram');
			  end;
        
			  CloseKey;
		  end;
	finally
		Free;
	end;
end;

procedure TOptionsDialog.GetExtensions(Index: Integer;
  Extensions: TStringList);
var
  ExtStr: String;
begin
  ExtStr := fSettingsCopy.ReadString('DocumentTypes', 'DocumentTypeExtensions'
    + IntToStr(Index), '');
  ExtractStrings([';'], [#9, #32], PChar(ExtStr), Extensions);
end;

end.
