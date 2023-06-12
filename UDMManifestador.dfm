object DMManifestador: TDMManifestador
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 390
  Width = 687
  object ACBrNFe: TACBrNFe
    Configuracoes.Geral.SSLLib = libCustom
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpWinHttp
    Configuracoes.Geral.SSLXmlSignLib = xsXmlSec
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'PR'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 392
    Top = 32
  end
  object ACBrNFeDANFeRL1: TACBrNFeDANFeRL
    ACBrNFe = ACBrNFeImprimir
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiRetrato
    NumCopias = 1
    ImprimeNomeFantasia = False
    ImprimirDescPorc = False
    ImprimirTotalLiquido = True
    MargemInferior = 0.700000000000000000
    MargemSuperior = 0.700000000000000000
    MargemEsquerda = 0.700000000000000000
    MargemDireita = 0.700000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais._qCom = 4
    CasasDecimais._vUnCom = 4
    CasasDecimais._Mask_qCom = ',0.00'
    CasasDecimais._Mask_vUnCom = ',0.00'
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 10
    ProdutosPorPagina = 0
    ImprimirDetalhamentoEspecifico = True
    NFeCancelada = False
    ImprimirItens = True
    ViaConsumidor = True
    TamanhoLogoHeight = 0
    TamanhoLogoWidth = 0
    RecuoEndereco = 0
    RecuoEmpresa = 0
    LogoemCima = False
    TamanhoFonteEndereco = 0
    RecuoLogo = 0
    LarguraCodProd = 54
    ExibirEAN = False
    QuebraLinhaEmDetalhamentoEspecifico = True
    ExibeCampoFatura = False
    ImprimirUnQtVlComercial = iuComercial
    ImprimirDadosDocReferenciados = True
    Left = 480
    Top = 32
  end
  object XMLDocument1: TXMLDocument
    Left = 288
    Top = 32
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Connected = True
    BeforeConnect = ZConnection1BeforeConnect
    HostName = ''
    Port = 0
    Database = 'C:\Dev\Projetos\MMTech\Manifestador\Database\manifestador.db'
    User = ''
    Password = ''
    Protocol = 'sqlite-3'
    Left = 48
    Top = 40
  end
  object ZQueryEMPRESA: TZQuery
    Connection = ZConnection1
    UpdateObject = ZUpdateSQLEMPRESA
    SQL.Strings = (
      'SELECT *'
      '  FROM "EMPRESA"')
    Params = <>
    Left = 48
    Top = 104
    object ZQueryEMPRESACODIGO: TLargeintField
      FieldName = 'CODIGO'
    end
    object ZQueryEMPRESACNPJ: TWideStringField
      FieldName = 'CNPJ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ZQueryEMPRESACERTIFICADO: TWideStringField
      FieldName = 'CERTIFICADO'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object ZQueryEMPRESASENHA: TWideStringField
      FieldName = 'SENHA'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryEMPRESAUF: TLargeintField
      FieldName = 'UF'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryEMPRESACAMINHO: TWideStringField
      FieldName = 'CAMINHO'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object ZQueryEMPRESANOME: TWideStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object ZQueryEMPRESANUMERO_SERIE: TWideStringField
      FieldName = 'NUMERO_SERIE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object ZQueryEMPRESACAMINHO_COPIA_XML: TWideStringField
      FieldName = 'CAMINHO_COPIA_XML'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
  end
  object ZQueryNF: TZQuery
    Connection = ZConnection1
    AfterOpen = ZQueryNFAfterOpen
    AfterScroll = ZQueryNFAfterScroll
    UpdateObject = ZUpdateSQLNF
    OnNewRecord = zQueryNFNewRecord
    SQL.Strings = (
      'SELECT *'
      '  FROM NF'
      'WHERE ID_EMPRESA = :ID_EMPRESA'
      '   AND EMISSAO BETWEEN :INICIO AND :FIM'
      '   AND (MANIFESTACAO = :MANIFESTACAO OR :MANIFESTACAO = '#39'T'#39')'
      '   AND (DOWNLOAD = :DOWNLOAD OR :DOWNLOAD = '#39'T'#39')'
      '   AND VISIVEL = '#39'S'#39)
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID_EMPRESA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'INICIO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MANIFESTACAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOWNLOAD'
        ParamType = ptUnknown
      end>
    Left = 48
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_EMPRESA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'INICIO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FIM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MANIFESTACAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOWNLOAD'
        ParamType = ptUnknown
      end>
    object ZQueryNFCODIGO: TLargeintField
      DisplayLabel = '#'
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ZQueryNFNUMERO: TLargeintField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFNSU: TLargeintField
      FieldName = 'NSU'
    end
    object ZQueryNFSERIE: TLargeintField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'SERIE'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFCNPJ: TWideStringField
      FieldName = 'CNPJ'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFNOME: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object ZQueryNFEMISSAO: TDateField
      DisplayLabel = 'Dt. Emiss'#227'o'
      FieldName = 'EMISSAO'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
      currency = True
    end
    object ZQueryNFTIPO: TWideStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFSITUACAO: TWideStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFCHAVE: TWideStringField
      DisplayLabel = 'Chave'
      FieldName = 'CHAVE'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object ZQueryNFIE: TWideStringField
      FieldName = 'IE'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFPROTOCOLO: TWideStringField
      DisplayLabel = 'Protocolo'
      FieldName = 'PROTOCOLO'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object ZQueryNFDATAREC: TDateField
      DisplayLabel = 'Dt. Recebimento'
      FieldName = 'DATAREC'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFMANIFESTACAO: TWideStringField
      DisplayLabel = 'Manifestado'
      FieldName = 'MANIFESTACAO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object ZQueryNFDOWNLOAD: TWideStringField
      DisplayLabel = 'Donwload'
      FieldName = 'DOWNLOAD'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object ZQueryNFAMBIENTE: TWideStringField
      DisplayLabel = 'Ambiente'
      FieldName = 'AMBIENTE'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object ZQueryNFID_EMPRESA: TLargeintField
      FieldName = 'ID_EMPRESA'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryNFVISIVEL: TWideStringField
      FieldName = 'VISIVEL'
      Size = 1
    end
  end
  object ZQueryNSU: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT MAX(NSU)  NSU'
      ' FROM NF        '
      ' WHERE ID_EMPRESA= :ID_EMPRESA'
      '   AND AMBIENTE = :AMBIENTE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID_EMPRESA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AMBIENTE'
        ParamType = ptUnknown
      end>
    Left = 288
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_EMPRESA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AMBIENTE'
        ParamType = ptUnknown
      end>
  end
  object ZUpdateSQLEMPRESA: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM "EMPRESA"'
      'WHERE'
      '  "EMPRESA".CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'INSERT INTO "EMPRESA"'
      
        '  (CODIGO, CNPJ, CERTIFICADO, SENHA, UF, CAMINHO, NOME, NUMERO_S' +
        'ERIE, CAMINHO_COPIA_XML)'
      'VALUES'
      
        '  (:CODIGO, :CNPJ, :CERTIFICADO, :SENHA, :UF, :CAMINHO, :NOME, :' +
        'NUMERO_SERIE, '
      '   :CAMINHO_COPIA_XML)')
    ModifySQL.Strings = (
      'UPDATE "EMPRESA" SET'
      '  CODIGO = :CODIGO,'
      '  CNPJ = :CNPJ,'
      '  CERTIFICADO = :CERTIFICADO,'
      '  SENHA = :SENHA,'
      '  UF = :UF,'
      '  CAMINHO = :CAMINHO,'
      '  NOME = :NOME,'
      '  NUMERO_SERIE = :NUMERO_SERIE,'
      '  CAMINHO_COPIA_XML = :CAMINHO_COPIA_XML'
      'WHERE'
      '  "EMPRESA".CODIGO = :OLD_CODIGO')
    UseSequenceFieldForRefreshSQL = False
    Left = 176
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CNPJ'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CERTIFICADO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SENHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'UF'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CAMINHO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NOME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NUMERO_SERIE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CAMINHO_COPIA_XML'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object ZUpdateSQLNF: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM NF'
      'WHERE'
      '  NF.CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'INSERT INTO NF'
      
        '  (CODIGO, ID_EMPRESA, NUMERO, SERIE, CNPJ, NOME, EMISSAO, VALOR' +
        ', TIPO, '
      
        '   SITUACAO, CHAVE, IE, PROTOCOLO, DATAREC, MANIFESTACAO, DOWNLO' +
        'AD, AMBIENTE, '
      '   NSU, VISIVEL)'
      'VALUES'
      
        '  (:CODIGO, :ID_EMPRESA, :NUMERO, :SERIE, :CNPJ, :NOME, :EMISSAO' +
        ', :VALOR, '
      
        '   :TIPO, :SITUACAO, :CHAVE, :IE, :PROTOCOLO, :DATAREC, :MANIFES' +
        'TACAO, '
      '   :DOWNLOAD, :AMBIENTE, :NSU, :VISIVEL)')
    ModifySQL.Strings = (
      'UPDATE NF SET'
      '  CODIGO = :CODIGO,'
      '  ID_EMPRESA = :ID_EMPRESA,'
      '  NUMERO = :NUMERO,'
      '  SERIE = :SERIE,'
      '  CNPJ = :CNPJ,'
      '  NOME = :NOME,'
      '  EMISSAO = :EMISSAO,'
      '  VALOR = :VALOR,'
      '  TIPO = :TIPO,'
      '  SITUACAO = :SITUACAO,'
      '  CHAVE = :CHAVE,'
      '  IE = :IE,'
      '  PROTOCOLO = :PROTOCOLO,'
      '  DATAREC = :DATAREC,'
      '  MANIFESTACAO = :MANIFESTACAO,'
      '  DOWNLOAD = :DOWNLOAD,'
      '  AMBIENTE = :AMBIENTE,'
      '  NSU = :NSU,'
      '  VISIVEL = :VISIVEL'
      'WHERE'
      '  NF.CODIGO = :OLD_CODIGO')
    UseSequenceFieldForRefreshSQL = False
    Left = 176
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_EMPRESA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NUMERO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SERIE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CNPJ'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NOME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EMISSAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'VALOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TIPO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SITUACAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CHAVE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PROTOCOLO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAREC'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MANIFESTACAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOWNLOAD'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'AMBIENTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NSU'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'VISIVEL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object ACBrNFeImprimir: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    DANFE = ACBrNFeDANFeRL1
    Left = 400
    Top = 104
  end
  object SaveDialogPDF: TSaveDialog
    Filter = 'Arquivos PDF|*.PDF'
    Left = 280
    Top = 104
  end
  object ZQueryExisteNota: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT COUNT(*) TOTAL'
      '  FROM NF'
      ' WHERE CHAVE = :CHAVE')
    Params = <
      item
        DataType = ftUnknown
        Name = 'CHAVE'
        ParamType = ptUnknown
      end>
    Left = 400
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CHAVE'
        ParamType = ptUnknown
      end>
  end
  object ZQueryCFG: TZQuery
    Connection = ZConnection1
    UpdateObject = ZUpdateSQLCFG
    OnNewRecord = ZQueryCFGNewRecord
    SQL.Strings = (
      'SELECT * '
      '  FROM CFG')
    Params = <>
    Left = 520
    Top = 112
    object ZQueryCFGCODIGO: TLargeintField
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object ZQueryCFGVERIFICAR_AUTOMATICO: TWideStringField
      FieldName = 'VERIFICAR_AUTOMATICO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object ZQueryCFGDOWNLOAD_AUTOMATICO: TWideStringField
      FieldName = 'DOWNLOAD_AUTOMATICO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object ZQueryCFGTIMER: TLargeintField
      FieldName = 'TIMER'
      ProviderFlags = [pfInUpdate]
    end
    object ZQueryCFGSMTP: TWideStringField
      FieldName = 'SMTP'
      Size = 50
    end
    object ZQueryCFGSMTP_CONTA: TWideStringField
      FieldName = 'SMTP_CONTA'
      Size = 50
    end
    object ZQueryCFGSMTP_REMETENTE: TWideStringField
      FieldName = 'SMTP_REMETENTE'
      Size = 50
    end
    object ZQueryCFGSMTP_EMAIL: TWideStringField
      FieldName = 'SMTP_EMAIL'
      Size = 80
    end
    object ZQueryCFGSMTP_SENHA: TWideStringField
      FieldName = 'SMTP_SENHA'
    end
    object ZQueryCFGSMTP_PORTA: TLargeintField
      FieldName = 'SMTP_PORTA'
    end
  end
  object ZUpdateSQLCFG: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM CFG'
      'WHERE'
      '  CFG.CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'INSERT INTO CFG'
      
        '  (CODIGO, VERIFICAR_AUTOMATICO, DOWNLOAD_AUTOMATICO, TIMER, SMT' +
        'P, SMTP_CONTA, '
      '   SMTP_REMETENTE, SMTP_EMAIL, SMTP_SENHA, SMTP_PORTA)'
      'VALUES'
      
        '  (:CODIGO, :VERIFICAR_AUTOMATICO, :DOWNLOAD_AUTOMATICO, :TIMER,' +
        ' :SMTP, '
      
        '   :SMTP_CONTA, :SMTP_REMETENTE, :SMTP_EMAIL, :SMTP_SENHA, :SMTP' +
        '_PORTA)')
    ModifySQL.Strings = (
      'UPDATE CFG SET'
      '  CODIGO = :CODIGO,'
      '  VERIFICAR_AUTOMATICO = :VERIFICAR_AUTOMATICO,'
      '  DOWNLOAD_AUTOMATICO = :DOWNLOAD_AUTOMATICO,'
      '  TIMER = :TIMER,'
      '  SMTP = :SMTP,'
      '  SMTP_CONTA = :SMTP_CONTA,'
      '  SMTP_REMETENTE = :SMTP_REMETENTE,'
      '  SMTP_EMAIL = :SMTP_EMAIL,'
      '  SMTP_SENHA = :SMTP_SENHA,'
      '  SMTP_PORTA = :SMTP_PORTA'
      'WHERE'
      '  CFG.CODIGO = :OLD_CODIGO')
    UseSequenceFieldForRefreshSQL = False
    Left = 608
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'VERIFICAR_AUTOMATICO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DOWNLOAD_AUTOMATICO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TIMER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SMTP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SMTP_CONTA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SMTP_REMETENTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SMTP_EMAIL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SMTP_SENHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SMTP_PORTA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object TimerVerificar: TTimer
    Enabled = False
    OnTimer = TimerVerificarTimer
    Left = 616
    Top = 176
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 176
    Top = 40
  end
  object ZQueryNF_LOG: TZQuery
    Connection = ZConnection1
    BeforeOpen = ZQueryNF_LOGBeforeOpen
    SQL.Strings = (
      'SELECT CODIGO,'
      '       ID_NF,'
      '       OPERACAO,'
      '       DATAHORA,'
      '       HISTORICO'
      '  FROM NF_LOG'
      ' WHERE ID_NF = :ID_NF')
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID_NF'
        ParamType = ptUnknown
      end>
    Left = 48
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_NF'
        ParamType = ptUnknown
      end>
    object ZQueryNF_LOGCODIGO: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
    end
    object ZQueryNF_LOGID_NF: TLargeintField
      DisplayLabel = 'C'#243'digo NF'
      FieldName = 'ID_NF'
    end
    object ZQueryNF_LOGOPERACAO: TLargeintField
      DisplayLabel = 'Id Opera'#231#227'o'
      FieldName = 'OPERACAO'
    end
    object ZQueryNF_LOGDATAHORA: TDateTimeField
      DisplayLabel = 'Data/hora'
      FieldName = 'DATAHORA'
    end
    object ZQueryNF_LOGHISTORICO: TWideStringField
      DisplayLabel = 'Hist'#243'rico'
      FieldName = 'HISTORICO'
      Size = 80
    end
  end
end
