unit uCodeExplorer;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  JvComponent,
  JvDockControlForm,
  JvDockVCStyle,
  ComCtrls,
  ImgList,
  uPlugInDefinitions,
  uPluginManager;

type
  TCodeExplorerForm = class(TForm)
    JvDockClient: TJvDockClient;
    JvDockVCStyle: TJvDockVCStyle;
    trvCodeExplorer: TTreeView;
    imglCodeExplorer: TImageList;
  private
    { Private declarations }
    fIndexArr: array of TTreeNode;
    fCodeExplorerGetItemInfo: TCodeExplorerGetItemInfo;
    fCodeExplorerInit: TCodeExplorerInit;
    procedure WMCodeExpAddItem(var Message: TMessage); message WM_CODEEXP_ADDITEM;
		procedure WMCodeExpBegin(var Message: TMessage); message WM_CODEEXP_BEGIN;
		procedure WMCodeExpEnd(var Message: TMessage); message WM_CODEXP_END;
		procedure WMCodeExpError(var Message: TMessage); message WM_CODEXP_ERROR;
  public
    { Public declarations }
    procedure ScanDocment;
  end;

var
  CodeExplorerForm: TCodeExplorerForm;

implementation

uses uDocuments, uMain, uUtils;

{$R *.dfm}

{ TCodeExplorerForm }

procedure TCodeExplorerForm.WMCodeExpAddItem(var Message: TMessage);
var
	Item: TCodeExplorerItem;
  Node, ParentNode: TTreeNode;
  Count: Integer;
begin
  ParentNode := nil;
	Count := High(fIndexArr);

  if fCodeExplorerGetItemInfo(Message.WParam, Item) then
  begin
    if Item.ParentIndex <> -1 then
			ParentNode := fIndexArr[Item.ParentIndex];

    Node := trvCodeExplorer.Items.AddChild(ParentNode, Item.Caption);
    Node.ImageIndex := Item.ImageIndex;

    if Count > Item.Index then
    	SetLength(fIndexArr, Succ(Count) + 100);

    fIndexArr[Item.Index] := Node;
  end;
end;

procedure TCodeExplorerForm.WMCodeExpBegin(var Message: TMessage);
begin
	trvCodeExplorer.Items.BeginUpdate;
  trvCodeExplorer.Items.Clear;
  fCodeExplorerGetItemInfo := Document.CodeExplorerPlugin.GetProcAddress('CodeExplorerGetItemInfo');
end;

procedure TCodeExplorerForm.WMCodeExpEnd(var Message: TMessage);
begin
	trvCodeExplorer.Items.Clear;
	trvCodeExplorer.Items.EndUpdate;
  Finalize(fIndexArr);
end;

procedure TCodeExplorerForm.WMCodeExpError(var Message: TMessage);
begin
	MainForm.StatusMsg('Error while parsing the document.', ErrorMsgColor, clWhite,
  	6000, True);
end;

procedure TCodeExplorerForm.ScanDocment;
var
	GrammarFile: String;
begin
	SetLength(fIndexArr, 100);
	GrammarFile := Settings.ReadString('DocumentTypes', 'DocumentTypeGrammarFile'
  	+ IntToStr( GetDocumentTypeIndex(Document.DocumentType) ), '');
  GrammarFile := AppPath + 'Grammars\' + GrammarFile;

  if FileExists(GrammarFile) then
  begin
		fCodeExplorerInit := Document.CodeExplorerPlugin.GetProcAddress('CodeExplorerInit');
		fCodeExplorerInit( PChar(Document.Code), PChar(GrammarFile), Handle );
  end;
end;

end.
