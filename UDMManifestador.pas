unit UDMManifestador;

interface

uses
  System.SysUtils, System.Classes,  ACBrNFeDANFEClass, ACBrNFeDANFeRLClass,
  ACBrBase, ACBrDFe, ACBrNFe, ACBrDFeSSL, pcnConversao, pcnConversaoNFe, Vcl.Forms,
  Vcl.Controls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, ZAbstractConnection,
  ZConnection, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZSqlUpdate, Vcl.ActnList, Vcl.Dialogs, Vcl.ExtCtrls, System.zip, ACBrMail;

type

  TDMManifestador = class(TDataModule)

    ACBrNFe: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    XMLDocument1: TXMLDocument;
    ZConnection1: TZConnection;
    ZQueryEMPRESA: TZQuery;
    ZQueryNF: TZQuery;
    ZQueryNFCODIGO: TLargeintField;
    ZQueryNFNUMERO: TLargeintField;
    ZQueryNFSERIE: TLargeintField;
    ZQueryNFCNPJ: TWideStringField;
    ZQueryNFNOME: TWideStringField;
    ZQueryNFEMISSAO: TDateField;
    ZQueryNFVALOR: TFloatField;
    ZQueryNFTIPO: TWideStringField;
    ZQueryNFSITUACAO: TWideStringField;
    ZQueryNFCHAVE: TWideStringField;
    ZQueryNFIE: TWideStringField;
    ZQueryNFPROTOCOLO: TWideStringField;
    ZQueryNFDATAREC: TDateField;
    ZQueryNFMANIFESTACAO: TWideStringField;
    ZQueryNFDOWNLOAD: TWideStringField;
    ZQueryNFAMBIENTE: TWideStringField;
    ZQueryNSU: TZQuery;
    ZQueryNFNSU: TLargeintField;
    ZQueryEMPRESACNPJ: TWideStringField;
    ZQueryEMPRESACERTIFICADO: TWideStringField;
    ZQueryEMPRESASENHA: TWideStringField;
    ZQueryEMPRESAUF: TLargeintField;
    ZUpdateSQLEMPRESA: TZUpdateSQL;
    ZUpdateSQLNF: TZUpdateSQL;
    ACBrNFeImprimir: TACBrNFe;
    ZQueryEMPRESACAMINHO: TWideStringField;
    ZQueryEMPRESANOME: TWideStringField;
    ZQueryEMPRESANUMERO_SERIE: TWideStringField;
    SaveDialogPDF: TSaveDialog;
    ZQueryEMPRESACODIGO: TLargeintField;
    ZQueryNFID_EMPRESA: TLargeintField;
    ZQueryExisteNota: TZQuery;
    ZQueryNFVISIVEL: TWideStringField;
    ZQueryCFG: TZQuery;
    ZQueryCFGVERIFICAR_AUTOMATICO: TWideStringField;
    ZQueryCFGDOWNLOAD_AUTOMATICO: TWideStringField;
    ZQueryCFGTIMER: TLargeintField;
    ZUpdateSQLCFG: TZUpdateSQL;
    ZQueryCFGCODIGO: TLargeintField;
    TimerVerificar: TTimer;
    ACBrMail1: TACBrMail;
    ZQueryCFGSMTP: TWideStringField;
    ZQueryCFGSMTP_CONTA: TWideStringField;
    ZQueryCFGSMTP_REMETENTE: TWideStringField;
    ZQueryCFGSMTP_EMAIL: TWideStringField;
    ZQueryCFGSMTP_SENHA: TWideStringField;
    ZQueryCFGSMTP_PORTA: TLargeintField;
    ZQueryNF_LOG: TZQuery;
    ZQueryNF_LOGCODIGO: TLargeintField;
    ZQueryNF_LOGID_NF: TLargeintField;
    ZQueryNF_LOGOPERACAO: TLargeintField;
    ZQueryNF_LOGDATAHORA: TDateTimeField;
    ZQueryNF_LOGHISTORICO: TWideStringField;
    ZQueryEMPRESACAMINHO_COPIA_XML: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure zQueryNFNewRecord(DataSet: TDataSet);
    procedure ZConnection1BeforeConnect(Sender: TObject);
    procedure ZQueryNFAfterScroll(DataSet: TDataSet);
    procedure ZQueryNFAfterOpen(DataSet: TDataSet);
    procedure ZQueryCFGNewRecord(DataSet: TDataSet);
    procedure TimerVerificarTimer(Sender: TObject);
    procedure ZQueryNF_LOGBeforeOpen(DataSet: TDataSet);

  private

    { Private declarations }
    FActionManifestar: TAction;
    FActionDownload: TAction;
    FActionVisualizar: TAction;

    procedure SetActionManifestar(const Value: TAction);
    procedure SetActionDownload(const Value: TAction);
    procedure SetActionVisualizar(const Value: TAction);
    function ExisteNota(Chave: String): Boolean;
    procedure UpdateManifestar(CodigoNotaFiscal: Integer);
    procedure UpdateDownload(CodigoNotaFiscal: Integer);
    procedure ManifestacaoAutomatica;
    procedure DownloadAutomatico;

  public

    { Public declarations }
    procedure ConfigurarAcbr;
    procedure ListarNotas(Inicio, Fim: TDate; Baixadas, Manifestadas: Boolean);
    function ObterUltimoNSU(Ambiente: String): Integer;
    procedure Mensagem(Texto: string);
    procedure ExibirDialogoProcessamento;
    procedure OcultarDialogoProcessamento;
    procedure ObterNotas;
    procedure Manifestar(CodigoNotaFiscal, TipoManifestacao: Integer; ChaveNF: String; Refresh: Boolean);
    procedure Download(CodigoNotaFiscal: Integer; ChaveNF: String; Refresh: Boolean);
    procedure Visualizar(GerarPDF: Boolean);
    procedure ConfigurarTimer;
    procedure GerarZip(ZipFileName: String; FilesToZip: TStringList);
    procedure ConfigurarAcbrMail;
    procedure GerarLogNF(CodigoNotaFiscal, CodigoOperacao: Integer; Msg: String = '');
    property ActionManifestar: TAction read FActionManifestar write SetActionManifestar;
    property ActionDownload: TAction read FActionDownload write SetActionDownload;
    property ActionVisualizar: TAction read FActionVisualizar write SetActionVisualizar;

  end;

var
  DMManifestador: TDMManifestador;

implementation

uses
  UfrmProcessamento;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMManifestador.DataModuleCreate(Sender: TObject);
begin

  // Instancia na memória o formulário de exibição do processamento
  frmProcessamento := TfrmProcessamento.Create(Application);
  // Abre a query de configurações gerais
  ZQueryCFG.Open;
  // Carrega as configurações do timer
  ConfigurarTimer;
  // Abre a query EMPRESA
  zQueryEMPRESA.Open;
  // Configura o componente Acbr
  ConfigurarAcbr;

end;

procedure TDMManifestador.ConfigurarTimer;
begin

  if (ZQueryCFGVERIFICAR_AUTOMATICO.AsString = 'S') and (ZQueryCFGTIMER.AsInteger > 0) then
  begin

    TimerVerificar.Interval := ZQueryCFGTIMER.AsInteger * 60000;
    TimerVerificar.Enabled := True;

  end;

end;

procedure TDMManifestador.ConfigurarAcbr;
begin

  // Configura o componente ACBr
  ACBrNFe.Configuracoes.Geral.VersaoDF := ve310;

  // Configurações para utilização de comunicação com webservice utilizando arquivo PFX
  if (zQueryEMPRESACERTIFICADO.AsString <> '') then
  begin

    ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryWinCrypt;
    ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpWinHttp;
    ACBrNFe.Configuracoes.Geral.SSLXmlSignLib := xsXmlSec;
    // Configuração do certificado
    ACBrNFe.Configuracoes.Certificados.ArquivoPFX := zQueryEMPRESACERTIFICADO.AsString;
    ACBrNFe.Configuracoes.Certificados.Senha := zQueryEMPRESASENHA.AsString;
    ACBrNFe.Configuracoes.Certificados.NumeroSerie := '';

  end
  else
  // Configurações para utilização de comunicação com webservice com a Capicom
  if (ZQueryEMPRESANUMERO_SERIE.AsString <> '') then
  begin

    ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryCapicom;
    ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpWinHttp;
    ACBrNFe.Configuracoes.Geral.SSLXmlSignLib := xsMsXmlCapicom;
    // Configuração do certificado
    ACBrNFe.Configuracoes.Certificados.NumeroSerie := ZQueryEMPRESANUMERO_SERIE.AsString;
    ACBrNFe.Configuracoes.Certificados.ArquivoPFX := '';
    ACBrNFe.Configuracoes.Certificados.Senha := '';

  end;
  // Ambiente do webservice: produção ou homologação
  ACBRNFe.Configuracoes.WebServices.Ambiente := taProducao;
  ACBrNFe.Configuracoes.Geral.FormaEmissao := teNormal;
  ACBrNFe.Configuracoes.Arquivos.Salvar     := True;
  ACBrNFe.Configuracoes.Geral.Salvar        := True;

  // Se não está configurado o caminho do xml então salva na pasta "NotasFonnecedores" na pasta do App
  if (ZQueryEMPRESACAMINHO.AsString = '') then
  begin

    ACBrNFe.Configuracoes.Arquivos.PathSalvar := ExtractFilePath(Application.ExeName) +
                                                 'NotasFornecedores\' +
                                                 ZQueryEMPRESACNPJ.AsString +
                                                 '\Temp';
    ACBrNFe.Configuracoes.Arquivos.DownloadNFe.PathDownload := ExtractFilePath(Application.ExeName) +
                                                               'NotasFornecedores\' +
                                                               ZQueryEMPRESACNPJ.AsString;

  end
  else
  begin

    // Se usuário configurou caminho para o xml então o utiliza
    ACBrNFe.Configuracoes.Arquivos.PathSalvar := ZQueryEMPRESACAMINHO.AsString + '\' + ZQueryEMPRESACNPJ.AsString + '\Temp';
    ACBrNFe.Configuracoes.Arquivos.DownloadNFe.PathDownload := ZQueryEMPRESACAMINHO.AsString + '\' + ZQueryEMPRESACNPJ.AsString;

  end;

end;

procedure TDMManifestador.ZConnection1BeforeConnect(Sender: TObject);
begin

  ZConnection1.Database := '';

  // Seta o caminho da conexão com o banco de dados que deve estar na mesma pasta do App
  if (FileExists(ExtractFilePath(Application.ExeName) + 'manifestador.db')) then
    ZConnection1.Database := ExtractFilePath(Application.ExeName) + 'manifestador.db'
  else
    raise Exception.Create('Não foi encontrado o arquivo: ' + ExtractFilePath(Application.ExeName) + 'manifestador.db');

end;


procedure TDMManifestador.ZQueryCFGNewRecord(DataSet: TDataSet);
begin

  ZQueryCFGVERIFICAR_AUTOMATICO.AsString := 'S';
  ZQueryCFGDOWNLOAD_AUTOMATICO.AsString := 'S';
  ZQueryCFGTIMER.AsInteger := 5;

end;

procedure TDMManifestador.ZQueryNFAfterOpen(DataSet: TDataSet);
begin

  // Desabilita as Actions de manifesto, download e visualização se não houver registros
  if (ZQueryNF.RecordCount = 0) then
  begin

    if (FActionManifestar <> nil) then
      FActionManifestar.Enabled := False;

    if (FActionDownload <> nil) then
      FActionDownload.Enabled := False;

    if (FActionVisualizar <> nil) then
      FActionVisualizar.Enabled := False;

  end;

end;

procedure TDMManifestador.ZQueryNFAfterScroll(DataSet: TDataSet);
begin

  // Habilita/desabilita a possibilidade de manifestar a nfe
  if (FActionManifestar <> nil) then
    FActionManifestar.Enabled := (ZQueryNFMANIFESTACAO.AsString = 'N');

  // Habilita/desabilita a possibilidade de efetuar download nfe
  if (FActionDownload <> nil) then
    FActionDownload.Enabled := (ZQueryNFMANIFESTACAO.AsString = 'S') or (ZQueryNFDOWNLOAD.AsString = 'S');

  // Habilita/desabilita a possibilidade de visualizar a nfe
  if (FActionVisualizar <> nil) then
    FActionVisualizar.Enabled := True;

  ZQueryNF_LOG.Close;
  ZQueryNF_LOG.Open;

end;

procedure TDMManifestador.zQueryNFNewRecord(DataSet: TDataSet);
begin

  // Inicialização dos campos
  zQueryNFMANIFESTACAO.AsString := 'N';
  zQueryNFDOWNLOAD.AsString := 'N';

  if (ACBRNFe.Configuracoes.WebServices.Ambiente = taProducao) then
    zQueryNFAMBIENTE.AsString := 'P'
  else
    zQueryNFAMBIENTE.AsString := 'H';

  zQueryNFDATAREC.AsDateTime := Date;
  ZQueryNFID_EMPRESA.AsInteger := ZQueryEMPRESACODIGO.AsInteger;

end;

procedure TDMManifestador.ZQueryNF_LOGBeforeOpen(DataSet: TDataSet);
begin

  ZQueryNF_LOG.ParamByName('ID_NF').AsInteger := ZQueryNFCODIGO.AsInteger;

end;

procedure TDMManifestador.ListarNotas(Inicio, Fim: TDate; Baixadas, Manifestadas: Boolean);
begin

  // Lista as notas fiscais de acordo com o período informado
  zQueryNF.Close;
  zQueryNF.ParamByName('ID_EMPRESA').AsInteger := ZQueryEMPRESACODIGO.AsInteger;
  zQueryNF.ParamByName('INICIO').AsDate := Inicio;
  zQueryNF.ParamByName('FIM').AsDate := Fim;

  if (Manifestadas) then
    zQueryNF.ParamByName('MANIFESTACAO').AsString := 'S'
  else
    zQueryNF.ParamByName('MANIFESTACAO').AsString := 'T';

  if (Baixadas) then
    zQueryNF.ParamByName('DOWNLOAD').AsString := 'S'
  else
    zQueryNF.ParamByName('DOWNLOAD').AsString := 'T';

  zQueryNF.Open;

end;

procedure TDMManifestador.Mensagem(Texto: string);
begin

  // Exibe o texto na ListboxMensagens do formulário de processamento
  frmProcessamento.ListBoxMensagens.Items.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss', now) + ' - ' + Texto);
  frmProcessamento.ListBoxMensagens.ItemIndex := frmProcessamento.ListBoxMensagens.Items.Count - 1;
  Application.ProcessMessages;

end;

function TDMManifestador.ObterUltimoNSU(Ambiente: String): Integer;
begin

  // Retorna o último NSU conforme o ambiente "Produção" ou "Homologação"
  ZQueryNSU.Close;
  ZQueryNSU.ParamByName('AMBIENTE').AsString := Ambiente;
  ZQueryNSU.ParamByName('ID_EMPRESA').AsInteger := ZQueryEMPRESACODIGO.AsInteger;
  ZQueryNSU.Open;

  if (ZQueryNSU.FieldByName('NSU').AsString = '') then
    Result := 0
  else
    Result := ZQueryNSU.FieldByName('NSU').AsInteger;

end;

procedure TDMManifestador.ObterNotas;
var
  IndNFe, IndEmi, ultNSU: string;
  i, Count, CountTotal: Integer;
  cStat: Integer;
  iConsultas: Integer;
  sAmbiente: String;
begin

  // Configura o componente acbr
  ConfigurarAcbr;
  // Inicializa contador de consultas ao webservice
  iConsultas := 0;
  CountTotal := 0;
  // CStat 138 = resposta do webservice quando existem novas notas fiscais disponíveis
  cStat := 138;
  zQueryNF.DisableControls;

  try

    // Oculta o diálogo para limpar os logs anteriores
    OcultarDialogoProcessamento;
    // Exibe o diálogo de processamento
    Mensagem('Consultando web service ...');
    ExibirDialogoProcessamento;
    // Altera o cursor do mouse
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    try

      // Efetua até 20 consultas ao webservice enquanto o retorno do mesmo for 138
      //while (cStat = 138) and (iConsultas < 20) do
      while (cStat = 138) and (iConsultas < 1) do
      begin

        // Incrementa o número de consultas efetuadas no webservice
        Inc(iConsultas);
        Mensagem('Consultando web service #' + IntToStr(iConsultas));

        // Verifica qual o ambiente do webservice  "Produção" ou "Homologação"
        if (ACBRNFe.Configuracoes.WebServices.Ambiente = taProducao) then
          sAmbiente := 'P'
        else
          sAmbiente := 'H';

        // Obtém o número do último NSU no banco de dados local
        ultNSU := IntToStr(ObterUltimoNSU(sAmbiente));
        // Dispara a consulta ao webservice
        ACBrNFe.DistribuicaoDFe(zQueryEMPRESAUF.AsInteger,
                                zQueryEMPRESACNPJ.AsString, //05778762000137
                                UltNSu,
                                '');

        // Inicializa o contador de notas fiscais disponívels
        Count := 0;
        // Captura o cStat retornado pelo webservice
        cStat := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.cStat;

        // 138 = Novas notas fiscais disponíveis
        if (cStat = 138) then
        begin

          // Percorre a lista de NFe
          for i := 0 to ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count - 1 do
          begin

            // Armazena o NSU
            if (Trim(ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].NSU) <> '') then
              ultNSU := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].NSU;

            Mensagem('Chave NFE:' + zQueryNFCHAVE.AsString);

            // Verifica se tem NSU e Chave da NFe
            if (ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].NSU <> '') and
               (ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.chNFe <> '') then
            begin

              // Incrementa contador de notas
              Inc(Count);
              // Inclui os dados de resumo da NFe no banco de dados
              zQueryNF.Append;
              zQueryNFNSU.AsString         := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].NSU;
              zQueryNFChave.AsString       := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.chNFe;
              zQueryNFSerie.AsString       := Copy(zQueryNFChave.AsString, 23, 3);
              zQueryNFNumero.AsString      := Copy(zQueryNFChave.AsString, 26, 9);
              zQueryNFCNPJ.AsString        := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.CNPJCPF;
              zQueryNFNome.AsString        := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.xNome;
              zQueryNFIE.AsString          := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.IE;
              zQueryNFEmissao.AsDateTime   := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.dhEmi;
              zQueryNFValor.AsCurrency     := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.vNF;
              zQueryNFDataRec.AsDateTime   := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.dhRecbto;
              zQueryNFProtocolo.AsString   := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.nProt;

              // Verifica se é uma NFe de Entrada ou Saída
              case ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.tpNF of

                tnEntrada: zQueryNFTipo.AsString := 'Entrada';
                tnSaida:   zQueryNFTipo.AsString := 'Saída';

              end;

              // Verifica qual é a situação da NFe
              case ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.cSitNFe of

                snAutorizado: zQueryNFSituacao.AsString := 'Autorizado';
                snDenegado:   zQueryNFSituacao.AsString := 'Denegado';
                snCancelado:  zQueryNFSituacao.AsString := 'Cancelado';
                snEncerrado:   zQueryNFSituacao.AsString := 'Encerrado';

              end;

              if ExisteNota(ZQueryNFCHAVE.AsString) then
                ZQueryNFVISIVEL.AsString := 'N'
              else
                ZQueryNFVISIVEL.AsString := 'S';

              zQueryNF.Post;
              Mensagem('Retornando resumo da nota fiscal ' + zQueryNFCHAVE.AsString);
              Application.ProcessMessages;


            end
            else
            begin

              // Alguns registros retornados pelo webservice de distribuição de NFe
              // não contém dados de resumos das notas fiscias então aqui estou
              // gravando esses casos apenas para controle do NSU
              zQueryNF.Append;
              zQueryNFNSU.AsString         := ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].NSU;
              zQueryNFChave.AsString       := 'Chave de acesso';
              zQueryNFSerie.AsString       := '0';
              zQueryNFNumero.AsString      := '0';
              zQueryNFCNPJ.AsString        := 'CNPJ';
              zQueryNFNome.AsString        := 'Nome';
              zQueryNFIE.AsString          := 'IE';
              zQueryNFEmissao.AsDateTime   := 0;
              zQueryNFValor.AsCurrency     := 0;
              zQueryNFDataRec.AsDateTime   := 0;
              zQueryNFProtocolo.AsString   := '0';

              case ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.tpNF of

                tnEntrada: zQueryNFTipo.AsString := 'Entrada';
                tnSaida:   zQueryNFTipo.AsString := 'Saída';
              else

                zQueryNFTipo.AsString := 'tpNF';

              end;

              case ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip[i].resNFe.cSitNFe of

                snAutorizado: zQueryNFSituacao.AsString := 'Autorizado';
                snDenegado:   zQueryNFSituacao.AsString := 'Denegado';
                snCancelado:  zQueryNFSituacao.AsString := 'Cancelado';
                snEncerrado:   zQueryNFSituacao.AsString := 'Encerrado';

              else

                zQueryNFSituacao.AsString := 'cSitNFe';

              end;

              ZQueryNFVISIVEL.AsString := 'N';
              zQueryNF.Post;
              Application.ProcessMessages;

            end;

          end;

          zQueryNF.First;
          Mensagem('Foram encontradas ' + IntToStr(Count) + ' novas nota(s) fiscal(s).');
          CountTotal := CountTotal + Count;

        end
        else
        begin

          // Nenhum Documento Localizado para o Destinatário
          if (ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137) then
            Mensagem('Nenhum documento foi localizado.')
          else
            Mensagem(' Não foi possível realizar a consulta. cStat:' + IntToStr(ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.cStat)  +
                     ' - Motivo: ' + ACBrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo);

        end;

      end;

      Mensagem('Fim do processamento: no total foram encontradas ' + IntToStr(CountTotal) + ' novas nota(s) fiscal(s).');
      // Atualiza os dados
      zQueryNF.Refresh;

    except

      on E:Exception do
      begin

        Mensagem(E.Message);

      end;

    end;

  finally

    Screen.Cursor := crDefault;
    zQueryNF.EnableControls;

  end;

end;

procedure TDMManifestador.Manifestar(CodigoNotaFiscal, TipoManifestacao: Integer; ChaveNF: String; Refresh: Boolean);
var
  i, IdLote: Integer;
begin

  // Configura o componente acbr
  ConfigurarAcbr;
  GerarLogNF(CodigoNotaFiscal, 1);
  // Oculta o diálogo para limpar os logs anteriores
  OcultarDialogoProcessamento;
  // Inicialização do número do lote
  IdLote := 0;
  Mensagem('Enviando evento para o web service da receita ...');
  ExibirDialogoProcessamento;
  //zQueryNF.DisableControls;
  ACBrNFe.EventoNFe.Evento.Clear;
  Application.ProcessMessages;

  try

    Mensagem('Adicinado ao lote a NF ' + ChaveNF);

    // Gera o número de lote
    if (ACBrNFe.EventoNFe.idLote = 0) then
    begin

      IdLote := CodigoNotaFiscal;
      ACBrNFe.EventoNFe.idLote := IdLote;

    end;

    // Cria o evendo de manifestação
    with ACBrNFe.EventoNFe.Evento.Add do
    begin

      // Chave da NFe
      infEvento.chNFe    := ChaveNF;
      // CNPJ da empressa destinada
      infEvento.CNPJ     := zQueryEMPRESACNPJ.AsString;
      // data e hora
      infEvento.dhEvento := now;
      // Órgao 91 fixo
      infEvento.cOrgao   := 91;

      case TipoManifestacao of

        //Confirmação de operação
        0: infEvento.tpEvento:= teManifDestConfirmacao;
        //Ciência da operação
        1: infEvento.tpEvento := teManifDestCiencia;
        //Operação não realizada
        2: infEvento.tpEvento := teManifDestOperNaoRealizada;

      end;

    end;

    Mensagem('Enviando lote para web service da receita ...');
    Application.ProcessMessages;
    // Envia o lote de manifesto para o webservice
    ACBrNFe.EnviarEvento(IdLote);
    Mensagem('Processando o retorno do webservice...');

    // Captura os retornos do webservice
    for i := 0 to ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Count - 1 do
    begin

      // Seta o ponteiro da query zQueryNF apontando para a nota retornada pelo webservice
      // (zQueryNF.Locate('CHAVE', ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[i].RetInfEvento.chNFe, [])) then
      //gin

        // Exbibe no log para o usuário o cStat e o xMotivo do webservice
        Mensagem('NF: ' + zQueryNFCHAVE.AsString +
                ' - CSTAT: ' +  IntToStr(ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[i].RetInfEvento.cStat) +
                ' - ' + ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[i].RetInfEvento.xMotivo);

        // Atualiza no banco de dados local caso a nota tenha sido manifestada com sucesso
        if (ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[i].RetInfEvento.cStat = 135) or    // Evento vinculado
           (ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[i].RetInfEvento.cStat = 655) or    // Manifestação após final da operação
           (ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[i].RetInfEvento.cStat = 573) then  // Duplicidade de evento (já manifestada)
        begin

          UpdateManifestar(CodigoNotaFiscal);
          GerarLogNF(CodigoNotaFiscal, 3);

        end;

      //d;

    end;

    // Atualiza dados da query
    if (Refresh) then
      zQueryNF.Refresh;

  except

    on E:Exception do
    begin

      GerarLogNF(CodigoNotaFiscal, 5, E.Message);
      Mensagem('Erro: ' + E.Message);

    end;

  end;

end;

procedure TDMManifestador.Download(CodigoNotaFiscal: Integer; ChaveNF: String; Refresh: Boolean);
var
  i: Integer;
  ArqXML: TStringStream;
begin

  // Configura o componente acbr
  ConfigurarAcbr;

  try

    // Oculta o diálogo para limpar os logs anteriores
    OcultarDialogoProcessamento;
    Screen.Cursor := crHourGlass;
    Mensagem('Efetuando conexão no webservice da receita ...');
    ExibirDialogoProcessamento;

    try

      GerarLogNF(CodigoNotaFiscal, 2);
      Mensagem('Efetuando download da nota fiscal' + ChaveNF);
      // Efetua o download pelo webservice
      AcbrNFe.DistribuicaoDFePorChaveNFe(zQueryEMPRESAUF.AsInteger, zQueryEMPRESACNPJ.AsString, ChaveNF);
      //AcbrNFe.DistribuicaoDFePorNSU(zQueryEMPRESAUF.AsInteger, zQueryEMPRESACNPJ.AsString, ZQueryNFNSU.AsString);
      AcbrNFe.WebServices.DistribuicaoDFe.Executar;

      with AcbrNFe.WebServices.DistribuicaoDFe.retDistDFeInt do
      begin

        // Download efetuado
        if (cStat = 138) then
        begin

          for i := 0 to docZip.Count - 1 do
          begin

            // Verifica se o arquivo é o xml da NFE (-nfe.xml)
            if docZip.Items[i].schema = schprocNFe then
            begin

              // Extrai o arquivo xml
              ArqXML := TStringStream.Create(docZip.Items[i].XML);
              XMLDocument1.LoadFromStream(ArqXML);
              // Salva o xml no disco
              XMLDocument1.SaveToFile(ACBrNFe.Configuracoes.Arquivos.DownloadNFe.PathDownload + ChaveNF);

              // Backup do xml
              if (ZQueryEMPRESACAMINHO_COPIA_XML.AsString <> '') then
              begin

                Mensagem('Copiando ' + ZQueryEMPRESACAMINHO_COPIA_XML.AsString + ChaveNF + '-nfe.xml');
                XMLDocument1.SaveToFile(ZQueryEMPRESACAMINHO_COPIA_XML.AsString + ChaveNF + '-nfe.xml');

              end;

              ArqXML.Free;

              // Download disponibilizado
              if (cStat = 138) then
              begin

                // Atualiza o banco de dados local informando que foi efetuado download
                UpdateDownload(CodigoNotaFiscal);
                GerarLogNF(CodigoNotaFiscal, 4);
                Mensagem('Download efetuado -> NF ' + ChaveNF  + ' CSTAT: ' + IntToStr(cStat) + ' - ' + xMotivo);

                // Atualiza dados da query
                if (Refresh) then
                  zQueryNF.Refresh;

              end
              else
              begin

                Mensagem('Download não efetuado efetuado -> NF ' + ChaveNF  + ' CSTAT: ' + IntToStr(cStat) + ' - ' + xMotivo);
                GerarLogNF(CodigoNotaFiscal, 6, ' CSTAT: ' + IntToStr(cStat) + ' - ' + xMotivo);

              end;

            end;

          end;

        end
        else
        begin

          Mensagem('Download não efetuado efetuado -> NF ' + ChaveNF  + ' CSTAT: ' + IntToStr(AcbrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.cStat) + ' - ' + AcbrNFe.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo);
          GerarLogNF(CodigoNotaFiscal, 6, ' CSTAT: ' + IntToStr(cStat) + ' - ' + xMotivo);

        end;

      end;

    except

      on E:Exception do
      begin

        GerarLogNF(CodigoNotaFiscal, 6, E.Message);
        Mensagem('Não foi possível efetuar o download do XML desta nota fiscal, motivo ->  ' + E.Message);

      end;

    end;

  finally

    Screen.Cursor := crDefault;

  end;

end;

procedure TDMManifestador.Visualizar(GerarPDF: Boolean);
var
  xml: string;
begin

  try

    if (ZQueryNF.RecordCount = 0) then
      Exit;

    if (ZQueryNF.State = dsEdit) then
      ZQueryNF.Post;

    // Limpa a coleção de notas fiscais
    ACBrNFeImprimir.NotasFiscais.Clear;
    // Seta o caminho do xml
    //xml := ExtractFilePath(Application.ExeName) +  'NotasFornecedores\' + ZQueryNFCHAVE.AsString + '-nfe.xml';
    xml := ZQueryEMPRESACAMINHO.AsString + '\' + ZQueryEMPRESACNPJ.AsString + '\' + ZQueryNFCHAVE.AsString + '-nfe.xml';;

    // Verifica se o xml existe no disco e carrega para o componente acbr
    if not FileExists(xml) then
    begin

      if (ZQueryNFMANIFESTACAO.AsString = 'S') then
        raise Exception.Create('Arquivo ' + xml + ' não encontrado.')
      else
        raise Exception.Create('Arquivo ' + xml + ' não encontrado. Efetue a manifestação da NFe e efetue o download!');

    end
    else
      ACBrNFeImprimir.NotasFiscais.LoadFromFile(xml);

    // Exibe a visualização do Danfe
    if (GerarPDF) then
    begin

      SaveDialogPDF.FileName := ZQueryNFCHAVE.AsString + '-nfe.pdf';

      if (SaveDialogPDF.Execute) then
      begin

        ACBrNFeImprimir.DANFE.PathPDF := ExtractFilePath(SaveDialogPDF.FileName);
        ACBrNFeImprimir.NotasFiscais.ImprimirPDF;

      end;

    end
    else
      ACBrNFeImprimir.NotasFiscais.Imprimir;

  except

    on E:Exception do
    begin

      raise Exception.Create(E.Message)

    end;

  end;

end;

function TDMManifestador.ExisteNota(Chave: String): Boolean;
begin

  // Verifica se já existe a nota fiscal na base de dados pela chave de acesso
  with ZQueryExisteNota do
  begin

    Close;
    ParamByName('CHAVE').AsString := Chave;
    Open;

  end;

  Result := ZQueryExisteNota.FieldByName('TOTAL').AsInteger > 0;

end;

procedure TDMManifestador.GerarZip(ZipFileName: String; FilesToZip: TStringList);
var
  ZipFile: TZipFile;
  i: Integer;
begin

  ZipFile := TZipFile.Create;

  try

    try

      ZipFile.Open(ZipFileName, zmWrite);

      for i := 0 to FilesToZip.Count - 1 do
      begin

        if (FileExists(FilesToZip[i])) then
          ZipFile.Add(FilesToZip[i]);

      end;

      ZipFile.Close;


    except

      on E:Exception do
      begin

        raise Exception.Create(' Não foi possível gerar o arquivo ' + ZipFileName + ' -> ' + E.Message);

      end;

    end;

  finally

    ZipFile.Free;

  end;

end;

procedure TDMManifestador.TimerVerificarTimer(Sender: TObject);
var
  CodEmpresa: Integer;
begin

  with ZQueryEMPRESA do
  begin

    // Verifica se pode disparar a verificação automática das notas
    if (State in [dsInsert, dsEdit]) then
      Exit;

    // Verifica em qual empresa está posicionado
    CodEmpresa := ZQueryEMPRESACODIGO.AsInteger;
    First;

    // Percorre todas as empresas
    while not Eof do
    begin

      // Obtem novas notas
      ObterNotas;
      Next;

    end;

    if (ZQueryCFGDOWNLOAD_AUTOMATICO.AsString = 'S') then
    begin

      First;
      // Percorre todas as empresas
      while not Eof do
      begin

        // Manfestação automática
        ManifestacaoAutomatica;
        Next;

      end;

      First;

      // Percorre todas as empresas
      while not Eof do
      begin

        // Download Automatico
        DownloadAutomatico;
        Next;

      end;

    end;

    // Reposiciona na empresa selecionada
    ZQueryEMPRESA.Locate('CODIGO', CodEmpresa, []);

  end;

end;

procedure TDMManifestador.ManifestacaoAutomatica;
var
  zQuery: TZQuery;
begin

  zQuery := TZQuery.Create(Self);

  try

    try

      zQuery.Connection := ZConnection1;
      zQuery.SQL.Add('SELECT NF.CODIGO,                            ');
      zQuery.SQL.Add('       NF.CHAVE                              ');
      zQuery.SQL.Add('  FROM NF                                    ');
      zQuery.SQL.Add(' WHERE NF.ID_EMPRESA   = :ID_EMPRESA         ');
      zQuery.SQL.Add('   AND NF.MANIFESTACAO = ''N''               ');
      zQuery.SQL.Add('   AND NF.VISIVEL      = ''S''               ');
      zQuery.SQL.Add('   AND (SELECT COUNT (*)                     ');
      zQuery.SQL.Add('          FROM NF_LOG                        ');
      zQuery.SQL.Add('         WHERE NF_LOG.ID_NF = NF.CODIGO) = 0 ');
      zQuery.SQL.Add(' ORDER BY NF.EMISSAO                         ');
      zQuery.SQL.Add(' LIMIT 1                                     ');
      zQuery.ParamByName('ID_EMPRESA').AsInteger := ZQueryEMPRESACODIGO.AsInteger;
      zQuery.Open;

      if (not zQuery.Eof) then
        Manifestar(zQuery.FieldByName('CODIGO').AsInteger , 1, zQuery.FieldByName('CHAVE').AsString, True);

    except

      on E:Exception do
      begin

        raise Exception.Create('TDMManifestador.UpdateManifestar -> ' + E.Message);

      end;

    end;

  finally

    zQuery.Free;

  end;

end;

procedure TDMManifestador.DownloadAutomatico;
var
  zQuery: TZQuery;
begin

  zQuery := TZQuery.Create(Self);

  try

    try

      zQuery.Connection := ZConnection1;
      zQuery.SQL.Add('SELECT CODIGO,                   ');
      zQuery.SQL.Add('       CHAVE                     ');
      zQuery.SQL.Add('  FROM NF                        ');
      zQuery.SQL.Add(' WHERE ID_EMPRESA = :ID_EMPRESA  ');
      zQuery.SQL.Add('   AND DOWNLOAD   = ''N''        ');
      zQuery.SQL.Add('   AND VISIVEL    = ''S''        ');
      zQuery.SQL.Add(' ORDER BY EMISSAO                ');
      zQuery.SQL.Add(' LIMIT 1                         ');
      zQuery.ParamByName('ID_EMPRESA').AsInteger := ZQueryEMPRESACODIGO.AsInteger;
      zQuery.Open;

      if (not zQuery.Eof) then
        Download(zQuery.FieldByName('CODIGO').AsInteger, zQuery.FieldByName('CHAVE').AsString, True);

    except

      on E:Exception do
      begin

        raise Exception.Create('TDMManifestador.UpdateManifestar -> ' + E.Message);

      end;

    end;

  finally

    zQuery.Free;

  end;

end;


procedure TDMManifestador.UpdateManifestar(CodigoNotaFiscal: Integer);
var
  zQuery: TZQuery;
begin

  zQuery := TZQuery.Create(Self);

  try

    try

      zQuery.Connection := ZConnection1;
      zQuery.SQL.Add('UPDATE NF                   ');
      zQuery.SQL.Add('   SET MANIFESTACAO = ''S'' ');
      zQuery.SQL.Add(' WHERE CODIGO = :CODIGO     ');
      zQuery.ParamByName('CODIGO').AsInteger := CodigoNotaFiscal;
      zQuery.ExecSQL;

    except

      on E:Exception do
      begin

        raise Exception.Create('TDMManifestador.UpdateManifestar -> ' + E.Message);

      end;

    end;

  finally

    zQuery.Free;

  end;

end;

procedure TDMManifestador.UpdateDownload(CodigoNotaFiscal: Integer);
var
  zQuery: TZQuery;
begin

  zQuery := TZQuery.Create(Self);

  try

    try

      zQuery.Connection := ZConnection1;
      zQuery.SQL.Add('UPDATE NF                  ');
      zQuery.SQL.Add('   SET DOWNLOAD = ''S''    ');
      zQuery.SQL.Add(' WHERE CODIGO   = :CODIGO  ');
      zQuery.ParamByName('CODIGO').AsInteger := CodigoNotaFiscal;
      zQuery.ExecSQL;

    except

      on E:Exception do
      begin

        raise Exception.Create('TDMManifestador.UpdateDownload -> ' + E.Message);

      end;

    end;

  finally

    zQuery.Free;

  end;

end;

procedure TDMManifestador.ConfigurarAcbrMail;
begin

  ACBrMail1.Host := ZQueryCFGSMTP.AsString;
  ACBrMail1.Username := ZQueryCFGSMTP_CONTA.AsString;
  ACBrMail1.Password := ZQueryCFGSMTP_SENHA.AsString;
  ACBrMail1.From := ZQueryCFGSMTP_EMAIL.AsString;
  ACBrMail1.FromName := ZQueryCFGSMTP_REMETENTE.AsString;
  ACBrMail1.Port := ZQueryCFGSMTP_PORTA.AsString;
  ACBrMail1.SetSSL := True;
  ACBrMail1.SetTLS := False;
  ACBrMail1.Subject := 'Notas fiscais de fornecedores';
  ACBrMail1.AltBody.Text := 'Segue em anexo notas fiscais recebidas de fornecedores';

end;

procedure TDMManifestador.GerarLogNF(CodigoNotaFiscal, CodigoOperacao: Integer; Msg: String = '');
var
  zQuery: TZQuery;
begin

  zQuery := TZQuery.Create(Self);

  try

    try

      zQuery.Connection := ZConnection1;
      zQuery.SQL.Add('INSERT INTO NF_LOG      ');
      zQuery.SQL.Add('          (ID_NF,       ');
      zQuery.SQL.Add('           OPERACAO,    ');
      zQuery.SQL.Add('           HISTORICO,   ');
      zQuery.SQL.Add('           DATAHORA)    ');
      zQuery.SQL.Add('   VALUES (:ID_NF,      ');
      zQuery.SQL.Add('           :OPERACAO,   ');
      zQuery.SQL.Add('           :HISTORICO,  ');
      zQuery.SQL.Add('           :DATAHORA)   ');
      zQuery.ParamByName('ID_NF').AsInteger := CodigoNotaFiscal;
      zQuery.ParamByName('OPERACAO').AsInteger := CodigoOperacao;

      case CodigoOperacao of

        1: zQuery.ParamByName('HISTORICO').AsString := 'Enviado evento de manifestação ';
        2: zQuery.ParamByName('HISTORICO').AsString := 'Solicitado download do arquivo xml';
        3: zQuery.ParamByName('HISTORICO').AsString := 'Manifestação efetuada com sucesso';
        4: zQuery.ParamByName('HISTORICO').AsString := 'Download do arquivo xml efetuado com sucesso';
        5: zQuery.ParamByName('HISTORICO').AsString := 'Erro ao manifestar -> ' + Msg;
        6: zQuery.ParamByName('HISTORICO').AsString := 'Erro ao efetuar download -> ' + Msg;

      end;

      zQuery.ParamByName('DATAHORA').AsDateTime := Now;
      zQuery.ExecSQL;

    except

      on E:Exception do
      begin

        raise Exception.Create('TDMManifestador.GerarLogNF -> ' + E.Message);

      end;

    end;

  finally

    zQuery.Free;

  end;

end;

procedure TDMManifestador.ExibirDialogoProcessamento;
begin

  frmProcessamento.Show;
  frmProcessamento.BringToFront;

end;

procedure TDMManifestador.OcultarDialogoProcessamento;
begin

  frmProcessamento.ListBoxMensagens.Items.Clear;
  frmProcessamento.Hide;

end;


procedure TDMManifestador.SetActionManifestar(const Value: TAction);
begin

  FActionManifestar := Value;

end;

procedure TDMManifestador.SetActionDownload(const Value: TAction);
begin

  FActionDownload := Value;

end;

procedure TDMManifestador.SetActionVisualizar(const Value: TAction);
begin

  FActionVisualizar := Value;

end;


end.
