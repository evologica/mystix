unit uPluginManager;

interface

uses
	SysUtils,
  Classes,
	{$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF LINUX}
  Libc,
  {$ENDIF}
  uPlugInDefinitions;
  
type
  TPlugin = class(TCollectionItem)
  private
  	fHandle: THandle;
    fName: String;
  public
  	destructor Destroy; override;
  	function GetProcAddress(aProc: String): Pointer;
  end;

	TPlugins = class(TCollection)
  private
    function GetItem(Index: Integer): TPlugin;
  public
  	function Add(Name: String): TPlugin;
		property Items[Index: Integer]: TPlugin read GetItem;
	end;

var
	Plugins: TPlugins;

implementation

uses uMain;

{ TPlugins }

function TPlugins.Add(Name: String): TPlugin;
var
	i, Handle: Integer;
begin
	for i := 0 to Count - 1 do
  	if SameText(Items[i].fName, Name) then
    begin
    	Result := Items[i];
    	Exit;
    end;

  {$IFDEF MSWINDOWS}
  Handle := LoadLibrary( PChar(AppPath + 'Plugins\' + Name + '.dll') );
  {$ENDIF}
  {$IFDEF LINUX}
  Handle := dlopen(AppPath + 'Plugins/' + Name + '.so', RTLD_LAZY);
  {$ENDIF}

  if Handle <> 0 then
  begin
  	Result := TPlugin( inherited Add );
  	Result.fName := Name;
    Result.fHandle := Handle;
  end
	else
  	Result := nil;
end;

function TPlugins.GetItem(Index: Integer): TPlugin;
begin
	Result := TPlugin( inherited GetItem(Index) ); 
end;

{ TPlugin }

destructor TPlugin.Destroy;
begin
	FreeLibrary(fHandle);
  inherited;
end;

function TPlugin.GetProcAddress(aProc: String): Pointer;
begin
	Result := nil; // To shut up the compiler
  
	if fHandle <> 0 then
  begin
  	{$IFDEF MSWINDOWS}
		Result := Windows.GetProcAddress( fHandle, PChar(aProc) );
    {$ENDIF}
    {$IFDEF LINUX}
		Result := dlsym(fHandle, aProc);
    {$ENDIF}
  end;
end;

initialization
	Plugins := TPlugins.Create(TPlugin);

finalization
	Plugins.Free;

end.
