unit SynUniImport;

interface

uses
  Classes,
  SysUtils,
  SynUniClasses,
  SynUniRules;

type
  TSynUniImport = class
    constructor Create();
    function Import(Rules: TSynRange; Info: TSynInfo): boolean; virtual; abstract;
    function LoadFromStream(Stream: TStream): boolean; virtual; abstract;
    function LoadFromFile(FileName: string): boolean; virtual; abstract;
  end;

implementation

constructor TSynUniImport.Create();
begin
//
end;

end.
