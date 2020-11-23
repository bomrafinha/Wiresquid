unit U_Ping.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ipwcore,
  ipwtypes, ipwping, FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls;

type
  TPingView = class(TForm)
    ipwPing1: TipwPing;
    LayoutHeader: TLayout;
    LayoutContent: TLayout;
    MemoPong: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure ipwPing1Response(Sender: TObject; RequestId: Integer;
      const ResponseSource, ResponseStatus: string; ResponseTime: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    var
      execute : boolean;

    procedure ping();

  public
    constructor create(Sender : TComponent; address : String);
  end;

var
  PingView: TPingView;

implementation

{$R *.fmx}

{ TForm1 }

procedure TPingView.Button1Click(Sender: TObject);
begin
  execute := True;
  self.ping;

end;

procedure TPingView.Button2Click(Sender: TObject);
begin
  execute := False;

end;

constructor TPingView.create(Sender: TComponent; address: String);
begin
  inherited Create(Sender);
  ipwPing1.LocalHost := address;
  execute := False;
end;

procedure TPingView.FormShow(Sender: TObject);
begin
  MemoPong.Lines.Clear;

end;

procedure TPingView.ipwPing1Response(Sender: TObject; RequestId: Integer;
  const ResponseSource, ResponseStatus: string; ResponseTime: Integer);
begin
  MemoPong.Lines.Add(RequestId.ToString + ' - '  + ResponseSource + ' -> ' + ResponseStatus + ' -> ' + ResponseTime.ToString + ' ms');
  ipwPing1.Active := False;
//  if execute then
//  begin
//    Self.ping();
//  end;
end;

procedure TPingView.ping;
begin
  ipwPing1.PingHost('192.168.0.1');
end;

end.
