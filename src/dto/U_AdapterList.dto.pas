unit U_AdapterList.dto;

interface

uses
  System.Generics.Collections, U_Adapter.dto;

type
  TAdapterList = class(TObjectList<TAdapter>)
  public
    constructor Create();

    procedure Add(adapter : TAdapter);

  end;


implementation

{ AdapterList }

procedure TAdapterList.Add(adapter : TAdapter);
begin
  inherited Add(
    TAdapter.Create(
      adapter.AdapterDescription,
      adapter.AdapterGateway,
      adapter.AdapterIndex,
      adapter.AdapterIPAddress,
      adapter.AdapterIPv6Address,
      adapter.AdapterPhysicalAddress,
      adapter.AdapterSubnetMask,
      adapter.AdapterType,
      adapter.LocalHost,
      adapter.NodeType
    )
  );

end;

constructor TAdapterList.Create;
begin
  inherited Create();
end;

end.
