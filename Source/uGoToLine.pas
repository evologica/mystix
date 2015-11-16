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
unit uGoToLine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TGoToLineDialog = class(TForm)
    lblGoTo: TLabel;
    txtLine: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ReadLanguageData;
  public
    { Public declarations }
  end;

var
  GoToLineDialog: TGoToLineDialog;

implementation

uses uMyIniFiles, uMain;

{$R *.dfm}

{ TGoToLineDialog }

procedure TGoToLineDialog.ReadLanguageData;
var
	i: Integer;
begin
	with TMyIniFile.Create(Languages.Values[ActiveLanguage]) do
  try
  	Caption := ReadString('GoToLineDialog', 'Caption', '');
    
  	for i := 0 to ComponentCount - 1 do
    	if (Components[i] is TControl) then
				(Components[i] as TControl).SetTextBuf(PChar(ReadString('GoToLineDialog',
        	Components[i].Name + '.Caption', '')));
  finally
  	Free;
  end;
end;

procedure TGoToLineDialog.FormCreate(Sender: TObject);
begin
	ReadLanguageData;
end;

end.
