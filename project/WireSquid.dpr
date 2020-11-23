program WireSquid;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_Main.View in '..\src\view\U_Main.View.pas' {MainView},
  U_Intial.View in '..\src\view\U_Intial.View.pas' {InitialView},
  U_Adapter.dto in '..\src\dto\U_Adapter.dto.pas',
  U_AdapterList.dto in '..\src\dto\U_AdapterList.dto.pas',
  U_Portuguese in '..\src\translation\U_Portuguese.pas',
  U_Translation in '..\src\translation\U_Translation.pas',
  U_Generic.Functions in '..\src\generic\U_Generic.Functions.pas',
  U_Arp.View in '..\src\view\U_Arp.View.pas' {ArpView},
  U_Ping.View in '..\src\view\U_Ping.View.pas' {PingView},
  U_Traceroute.View in '..\src\view\U_Traceroute.View.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.CreateForm(TPingView, PingView);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
