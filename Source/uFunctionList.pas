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
unit uFunctionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvDockControlForm, JvDockVCStyle, JvComponent, StdCtrls, SynRegExpr,
  ExtCtrls, ComCtrls, JvDockVSNetStyle, JvDockVIDStyle, JvComponentBase;

type
  TFunctionListForm = class(TForm)
    JvDockClient: TJvDockClient;
    lvwFuncList: TListView;
    procedure lvwFuncListDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvwFuncListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
    fRegExpObj: TRegExpr;
    fRegExp: String;
  public
    { Public declarations }
    property RegExp: String read fRegExp write fRegExp;
    procedure UpdateFuncList;
    procedure Clear;
    procedure ReadLanguageData;
  end;

var
  FunctionListForm: TFunctionListForm;

implementation

uses uDocuments, uMain, uMyIniFiles;

{$R *.dfm}

{ TFunctionListForm }

procedure TFunctionListForm.lvwFuncListDblClick(Sender: TObject);
begin
	if lvwFuncList.ItemIndex <> -1 then
  begin
		Document.GoToLine(StrToInt(lvwFuncList.Items[lvwFuncList.ItemIndex].SubItems[0]));
    Document.Editor.SetFocus;
  end;
end;

procedure TFunctionListForm.UpdateFuncList;
begin
	lvwFuncList.Items.BeginUpdate;

	try
  	lvwFuncList.Clear;
		fRegExpObj.Expression := fRegExp;

		if (fRegExp <> '') and (fRegExpObj.Exec(Document.Editor.GetUncollapsedStrings.Text)) then
			repeat
      	with lvwFuncList.Items.Add do
        begin
					Caption := fRegExpObj.Match[0];

          with Document.Editor do
						SubItems.Add( IntToStr( GetRealLineNumber( CharIndexToRowCol( fRegExpObj.MatchPos[0] ).Line ) ) );
				end;
			until not fRegExpObj.ExecNext;
  finally
		lvwFuncList.Items.EndUpdate;
	end;
end;

procedure TFunctionListForm.FormCreate(Sender: TObject);
begin
	ReadLanguageData;
	fRegExpObj := TRegExpr.Create;
  fRegExpObj.ModifierM := True;
end;

procedure TFunctionListForm.FormDestroy(Sender: TObject);
begin
	fRegExpObj.Free;
end;

procedure TFunctionListForm.Clear;
begin
	lvwFuncList.Clear;
end;

procedure TFunctionListForm.lvwFuncListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
	Compare := CompareText(Item1.Caption, Item2.Caption);
end;

procedure TFunctionListForm.ReadLanguageData;
begin
	with TMyIniFile.Create(Languages.Values[ActiveLanguage]) do
  try
  	Caption := ReadString('FunctionListForm', 'Caption', '');
  finally
  	Free;
  end;
end;

end.
