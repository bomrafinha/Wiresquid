unit U_Main.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, U_Intial.View,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, ipwcore, ipwtypes,
  ipwipmonitor, FMX.StdCtrls, ipwipinfo, U_Adapter.dto, U_AdapterList.dto,
  FMX.Layouts, FMX.Menus, FMX.Objects, U_Translation, System.strUtils,
  U_Portuguese, System.Rtti, FMX.Grid.Style, FMX.Grid,
  System.ImageList, FMX.ImgList, U_Generic.Functions, FMX.TreeView,
  Winapi.Windows, U_Arp.View, U_Ping.View, U_Traceroute.View, Winapi.ShlObj;

type
  TMainView = class(TForm)
    ipwIPMonitor1: TipwIPMonitor;
    ipwIPInfo1: TipwIPInfo;
    LayoutHeader: TLayout;
    PanelHeader: TPanel;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    MenuItem01Arquivo: TMenuItem;
    MenuItem02Fechar: TMenuItem;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    LayoutInfoLinha01: TLayout;
    LayoutInfoLinha03: TLayout;
    LayoutInfoLinha02: TLayout;
    LayoutContent: TLayout;
    StringGridDadosCaptados: TStringGrid;
    ImageList1: TImageList;
    MenuItem01Idioma: TMenuItem;
    MenuItem02Portugues: TMenuItem;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    StringColumn9: TStringColumn;
    StringColumn10: TStringColumn;
    StringColumn11: TStringColumn;
    StringColumn12: TStringColumn;
    StringColumn13: TStringColumn;
    StringColumn14: TStringColumn;
    StringColumn15: TStringColumn;
    Timer1: TTimer;
    Text10: TText;
    Text11: TText;
    Text12: TText;
    LayoutExtraInfo: TLayout;
    Text13: TText;
    MemoData: TMemo;
    TreeViewData: TTreeView;
    MenuItem01Ferramentas: TMenuItem;
    MenuItem01Ajuda: TMenuItem;
    MenuItem02Ping: TMenuItem;
    MenuItem02Arp: TMenuItem;
    MenuItem02Traceroute: TMenuItem;
    MenuItem02Sobre: TMenuItem;
    Text14: TText;
    StringColumn16: TStringColumn;
    MenuItemSalvar: TMenuItem;
    SpeedButton4: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure MenuItem02FecharClick(Sender: TObject);
    procedure ipwIPMonitor1IPPacket(Sender: TObject;
      const SourceAddress: string; SourcePort: Integer;
      const DestinationAddress: string; DestinationPort, IPVersion, TOS, Id,
      Flags, Offset, TTL, Checksum, IPProtocol: Integer; Payload: string;
      PayloadB: TArray<System.Byte>; Timestamp: Int64);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Text11Click(Sender: TObject);
    procedure StringGridDadosCaptadosResize(Sender: TObject);
    procedure StringGridDadosCaptadosSelectCell(Sender: TObject; const ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure MenuItem02ArpClick(Sender: TObject);
    procedure MenuItem02PingClick(Sender: TObject);
    procedure MenuItem02TracerouteClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);

  private
    var
      fAdapterIndex : Integer;
      fAdaptersList : TAdapterList;
      fGenericsFunctions : TGenericsFunctions;
      fTempoInicioGrid : TDateTime;
      fTempoStatusbar : TDateTime;

    procedure setAdaptersInfo();
    procedure showIntialView();
    procedure setLabelsAdapterInfo();
    procedure setTreeView(row : Integer);
    procedure setLabels();

  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.fmx}

procedure TMainView.FormShow(Sender: TObject);
begin
//  ipwIPMonitor1.Config('CodePage=1252');
//  ipwIPMonitor1.Config('CodePage=65001');
//  ipwIPMonitor1.Config('CodePage=858');
  ipwIPMonitor1.Config('CodePage=' + getACP().ToString);
  Self.fGenericsFunctions := TGenericsFunctions.Create();

  Self.setLabels();
  Self.fAdapterIndex := -1;
  Self.setAdaptersInfo();
  Self.showIntialView();

end;

procedure TMainView.ipwIPMonitor1IPPacket(Sender: TObject;
  const SourceAddress: string; SourcePort: Integer;
  const DestinationAddress: string; DestinationPort, IPVersion, TOS, Id, Flags,
  Offset, TTL, Checksum, IPProtocol: Integer; Payload: string;
  PayloadB: TArray<System.Byte>; Timestamp: Int64);
begin
  if StringGridDadosCaptados.RowCount > 0 then
  begin
    MenuItemSalvar.Enabled := True;
    SpeedButton4.Enabled := True;
  end else begin
    MenuItemSalvar.Enabled := False;
    SpeedButton4.Enabled := False;
  end;
  StringGridDadosCaptados.RowCount := StringGridDadosCaptados.RowCount + 1;
  StringGridDadosCaptados.Cells[0, StringGridDadosCaptados.RowCount - 1] := StringGridDadosCaptados.RowCount.ToString;
  StringGridDadosCaptados.Cells[1, StringGridDadosCaptados.RowCount - 1] := SourceAddress;
  StringGridDadosCaptados.Cells[2, StringGridDadosCaptados.RowCount - 1] := SourcePort.ToString;
  StringGridDadosCaptados.Cells[3, StringGridDadosCaptados.RowCount - 1] := DestinationAddress;
  StringGridDadosCaptados.Cells[4, StringGridDadosCaptados.RowCount - 1] := DestinationPort.ToString;
  StringGridDadosCaptados.Cells[5, StringGridDadosCaptados.RowCount - 1] := 'IPv' + IPVersion.ToString;
  StringGridDadosCaptados.Cells[6, StringGridDadosCaptados.RowCount - 1] := Self.fGenericsFunctions.getProtocol(IPProtocol);
  StringGridDadosCaptados.Cells[7, StringGridDadosCaptados.RowCount - 1] := TTL.ToString;
  StringGridDadosCaptados.Cells[8, StringGridDadosCaptados.RowCount - 1] := Id.ToString;
  StringGridDadosCaptados.Cells[9, StringGridDadosCaptados.RowCount - 1] := Checksum.ToString;
  StringGridDadosCaptados.Cells[10, StringGridDadosCaptados.RowCount - 1] := Self.fGenericsFunctions.getTOS(TOS);
  StringGridDadosCaptados.Cells[11, StringGridDadosCaptados.RowCount - 1] := Self.fGenericsFunctions.getFlags(Flags);
  StringGridDadosCaptados.Cells[12, StringGridDadosCaptados.RowCount - 1] := Offset.ToString;
  StringGridDadosCaptados.Cells[13, StringGridDadosCaptados.RowCount - 1] := FormatDateTime('nn:ss.zzz', fGenericsFunctions.getElapsedTime(fTempoInicioGrid));
  StringGridDadosCaptados.Cells[14, StringGridDadosCaptados.RowCount - 1] := Payload;
  StringGridDadosCaptados.Cells[15, StringGridDadosCaptados.RowCount - 1] := Self.fGenericsFunctions.intToBinStr(TOS, 8);
  Text14.Text := TTranslation<TPortuguese>.Language.MainView.FooterText14 + StringGridDadosCaptados.RowCount.ToString;

end;

procedure TMainView.MenuItem02ArpClick(Sender: TObject);
var
  arpView : TArpView;

begin
  arpView := TArpView.Create(Self, ipwIPMonitor1.LocalHost);
  arpView.ShowModal;
  arpView.Free;

end;

procedure TMainView.MenuItem02FecharClick(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TMainView.MenuItem02PingClick(Sender: TObject);
var
  pingView : TPingView;

begin
  pingView := TPingView.Create(Self, fAdaptersList[fAdapterIndex].AdapterIPAddress);
  pingView.ShowModal;
  pingView.Free;

end;

procedure TMainView.MenuItem02TracerouteClick(Sender: TObject);
var
  traceView : TTracerouteView;

begin
  traceView := TTracerouteView.Create(Self, fAdaptersList[fAdapterIndex].AdapterIPAddress);
  traceView.ShowModal;
  traceView.Free;

end;

procedure TMainView.setAdaptersInfo;
var
  I: Integer;
begin
  fAdaptersList := TAdapterList.Create();
  with ipwIPInfo1 do
  begin
    for I := 0 to AdapterCount - 1 do
    begin
      AdapterIndex := I;
      fAdaptersList.Add(
        TAdapter.Create(
          AdapterDescription,
          AdapterGateway,
          AdapterIndex.ToString,
          AdapterIPAddress,
          AdapterIPv6Address,
          AdapterPhysicalAddress,
          AdapterSubnetMask,
          AdapterType,
          LocalHost,
          NodeType,
          AdapterDeviceIndex.ToString,
          AdapterName,
          AdapterStatus
        )
      );
    end;
  end;

end;

procedure TMainView.setLabels;
begin
  Text13.Text := TTranslation<TPortuguese>.Language.MainView.FooterText13_01;

  MenuItem01Arquivo.Text := TTranslation<TPortuguese>.Language.MainView.Menu01_Arquivo;
  MenuItem02Fechar.Text := TTranslation<TPortuguese>.Language.MainView.Menu02_Fechar;

  MenuItem01Ferramentas.Text := TTranslation<TPortuguese>.Language.MainView.Menu01_Ferramentas;
  MenuItem02Ping.Text := TTranslation<TPortuguese>.Language.MainView.Menu02_Ping;
  MenuItem02Arp.Text := TTranslation<TPortuguese>.Language.MainView.Menu02_Arp;
  MenuItem02Traceroute.Text := TTranslation<TPortuguese>.Language.MainView.Menu02_Traceroute;

  MenuItem01Idioma.Text := TTranslation<TPortuguese>.Language.MainView.Menu01_Idiona;
  MenuItem02Portugues.Text := TTranslation<TPortuguese>.Language.MainView.Menu02_Portugues;

  MenuItem01Ajuda.Text := TTranslation<TPortuguese>.Language.MainView.Menu01_Ajuda;
  MenuItem02Sobre.Text := TTranslation<TPortuguese>.Language.MainView.Menu02_Sobre;

  SpeedButton1.Hint := TTranslation<TPortuguese>.Language.MainView.ToolBar_Button01;
  SpeedButton2.Hint := TTranslation<TPortuguese>.Language.MainView.ToolBar_Button02;
  SpeedButton3.Hint := TTranslation<TPortuguese>.Language.MainView.ToolBar_Button03;

  StringColumn1.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn01;
  StringColumn2.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn02;
  StringColumn3.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn03;
  StringColumn4.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn04;
  StringColumn5.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn05;
  StringColumn6.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn06;
  StringColumn7.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn07;
  StringColumn8.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn08;
  StringColumn9.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn09;
  StringColumn10.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn10;
  StringColumn11.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn11;
  StringColumn12.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn12;
  StringColumn13.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn13;
  StringColumn14.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn14;
  StringColumn15.Header := TTranslation<TPortuguese>.Language.MainView.GridColumn15;

end;

procedure TMainView.setLabelsAdapterInfo;
begin
  Text1.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText01 + fAdaptersList[fAdapterIndex].AdapterDescription;
  Text2.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText02 + fAdaptersList[fAdapterIndex].AdapterGateway;
  Text3.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText03 + fAdaptersList[fAdapterIndex].AdapterIPAddress;
  Text4.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText04 + fAdaptersList[fAdapterIndex].AdapterIPv6Address;
  Text5.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText05 + fAdaptersList[fAdapterIndex].AdapterPhysicalAddress;
  Text6.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText06 + fAdaptersList[fAdapterIndex].AdapterSubnetMask;
  Text7.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText07 + fAdaptersList[fAdapterIndex].AdapterType;
  Text8.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText08 + fAdaptersList[fAdapterIndex].LocalHost;
  Text9.Text := TTranslation<TPortuguese>.Language.MainView.HeaderText09 + fAdaptersList[fAdapterIndex].NodeType;

end;

procedure TMainView.setTreeView(row: Integer);
var
  Item01Interface : TTreeViewItem;
  Item01Flags : TTreeViewItem;
  Item01Tos: TTreeViewItem;

  Item02DeviceIndex : TTreeViewItem;
  Item02DeviceName : TTreeViewItem;
  Item02DeviceMAC : TTreeViewItem;
  Item02DeviceDescription : TTreeViewItem;
  Item02DeviceStatus : TTreeViewItem;
  Item02Flag01 : TTreeViewItem;
  Item02Flag02 : TTreeViewItem;
  Item02Flag03 : TTreeViewItem;
  Item02Tos01 : TTreeViewItem;
  Item02Tos02 : TTreeViewItem;
  Item02Tos03 : TTreeViewItem;
  Item02Tos04 : TTreeViewItem;

  flags : String;
  tos : String;
  aux: string;

begin
  TreeViewData.Clear;
  Item01Interface := TTreeViewItem.Create(Self);
  Item01Interface.Text := TTranslation<TPortuguese>.Language.MainView.TreeView01_Interface;
  Item01Interface.Parent := TreeViewData;

  Item02DeviceIndex := TTreeViewItem.Create(Self);
  Item02DeviceIndex.Text := TTranslation<TPortuguese>.Language.MainView.TreeView02_DeviceIndex + fAdaptersList[fAdapterIndex].DeviceIndex;
  Item02DeviceIndex.Parent := Item01Interface;

  Item02DeviceName := TTreeViewItem.Create(Self);
  Item02DeviceName.Text := TTranslation<TPortuguese>.Language.MainView.TreeView02_DeviceName + fAdaptersList[fAdapterIndex].DeviveName;
  Item02DeviceName.Parent := Item01Interface;

  Item02DeviceMAC := TTreeViewItem.Create(Self);
  Item02DeviceMAC.Text := TTranslation<TPortuguese>.Language.MainView.TreeView02_DeviceMAC + fAdaptersList[fAdapterIndex].AdapterPhysicalAddress;
  Item02DeviceMAC.Parent := Item01Interface;

  Item02DeviceDescription := TTreeViewItem.Create(Self);
  Item02DeviceDescription.Text := TTranslation<TPortuguese>.Language.MainView.TreeView02_DeviceDescription + fAdaptersList[fAdapterIndex].AdapterDescription;
  Item02DeviceDescription.Parent := Item01Interface;

  Item02DeviceStatus := TTreeViewItem.Create(Self);
  Item02DeviceStatus.Text := TTranslation<TPortuguese>.Language.MainView.TreeView02_DeviceStatus + fAdaptersList[fAdapterIndex].DeviveStatus;
  Item02DeviceStatus.Parent := Item01Interface;


  flags := StringGridDadosCaptados.Cells[11, row];

  Item01Flags := TTreeViewItem.Create(Self);
  Item01Flags.Text := 'Flags ' + flags;
  Item01Flags.Parent := TreeViewData;

  aux := ifThen((copy(flags, 1, 1) = '0'), ' Not', EmptyStr);
  Item02Flag01 := TTreeViewItem.Create(Self);
  Item02Flag01.Text := format('Reserved bit:%s Set', [aux]);
  Item02Flag01.Parent := Item01Flags;

  aux := ifThen((copy(flags, 2, 1) = '0'), ' Not', EmptyStr);
  Item02Flag01 := TTreeViewItem.Create(Self);
  Item02Flag01.Text := format('Don' +#39 +'t Fragment:%s Set', [aux]);
  Item02Flag01.Parent := Item01Flags;

  aux := ifThen((copy(flags, 3, 1) = '0'), ' Not', EmptyStr);
  Item02Flag01 := TTreeViewItem.Create(Self);
  Item02Flag01.Text := format('More Fragments:%s Set', [aux]);
  Item02Flag01.Parent := Item01Flags;


  tos := StringGridDadosCaptados.Cells[15, row];

  Item01Tos := TTreeViewItem.Create(Self);
  Item01Tos.Text := 'Type of Service ' + StringGridDadosCaptados.Cells[10, row];
  Item01Tos.Parent := TreeViewData;

  aux := copy(tos, 1, 3);
  Item02Tos01 := TTreeViewItem.Create(Self);
  Item02Tos01.Text := format('Precedence: %s', [aux]);
  Item02Tos01.Parent := Item01Tos;

  aux := ifThen((copy(tos, 4, 1) = '0'), 'Normal', 'Low');
  Item02Tos02 := TTreeViewItem.Create(Self);
  Item02Tos02.Text := format('Delay: %s', [aux]);
  Item02Tos02.Parent := Item01Tos;

  aux := ifThen((copy(tos, 5, 1) = '0'), 'Normal', 'High');
  Item02Tos03 := TTreeViewItem.Create(Self);
  Item02Tos03.Text := format('Throughput: %s', [aux]);
  Item02Tos03.Parent := Item01Tos;

  aux := ifThen((copy(tos, 6, 1) = '0'), 'Normal', 'High');
  Item02Tos04 := TTreeViewItem.Create(Self);
  Item02Tos04.Text := format('Reliability: %s', [aux]);
  Item02Tos04.Parent := Item01Tos;

end;

procedure TMainView.showIntialView;
var
  initialView : TInitialView;

begin
  initialView := TInitialView.Create(Self, fAdaptersList);
  if initialView.ShowModal = mrOk then
  begin
    if Self.fAdapterIndex <> initialView.AdapterIndex then
    begin
      StringGridDadosCaptados.RowCount := 0;
      Text12.Text := EmptyStr;
      Text14.Text := EmptyStr;
    end;
    Self.fAdapterIndex := initialView.AdapterIndex;
    Self.setLabelsAdapterInfo();
  end else begin
      if Self.fAdapterIndex = -1 then
      begin
        Application.Terminate;
      end;
  end;
  initialView.Free;

end;

procedure TMainView.SpeedButton1Click(Sender: TObject);
begin
  Self.showIntialView();

end;

procedure TMainView.SpeedButton2Click(Sender: TObject);
begin
  Text13.Text := TTranslation<TPortuguese>.Language.MainView.FooterText13_02;
  fTempoInicioGrid := now();
  fTempoStatusbar := now();
  Timer1.Enabled := True;
  ipwIPMonitor1.LocalHost := fAdaptersList[fAdapterIndex].AdapterIPAddress;
  ipwIPMonitor1.Active := True;
  ipwIPMonitor1.AcceptData := True;

end;

procedure TMainView.SpeedButton3Click(Sender: TObject);
begin
  Text13.Text := TTranslation<TPortuguese>.Language.MainView.FooterText13_01;
  ipwIPMonitor1.Active := False;
  ipwIPMonitor1.AcceptData := False;
  Timer1.Enabled := False;

end;

procedure TMainView.SpeedButton4Click(Sender: TObject);
var
  csv : TStringList;
  I: Integer;
  linha : String;
  pasta : String;
  arquivo : String;

begin
  csv := TStringList.Create;
  csv.Clear();
  linha := EmptyStr;

  for I := 0 to StringGridDadosCaptados.ColumnCount - 3 do
  begin
    linha := format(
      '%s' + #34 + '%s' + #34 + '%s',
      [
        linha,
        StringGridDadosCaptados.ColumnByIndex(I).Header,
        IfThen(StringGridDadosCaptados.ColumnCount <> I + 3, #44, EmptyStr)
      ]
    );
  end;
  csv.Add(linha);

  for I := 0 to StringGridDadosCaptados.RowCount do
  begin
    csv.Add(
      Format(
        '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s',
        [
          StringGridDadosCaptados.Cells[0, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[1, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[2, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[3, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[4, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[5, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[6, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[7, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[8, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[9, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[10, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[11, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[12, I].QuotedString('"'),
          StringGridDadosCaptados.Cells[13, I].QuotedString('"')
        ]
      )
    );
  end;

  fGenericsFunctions.getSpecialFolder(CSIDL_DESKTOP ,pasta);
  SaveDialog1.InitialDir := pasta;
  if SaveDialog1.Execute then
  begin
    csv.SaveToFile(SaveDialog1.FileName);
  end;

end;

procedure TMainView.StringGridDadosCaptadosResize(Sender: TObject);
begin
  StringColumn15.Width :=
    StringGridDadosCaptados.Width - (
    StringColumn1.Width +
    StringColumn2.Width +
    StringColumn3.Width +
    StringColumn4.Width +
    StringColumn5.Width +
    StringColumn6.Width +
    StringColumn7.Width +
    StringColumn8.Width +
    StringColumn9.Width +
    StringColumn10.Width +
    StringColumn11.Width +
    StringColumn12.Width +
    StringColumn13.Width +
    StringColumn14.Width);

    MemoData.Width := (LayoutExtraInfo.Width - 20) / 2;
    TreeViewData.Width := MemoData.Width;

end;

procedure TMainView.StringGridDadosCaptadosSelectCell(Sender: TObject;
  const ACol, ARow: Integer; var CanSelect: Boolean);
begin
  MemoData.ClearSelection;
  MemoData.Text := StringGridDadosCaptados.Cells[14, ARow];
  Self.setTreeView(ARow);

end;

procedure TMainView.Text11Click(Sender: TObject);
begin
  Self.fGenericsFunctions.launchBrowser(Text11.Text);
end;

procedure TMainView.Timer1Timer(Sender: TObject);
begin
  Text12.Text := FormatDateTime('hh:nn:ss', now() - fTempoStatusbar)

end;

end.
