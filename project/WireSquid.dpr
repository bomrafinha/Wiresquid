program WireSquid;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_Main.View in '..\src\view\U_Main.View.pas' {MainView},
  U_Intial.View in '..\src\view\U_Intial.View.pas' {InitialView},
  U_Adapter.dto in '..\src\dto\U_Adapter.dto.pas',
  U_AdapterList.dto in '..\src\dto\U_AdapterList.dto.pas',
  U_Functions.Generics in '..\src\generics\U_Functions.Generics.pas',
  U_Strings.Enum in '..\src\enums\U_Strings.Enum.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
