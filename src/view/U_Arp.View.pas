unit U_Arp.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ipwipmonitor,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, ipwcore, ipwtypes,
  ipwicmpport;

type
  TArpView = class(TForm)
    MemoIPs: TMemo;
    ipwICMPPort1: TipwICMPPort;
    procedure FormShow(Sender: TObject);
    procedure ipwICMPPort1DataIn(Sender: TObject; MessageType,
      MessageSubType: Integer; MessageData: string;
      MessageDataB: TArray<System.Byte>; Checksum: Integer;
      const SourceAddress: string);
  public
    constructor Create(Sender: TComponent; address : String);
  end;

implementation

{$R *.fmx}

{ TArpView }

constructor TArpView.Create(Sender: TComponent; address : String);
begin
  inherited Create(Sender);
  ipwICMPPort1.LocalHost := address;

end;

procedure TArpView.FormShow(Sender: TObject);
begin
  MemoIPs.Lines.Clear;
  ipwICMPPort1.Active := True;

end;

procedure TArpView.ipwICMPPort1DataIn(Sender: TObject; MessageType,
  MessageSubType: Integer; MessageData: string;
  MessageDataB: TArray<System.Byte>; Checksum: Integer;
  const SourceAddress: string);
begin
  MemoIPs.Lines.Add(SourceAddress);

end;

end.
