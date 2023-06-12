object frmEnviarXMLContabilidade: TfrmEnviarXMLContabilidade
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Envio de XML por email'
  ClientHeight = 511
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbxPeriodo: TGroupBox
    Left = 8
    Top = 8
    Width = 233
    Height = 89
    Caption = 'Per'#237'odo'
    TabOrder = 0
    object Label2: TLabel
      Left = 11
      Top = 24
      Width = 51
      Height = 13
      Caption = 'Data inicial'
    end
    object Label3: TLabel
      Left = 128
      Top = 24
      Width = 46
      Height = 13
      Caption = 'Data final'
    end
    object edIni: TDateTimePicker
      Left = 11
      Top = 43
      Width = 94
      Height = 21
      Date = 43171.551689375000000000
      Time = 43171.551689375000000000
      TabOrder = 0
      OnChange = edIniChange
    end
    object edFim: TDateTimePicker
      Left = 125
      Top = 43
      Width = 94
      Height = 21
      Date = 43171.551765312500000000
      Time = 43171.551765312500000000
      TabOrder = 1
      OnChange = edIniChange
    end
  end
  object GroupBox1: TGroupBox
    Left = 247
    Top = 8
    Width = 450
    Height = 89
    Caption = 'Enviar para'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 84
      Height = 13
      Caption = 'Email destinat'#225'rio'
    end
    object edEmail: TEdit
      Left = 16
      Top = 43
      Width = 425
      Height = 21
      TabOrder = 0
    end
  end
  object gbxNotasFiscais: TGroupBox
    Left = 8
    Top = 104
    Width = 693
    Height = 364
    Caption = 'Notas fiscais'
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 11
      Top = 24
      Width = 672
      Height = 321
      DataSource = dsNF
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NUMERO'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SERIE'
          Width = 33
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMISSAO'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHAVE'
          Width = 312
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SITUACAO'
          Width = 76
          Visible = True
        end>
    end
  end
  object btnEnviar: TBitBtn
    Left = 19
    Top = 474
    Width = 86
    Height = 25
    Caption = 'Enviar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnEnviarClick
  end
  object btnCancelar: TBitBtn
    Left = 111
    Top = 474
    Width = 86
    Height = 25
    Caption = 'Cancelar'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object ZQueryNF: TZQuery
    Connection = DMManifestador.ZConnection1
    SQL.Strings = (
      'SELECT *'
      '  FROM NF'
      'WHERE ID_EMPRESA = :ID_EMPRESA'
      '   AND EMISSAO BETWEEN :INICIO AND :FIM'
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
      end>
    Left = 304
    Top = 240
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
  end
  object dsNF: TDataSource
    DataSet = ZQueryNF
    Left = 344
    Top = 240
  end
end
