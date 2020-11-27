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
    Text4: TText;
    Timer1: TTimer;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ipwTraceRoute1Hop(Sender: TObject; HopNumber: Integer;
      const HostAddress: string; Duration: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    var
      fFim : boolean;
      fTempoTotal : Integer;
      fMediaTempo : Single;
      fTempo : TDateTime;

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
  if not fFim then
  begin
    inc(fTempoTotal, Duration);
    MemoTrace.Lines.Add(
      format(
        '%d  -  %s     %dms    %s',
        [HopNumber, HostAddress, Duration, ifthen(ipwTraceRoute1.Idle, 'Final', EmptyStr)]
      )
    );
    if ipwTraceRoute1.Idle then
    begin
      fMediaTempo := fTempoTotal / MemoTrace.Lines.Count;
      Text3.Text := Format(
        'Tempo total: %dms        Média: %.1fms',
        [fTempoTotal, fMediaTempo]
      );
      Timer1.Enabled := False;
      fFim := not fFim;
      ipwTraceRoute1.Reset;
    end;
  end;
end;

procedure TTracerouteView.SpeedButton1Click(Sender: TObject);
begin
  MemoTrace.Lines.Clear;
  fFim := False;
  fTempo := now();
  fTempoTotal := 0;
  fMediaTempo := 0;
  Text3.Text := EmptyStr;
  Timer1.Enabled := true;

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

procedure TTracerouteView.Timer1Timer(Sender: TObject);
begin
  Text4.Text := 'Processando: '+ FormatDateTime('hh:nn:ss',  now - fTempo);
end;

end.
