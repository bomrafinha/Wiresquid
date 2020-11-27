unit U_Portuguese;

interface

type
  TPortuguese = class(TinterfacedObject)
  strict private
    type
      TMainView = class(TinterfacedObject)
      public
        const
          {$region Text}
          HeaderText01 : String = 'Adaptador: ';
          HeaderText02 : String = 'Gateway: ';
          HeaderText03 : String = 'Endereço IPv4: ';
          HeaderText04 : String = 'Endereço IPv6: ';
          HeaderText05 : String = 'Endereço MAC: ';
          HeaderText06 : String = 'Máscara: ';
          HeaderText07 : String = 'Tipo do Adaptador: ';
          HeaderText08 : String = 'Localhost: ';
          HeaderText09 : String = 'Tipo do Nodo: ';
          FooterText13_01 : String = 'Monitoramento Parado';
          FooterText13_02 : String = 'Monitoramento Ativo';
          FooterText14 : String = 'Pacotes: ';
          {$endregion}

          {$region Menu}
          Menu01_Arquivo : String = 'Arquivo';
          Menu02_Fechar : String = 'Fechar';

          Menu01_Ferramentas : String = 'Ferramentas';
          Menu02_Ping : String = 'Ping';
          Menu02_Arp : String = 'Arp';
          Menu02_Traceroute : String = 'Traceroute';

          Menu01_Idiona : String = 'Idioma';
          Menu02_Portugues : String = 'Português';

          Menu01_Ajuda : String = 'Ajuda';
          Menu02_Sobre : String = 'Sobre';
//          Menu0_ : String = '';
          {$endregion}

          {$region ToolBar}
          ToolBar_Button01 : String = 'Selecionar outro adaptador';
          ToolBar_Button02 : String = 'Iniciar Monitoramento';
          ToolBar_Button03 : String = 'Parar Monitoramento';
//          ToolBar_Button0 : String = '';
          {$endregion}

          {$region Columns}
          GridColumn01 : String = 'Nº';
          GridColumn02 : String = 'Endereço Origem';
          GridColumn03 : String = 'Porta Origem';
          GridColumn04 : String = 'Endereço Destino';
          GridColumn05 : String = 'Porta Destino';
          GridColumn06 : String = 'Versão IP';
          GridColumn07 : String = 'Protocolo IP';
          GridColumn08 : String = 'TTL';
          GridColumn09 : String = 'ID';
          GridColumn10 : String = 'Checksum';
          GridColumn11 : String = 'TOS';
          GridColumn12 : String = 'Flags';
          GridColumn13 : String = 'Offset';
          GridColumn14 : String = 'Tempo';
          GridColumn15 : String = 'Dados do Pacote';
//          GridColumn01 : String = '';
          {$endregion}

          {$region TreeView}
          TreeView01_Interface : String = 'Interface';
          TreeView02_DeviceIndex : String = 'Index do dispositivo: ';
          TreeView02_DeviceName : String = 'Nome do dispositivo: ';
          TreeView02_DeviceMAC : String = 'MAC: ';
          TreeView02_DeviceDescription : String = 'Descrição do dispositivo: ';
          TreeView02_DeviceStatus : String = 'Status do dispositivo: ';
//          TreeView01_ : String = '';
          {$endregion}

      end;

      TInitialView = class(TinterfacedObject)
      public
        const
          {$region Columns}
          GridColumn01 : String = 'Adaptadores';
          {$endregion}

          {$region Buttons}
          ButtonOK : String = 'OK';
          {$endregion}
      end;

    private
      class var
        fMainView : TMainView;
        fInitialView : TInitialView;

    public
      class property MainView : TMainView read fMainView write fMainView;
      class property InitialView : TInitialView read fInitialView write fInitialView;
  end;

implementation

end.
