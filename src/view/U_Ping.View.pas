unit U_Ping.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ipwcore,
  ipwtypes, ipwping, FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls, System.ImageList, FMX.ImgList, FMX.Edit, FMX.Objects,
  System.StrUtils;

type
  TPingView = class(TForm)
    ipwPing1: TipwPing;
    LayoutHeader: TLayout;
    LayoutContent: TLayout;
    MemoPong: TMemo;
    Layout1: TLayout;
    Text1: TText;
    Text2: TText;
    Edit1: TEdit;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    Text3: TText;
    procedure FormShow(Sender: TObject);
    procedure ipwPing1Response(Sender: TObject; RequestId: Integer;
      const ResponseSource, ResponseStatus: string; ResponseTime: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    var
      fOK : integer;
      fPerdidos : integer;
      fMedia : Integer;
    procedure ping();

  public
    constructor create(Sender : TComponent; address : String);
  end;

implementation

{$R *.fmx}

{ TForm1 }

constructor TPingView.create(Sender: TComponent; address: String);
begin
  inherited Create(Sender);
  ipwPing1.Config('ReceiveAllMode=0');
  ipwPing1.LocalHost := address;
end;

procedure TPingView.FormShow(Sender: TObject);
begin
  MemoPong.Lines.Clear;

end;

procedure TPingView.ipwPing1Response(Sender: TObject; RequestId: Integer;
  const ResponseSource, ResponseStatus: string; ResponseTime: Integer);
begin
  MemoPong.Lines.Add(
    format(
      'Resposta de %s  ->  bytes=%d tempo=%dms',
      [ResponseSource, ipwPing1.PacketSize, ResponseTime]
    )
  );
  if ResponseStatus = 'OK' then
  begin
    inc(fOK, 1);
  end else begin
    inc(fPerdidos, 1);
  end;

  inc(fMedia, ResponseTime);

  Text3.Text:= format(
    'Total de pacotes: %d      Sucesso: %d        Perda: %d         Média de Tempo: %dms',
    [fOK + fPerdidos, fOK, fPerdidos, fMedia div fOK]
  );

end;

procedure TPingView.ping;
begin
  ipwPing1.PingHost(Edit1.Text);
end;

procedure TPingView.SpeedButton1Click(Sender: TObject);
begin
  fPerdidos := 0;
  fOK := 0;
  fMedia := 0;
  MemoPong.Lines.Clear;
  if Edit1.Text <> EmptyStr then
  begin
    with ipwPing1 do
    begin
      PacketSize := ifThen(Edit2.Text <> EmptyStr, Edit2.Text, '32').ToInteger;
      RemoteHost := Edit1.Text;
      Active := True;
      Timer1.Enabled := True;
    end;
  end;

end;

procedure TPingView.SpeedButton2Click(Sender: TObject);
begin
  Timer1.Enabled := False;
  ipwPing1.Active := False;

end;

procedure TPingView.Timer1Timer(Sender: TObject);
begin
  ping();
end;

end.


