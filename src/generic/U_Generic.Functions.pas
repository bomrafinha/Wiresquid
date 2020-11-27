unit U_Generic.Functions;

interface

uses
  System.SysUtils, WinApi.ShellApi, FMX.Forms, System.UITypes, Winapi.Windows,
  System.Classes, Winapi.ShlObj;

type
  TGenericsFunctions = class(TInterfacedObject)
  public
    constructor Create();
    function getProtocol(protocol : Integer): String;
    function getTOS(tos : Integer): String;
    function getFlags(flag : Integer): String;
    function getElapsedTime(atual : TDateTime) : TDateTime;
    function intToBinStr(num, tamanho: integer): string;
    function binStrToInt(num: String): Integer;
    procedure launchBrowser(aURL : String);
    function getSpecialFolder(aFolder: Integer; var Location: String): LongWord;

  end;

implementation

{ TFunctionsGenerics }

function TGenericsFunctions.BinStrToInt(num: String): Integer;
var
  i, iValueSize: Integer;
begin
  Result := 0;
  iValueSize := Length(num);
  for i := iValueSize downto 1 do
  begin
    if num[i] = '1' then
    begin
      Result := Result + (1 shl (iValueSize - i));
    end;
  end;

end;

constructor TGenericsFunctions.Create;
begin
  inherited Create();

end;

function TGenericsFunctions.getElapsedTime(atual : TDateTime) : TDateTime;
begin
  Result := now() - atual;

end;

function TGenericsFunctions.getFlags(flag: Integer): String;
begin
  Result := Self.intToBinStr(flag, 3);

end;

function TGenericsFunctions.getProtocol(protocol : Integer): String;
begin
  case protocol of
    1: Result := 'ICMP';
    2: Result := 'IGMP';
    4: Result := 'IP';
    6: Result := 'TCP';
    17: Result := 'UDP';
  else
     Result := '';
  end;

end;

function TGenericsFunctions.getSpecialFolder(aFolder: Integer; var Location: String): LongWord;
// Retorna o nome do diretorio de alguns diretorios padrões do Windows
// Incluir ShlObj na clausula Uses
// aFolder pode ser
//const
// Pastas : Array[0..15] of Integer = (CSIDL_BITBUCKET, CSIDL_CONTROLS,
// CSIDL_DESKTOP, CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_FONTS,
// CSIDL_NETHOOD, CSIDL_NETWORK, CSIDL_PERSONAL, CSIDL_PRINTERS,
// CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_STARTMENU,
// CSIDL_STARTUP, CSIDL_TEMPLATES);
// Descs : Array[0..15] of String = (´Lixeira´, ´Painel de controle´,
// ´Área de trabalho´, ´Arquivos da área de trabalho´, ´Meu Computador´,
// ´Fontes´, ´Ambiente de rede´, ´Hierarquia de rede´, ´Documentos pessoais´,
// ´Impressoras´, ´Programas do usuário´, ´Documentos´, ´Enviar Para´,
// ´Menu Iniciar´, ´Grupo Iniciar´, ´Modelos´);
var
  pidl: PItemIDList;
  hRes: HRESULT;
  RealPath: Array[0..MAX_PATH] of Char;
  Success: Boolean;

begin
  Result := 0;
  hRes := SHGetSpecialFolderLocation(0, aFolder, pidl);
  if hRes = NO_ERROR then
  begin
    Success := SHGetPathFromIDList( pidl, RealPath );
    if Success then
      Location := String( RealPath ) + '\'
    else
      Result := LongWord( E_UNEXPECTED );
    end else
      Result := hRes;
end;

function TGenericsFunctions.getTOS(tos: Integer): String;
var
  valueFullTos : String;
  valuePrecedence : Integer;

begin
  Result := '';

  valuePrecedence := Self.BinStrToInt(
    Copy(
      Self.IntToBinStr(tos, 8),
      1,
      3
    )
  );

  case valuePrecedence of
    0: Result := 'Routine';
    1: Result := 'Priority';
    2: Result := 'Immediate';
    3: Result := 'Flash';
    4: Result := 'Flash Override';
    5: Result := 'CRITIC/ECP';
    6: Result := 'Internetwork Control';
    7: Result := 'Network Control';
  end;

end;

function TGenericsFunctions.intToBinStr(num, tamanho : integer): string;
var
  i: integer;

begin
  for i := 0 to tamanho - 1 do
  begin
    Result := IntToStr((num shr i) and 1) + Result;
  end;

end;

procedure TGenericsFunctions.launchBrowser(aURL : String);
var
  myURL: string;
{$IFDEF ANDROID}
  Intent: JIntent;
{$ENDIF ANDROID}

{$IFDEF IOS}
  NSU: NSUrl;
{$ENDIF IOS}
begin
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PWideChar('https://' + trim(aURL)), nil, nil, SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}

{$IFDEF IOS}
  NSU   := StrToNSUrl(TIdURI.URLEncode(myURL));
  if SharedApplication.canOpenURL(NSU) then
  begin
    SharedApplication.openUrl(NSU);
  end;
{$ENDIF IOS}

{$IFDEF ANDROID}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(myURL));
  TAndroidHelper.Activity.startActivity(Intent);
{$ENDIF ANDROID}
end;

end.
