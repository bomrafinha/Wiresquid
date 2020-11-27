unit U_Intial.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, System.ImageList, FMX.ImgList, U_AdapterList.dto, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, Data.DB,
  Datasnap.DBClient, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.StdCtrls, U_Portuguese, U_Translation;

type
  TInitialView = class(TForm)
    ImageLogo: TImage;
    LayoutContent: TLayout;
    RectangleContent: TRectangle;
    LayoutOperation: TLayout;
    LayoutLogo: TLayout;
    LayoutHeader: TLayout;
    LayoutClose: TLayout;
    CircleClose: TCircle;
    ImageCloseClick: TImage;
    ImageClose: TImage;
    StringGridAdapters: TStringGrid;
    Adaptadores: TStringColumn;
    LayoutBottons: TLayout;
    ButtonOK: TButton;
    procedure ImageCloseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImageCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ButtonOKClick(Sender: TObject);
  private
    var
      fAdapterList : TAdapterList;
      fAdapterIndex : Integer;

    procedure setAdaptersList();
    procedure setLabels();

  public
    constructor Create (Sender: TComponent; aAdapterList: TAdapterList);

    property AdapterIndex : Integer read fAdapterindex write fAdapterindex;

  end;

implementation

{$R *.fmx}

{ TInitialView }

procedure TInitialView.ButtonOKClick(Sender: TObject);
begin
  Self.fAdapterindex := StringGridAdapters.Row;
  ModalResult := mrOk;

end;

constructor TInitialView.Create(Sender: TComponent; aAdapterList: TAdapterList);
begin
  inherited Create(Sender);
  Self.fAdapterList := aAdapterList;
  Self.fAdapterindex := -1;
  Self.setAdaptersList();

end;

procedure TInitialView.ImageCloseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Self.CircleClose.Opacity := 1;
end;

procedure TInitialView.ImageCloseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Self.CircleClose.Opacity := 0;
  ModalResult := mrClose;

end;

procedure TInitialView.setAdaptersList;
var
  I: Integer;

begin
  StringGridAdapters.RowCount := Self.fAdapterList.Count;
  Adaptadores.Width := StringGridAdapters.Width - 5;

  for I := 0 to Self.fAdapterList.Count -1  do
  begin
    StringGridAdapters.Cells[0, I] := Self.fAdapterList[I].AdapterDescription;
  end;

end;

procedure TInitialView.setLabels;
begin
  Adaptadores.Header := TTranslation<TPortuguese>.Language.InitialView.GridColumn01;
  ButtonOK.Text := TTranslation<TPortuguese>.Language.InitialView.ButtonOK;

end;

end.
