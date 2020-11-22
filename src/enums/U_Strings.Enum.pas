unit U_Strings.Enum;

interface

type
  TLabelsPortuguese = class(TinterfacedObject)
  strict private
    type
      TMainView = class(TinterfacedObject)
      strict private
        var
          fText01 : String;
          fText02 : String;
          fText03 : String;
          fText04 : String;
          fText05 : String;
          fText06 : String;
          fText07 : String;
          fText08 : String;
          fText09 : String;

        procedure setValues();

      private
        constructor Create();

      public
        property Text01 : String read fText01 write fText01;
        property Text02 : String read fText02 write fText02;
        property Text03 : String read fText03 write fText03;
        property Text04 : String read fText04 write fText04;
        property Text05 : String read fText05 write fText05;
        property Text06 : String read fText06 write fText06;
        property Text07 : String read fText07 write fText07;
        property Text08 : String read fText08 write fText08;
        property Text09 : String read fText09 write fText09;

      end;
    private
      var
        fMainView : TMainView;

    public
      constructor Create();
      property MainView : TMainView read fMainView write fMainView;
  end;

implementation

{ TLabelsPortuguese.TMainView }

constructor TLabelsPortuguese.TMainView.Create;
begin
  inherited Create();
  Self.setValues();

end;

procedure TLabelsPortuguese.TMainView.setValues;
begin
  fText01 := 'Adaptador: ';
  fText02 := 'Gateway: ';
  fText03 := 'Endereço IPv4: ';
  fText04 := 'Endereço IPv6: ';
  fText05 := 'Endereço MAC: ';
  fText06 := 'Máscara: ';
  fText07 := 'Tipo do Adaptador: ';
  fText08 := 'Localhost: ';
  fText09 := 'Tipo do Nodo: ';
end;

{ TLabelsPortuguese }

constructor TLabelsPortuguese.Create;
begin
  inherited Create();
  fMainView := TMainView.Create();

end;

end.
