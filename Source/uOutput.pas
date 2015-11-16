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
unit uOutput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvDockControlForm, JvComponent, JvDockVCStyle, StdCtrls,
  JvTabBar, JvDockVSNetStyle, JvDockVIDStyle;

type
  TOutputForm = class(TForm)
    JvDockClient: TJvDockClient;
    Memo1: TMemo;
    tbOutputs: TJvTabBar;
    JvModernTabBarPainter: TJvModernTabBarPainter;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadLanguageData;
  end;

var
  OutputForm: TOutputForm;

implementation

uses uMain, uMyIniFiles;

{$R *.dfm}

{ TOutputForm }

procedure TOutputForm.ReadLanguageData;
begin
	with TMyIniFile.Create(Languages.Values[ActiveLanguage]) do
  try
  	Caption := ReadString('OutputForm', 'Caption', '');
  finally
  	Free;
  end;
end;

procedure TOutputForm.FormCreate(Sender: TObject);
begin
	ReadLanguageData;
end;

end.
