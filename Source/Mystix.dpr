program Mystix;

{%ToDo 'Mystix.todo'}

uses
  Forms,
  uOneInstance in 'uOneInstance.pas',
  uMain in 'uMain.pas' {MainForm},
  uDocuments in 'uDocuments.pas',
  uMyIniFiles in 'uMyIniFiles.pas',
  uFind in 'uFind.pas' {FindDialog},
  uAbout in 'uAbout.pas' {AboutDialog},
  uReplace in 'uReplace.pas' {ReplaceDialog},
  uMRU in 'uMRU.pas',
  uGoToLine in 'uGoToLine.pas' {GoToLineDialog},
  uProject in 'uProject.pas' {ProjectForm},
  uUtils in 'uUtils.pas',
  uFunctionList in 'uFunctionList.pas' {FunctionListForm},
  uOutput in 'uOutput.pas' {OutputForm},
  uOptions in 'uOptions.pas' {OptionsDialog},
  uConfirmReplace in 'uConfirmReplace.pas' {ConfirmReplaceDialog},
  uExSynEdit in 'uExSynEdit.pas';


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
