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
unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAboutDialog = class(TForm)
    Label1: TLabel;
    lblVersion: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    memContributors: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ReadLanguageData;
  public
    { Public declarations }
  end;

var
  AboutDialog: TAboutDialog;

implementation

uses uMain, uMyIniFiles, uUtils;

{$R *.dfm}

procedure TAboutDialog.FormCreate(Sender: TObject);
begin
	ReadLanguageData;

  if FileExists(AppPath + 'Contributors.txt') then
    memContributors.Lines.LoadFromFile(AppPath + 'Contributors.txt');
end;

procedure TAboutDialog.ReadLanguageData;
begin
	with TMyIniFile.Create(Languages.Values[ActiveLanguage]) do
  try
  	Caption := ReadString('AboutDialog', 'Caption', '');
		lblVersion.Caption := Format(ReadString('AboutDialog', 'lblVersion.Caption', ''), [ProjectVersion]);
  finally
  	Free;
  end;
end;

end.
