unit U_Arp.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ipwipmonitor,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, ipwcore, ipwtypes;

type
  TArpView = class(TForm)
    MemoIPs: TMemo;
    ipwIPMonitor1: TipwIPMonitor;
    procedure ipwIPMonitor1IPAddress(Sender: TObject; const IpAddress: string);
    procedure FormShow(Sender: TObject);
  public
    constructor Create(Sender : TComponent; aipwIPMonitor1 : TipwIPMonitor);
  end;

implementation

{$R *.fmx}

{ TArpView }

constructor TArpView.Create(Sender: TComponent; aipwIPMonitor1: TipwIPMonitor);
begin
  inherited Create(Sender);
  ipwIPMonitor1 := aipwIPMonitor1;

end;

procedure TArpView.FormShow(Sender: TObject);
begin
  MemoIPs.Lines.Clear;
  ipwIPMonitor1.ListIPAddresses();

end;

procedure TArpView.ipwIPMonitor1IPAddress(Sender: TObject;
  const IpAddress: string);
begin
  MemoIPs.Lines.Add(IpAddress);

end;

end.
