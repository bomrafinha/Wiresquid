unit U_Adapter.dto;

interface

type
  TAdapter =  class(TInterfacedObject)
  private
    fAdapterDescription : String;
    fAdapterGateway : String;
    fAdapterIndex : String;
    fAdapterIPAddress : String;
    fAdapterIPv6Address : String;
    fAdapterPhysicalAddress : String;
    fAdapterSubnetMask : String;
    fAdapterType : String;
    fLocalHost : String;
    fNodeType : String;

  public
    constructor Create(); Overload;
    constructor Create(
      aAdapterDescription, aAdapterGateway, aAdapterIndex,
      aAdapterIPAddress, aAdapterIPv6Address, aAdapterPhysicalAddress,
      aAdapterSubnetMask, aAdapterType, aLocalHost, aNodeType : String
    ); Overload;

    property AdapterDescription : String read fAdapterDescription write fAdapterDescription;
    property AdapterGateway : String read fAdapterGateway write fAdapterGateway;
    property AdapterIndex : String read fAdapterIndex write fAdapterIndex;
    property AdapterIPAddress : String read fAdapterIPAddress write fAdapterIPAddress;
    property AdapterIPv6Address : String read fAdapterIPv6Address write fAdapterIPv6Address;
    property AdapterPhysicalAddress : String read fAdapterPhysicalAddress write fAdapterPhysicalAddress;
    property AdapterSubnetMask : String read fAdapterSubnetMask write fAdapterSubnetMask;
    property AdapterType : String read fAdapterType write fAdapterType;
    property LocalHost : String read fLocalHost write fLocalHost;
    property NodeType : String read fNodeType write fNodeType;

  end;

implementation

{ TAdapter }

constructor TAdapter.Create;
begin
  inherited Create();

end;

constructor TAdapter.Create(aAdapterDescription, aAdapterGateway, aAdapterIndex,
  aAdapterIPAddress, aAdapterIPv6Address, aAdapterPhysicalAddress,
  aAdapterSubnetMask, aAdapterType, aLocalHost, aNodeType : String);
begin
  inherited Create();
  Self.fAdapterDescription := aAdapterDescription;
  Self.fAdapterGateway := aAdapterGateway;
  Self.fAdapterIndex := aAdapterIndex;
  Self.fAdapterIPAddress := aAdapterIPAddress;
  Self.fAdapterIPv6Address := aAdapterIPv6Address;
  Self.fAdapterPhysicalAddress := aAdapterPhysicalAddress;
  Self.fAdapterSubnetMask := aAdapterSubnetMask;
  Self.fAdapterType := aAdapterType;
  Self.fLocalHost := aLocalHost;
  Self.fNodeType := aNodeType;

end;

end.
