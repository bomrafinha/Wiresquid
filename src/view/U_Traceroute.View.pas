unit U_Traceroute.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ipwcore,
  ipwtypes, ipwtraceroute, FMX.StdCtrls, FMX.Edit, FMX.Objects,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts,
  System.ImageList, FMX.ImgList, System.StrUtils;

type
  TTracerouteView = class(TForm)
    ImageList1: TImageList;
    LayoutContent: TLayout;
    MemoTrace: TMemo;
    LayoutHeader: TLayout;
    Layout1: TLayout;
    Text1: TText;
    Text2: TText;
    Edit1: TEdit;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    StatusBar1: TStatusBar;
    Text3: TText;
    ipwTraceRoute1: TipwTraceRoute;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ipwTraceRoute1Hop(Sender: TObject; HopNumber: Integer;
      const HostAddress: string; Duration: Integer);
  private
    { Private declarations }
  public
    constructor create(Sender : TComponent; address : String);
  end;


implementation

{$R *.fmx}

{ TForm2 }

constructor TTracerouteView.create(Sender: TComponent; address: String);
begin
  inherited Create(Sender);
  ipwTraceRoute1.Config('ReceiveAllMode=0');
  ipwTraceRoute1.LocalHost := address;

end;

procedure TTracerouteView.ipwTraceRoute1Hop(Sender: TObject; HopNumber: Integer;
  const HostAddress: string; Duration: Integer);
begin
  MemoTrace.Lines.Add(
    format(
      '%d  -  %s     %dms',
      [HopNumber, HostAddress, Duration]
    )
  );

end;

procedure TTracerouteView.SpeedButton1Click(Sender: TObject);
begin
  MemoTrace.Lines.Clear;
  if Edit1.Text <> EmptyStr then
  begin
    with ipwTraceRoute1 do
    begin
      HopLimit := ifThen(Edit2.Text <> EmptyStr, Edit2.Text, '64').ToInteger;
      RemoteHost := Edit1.Text;
      TraceTo(Edit1.Text);
    end;
  end;

end;

end.
