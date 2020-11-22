unit U_Main.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, U_Intial.View,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, ipwcore, ipwtypes,
  ipwipmonitor, FMX.StdCtrls, ipwipinfo, U_Adapter.dto, U_AdapterList.dto,
  FMX.Layouts, FMX.Menus, U_Functions.Generics, FMX.Objects, U_Strings.Enum;

type
  TMainView = class(TForm)
    ipwIPMonitor1: TipwIPMonitor;
    Memo1: TMemo;
    Button1: TButton;
    ipwIPInfo1: TipwIPInfo;
    LayoutHeader: TLayout;
    PanelHeader: TPanel;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    MenuItem01Arquivo: TMenuItem;
    MenuItem02Fechar: TMenuItem;
    Timer1: TTimer;
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
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MenuItem02FecharClick(Sender: TObject);

  private
    var
      fAdapterIndex : Integer;
      fAdaptersList : TAdapterList;
      fFunctionsGenerics : TFunctionsGenerics;
      fLabelsPortuguese : TLabelsPortuguese;

    procedure setAdaptersInfo();
    procedure showIntialView();
    procedure setLabelsAdapter();

  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.fmx}

procedure TMainView.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to fAdaptersList.Count - 1 do
  begin
    with fAdaptersList[I] do
    begin
      Memo1.Lines.AddPair('AdapterDescription', AdapterDescription);            //
      Memo1.Lines.AddPair('AdapterGateway', AdapterGateway);   //
      Memo1.Lines.AddPair('AdapterIndex', AdapterIndex);//
      Memo1.Lines.AddPair('AdapterIPAddress', AdapterIPAddress);  //
      Memo1.Lines.AddPair('AdapterIPv6Address', AdapterIPv6Address); //
      Memo1.Lines.AddPair('AdapterPhysicalAddress', AdapterPhysicalAddress);  //
      Memo1.Lines.AddPair('AdapterSubnetMask', AdapterSubnetMask); //
      Memo1.Lines.AddPair('AdapterType', AdapterType); //
      Memo1.Lines.AddPair('LocalHost', LocalHost); //
      Memo1.Lines.AddPair('NodeType', NodeType);  //
    end;
  end;
end;

procedure TMainView.FormShow(Sender: TObject);
begin
  Self.fFunctionsGenerics := TFunctionsGenerics.Create();
  Self.fLabelsPortuguese := TLabelsPortuguese.Create();

  Self.fAdapterIndex := -1;
  Self.setAdaptersInfo();
  Self.showIntialView();


//  ipwIPMonitor1.Active := True;
//  ipwIPMonitor1.AcceptData := True;


end;

procedure TMainView.MenuItem02FecharClick(Sender: TObject);
begin
  Application.Terminate;

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
          NodeType
        )
      );
    end;
  end;

end;

procedure TMainView.setLabelsAdapter;
begin
  Text1.Text := Self.fLabelsPortuguese.MainView.Text01 + fAdaptersList[fAdapterIndex].AdapterDescription;
  Text2.Text := Self.fLabelsPortuguese.MainView.Text02 + fAdaptersList[fAdapterIndex].AdapterGateway;
  Text3.Text := Self.fLabelsPortuguese.MainView.Text03 + fAdaptersList[fAdapterIndex].AdapterIPAddress;
  Text4.Text := Self.fLabelsPortuguese.MainView.Text04 + fAdaptersList[fAdapterIndex].AdapterIPv6Address;
  Text5.Text := Self.fLabelsPortuguese.MainView.Text05 + fAdaptersList[fAdapterIndex].AdapterPhysicalAddress;
  Text6.Text := Self.fLabelsPortuguese.MainView.Text06 + fAdaptersList[fAdapterIndex].AdapterSubnetMask;
  Text7.Text := Self.fLabelsPortuguese.MainView.Text07 + fAdaptersList[fAdapterIndex].AdapterType;
  Text8.Text := Self.fLabelsPortuguese.MainView.Text08 + fAdaptersList[fAdapterIndex].LocalHost;
  Text9.Text := Self.fLabelsPortuguese.MainView.Text09 + fAdaptersList[fAdapterIndex].NodeType;
end;

procedure TMainView.showIntialView;
var
  initialView : TInitialView;

begin
  initialView := TInitialView.Create(Self, fAdaptersList);
  if initialView.ShowModal = mrOk then
  begin
    Self.fAdapterIndex := initialView.AdapterIndex;
    Self.setLabelsAdapter();
  end else begin
      if Self.fAdapterIndex = -1 then
      begin
        Application.Terminate;
      end;
  end;
  initialView.Free;

end;

end.
