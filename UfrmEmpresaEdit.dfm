object FrmEmpresaEdit: TFrmEmpresaEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dados da empresa'
  ClientHeight = 305
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 109
    Width = 122
    Height = 13
    Caption = 'CNPJ (Somente n'#250'meros)'
  end
  object Label2: TLabel
    Left = 18
    Top = 61
    Width = 194
    Height = 13
    Caption = 'Caminho do arquivo do certificado digital'
  end
  object LabelSenha: TLabel
    Left = 342
    Top = 61
    Width = 98
    Height = 13
    Caption = 'Senha do certificado'
  end
  object btnSelecionarPFX: TSpeedButton
    Left = 312
    Top = 79
    Width = 23
    Height = 23
    Caption = '...'
    OnClick = btnSelecionarPFXClick
  end
  object Label4: TLabel
    Left = 393
    Top = 109
    Width = 49
    Height = 13
    Caption = 'C'#243'digo UF'
  end
  object Label5: TLabel
    Left = 18
    Top = 163
    Width = 95
    Height = 13
    Caption = 'Caminho salvar XML'
  end
  object Label6: TLabel
    Left = 18
    Top = 15
    Width = 78
    Height = 13
    Caption = 'Numero de s'#233'rie'
  end
  object btnSelecionarNumeroSerie: TSpeedButton
    Left = 416
    Top = 33
    Width = 23
    Height = 23
    Caption = '...'
    OnClick = btnSelecionarNumeroSerieClick
  end
  object Label7: TLabel
    Left = 145
    Top = 109
    Width = 60
    Height = 13
    Caption = 'Raz'#227'o Social'
  end
  object DBText1: TDBText
    Left = 403
    Top = 277
    Width = 41
    Height = 13
    AutoSize = True
    DataField = 'CODIGO'
    DataSource = dsEMPRESA
  end
  object Label8: TLabel
    Left = 343
    Top = 277
    Width = 54
    Height = 13
    Caption = 'Id Empresa'
  end
  object Label3: TLabel
    Left = 18
    Top = 216
    Width = 140
    Height = 13
    Caption = 'Caminho para backup do XML'
  end
  object edCNPJ: TDBEdit
    Left = 17
    Top = 128
    Width = 122
    Height = 21
    DataField = 'CNPJ'
    DataSource = dsEMPRESA
    TabOrder = 3
  end
  object edCertificadoPFX: TDBEdit
    Left = 18
    Top = 80
    Width = 295
    Height = 21
    DataField = 'CERTIFICADO'
    DataSource = dsEMPRESA
    TabOrder = 1
    OnExit = edCertificadoPFXExit
  end
  object edSenha: TDBEdit
    Left = 342
    Top = 80
    Width = 100
    Height = 21
    DataField = 'SENHA'
    DataSource = dsEMPRESA
    PasswordChar = '*'
    TabOrder = 2
    OnExit = edSenhaExit
  end
  object btnConfirmar: TButton
    Left = 17
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    ModalResult = 1
    TabOrder = 7
  end
  object btnCancelar: TButton
    Left = 98
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 8
  end
  object edCodigoUF: TDBEdit
    Left = 393
    Top = 128
    Width = 49
    Height = 21
    CharCase = ecUpperCase
    DataField = 'UF'
    DataSource = dsEMPRESA
    TabOrder = 4
  end
  object edCaminhoXML: TDBEdit
    Left = 18
    Top = 182
    Width = 425
    Height = 21
    DataField = 'CAMINHO'
    DataSource = dsEMPRESA
    TabOrder = 5
  end
  object edNumeroSerie: TDBEdit
    Left = 18
    Top = 34
    Width = 399
    Height = 21
    DataField = 'NUMERO_SERIE'
    DataSource = dsEMPRESA
    TabOrder = 0
  end
  object edNome: TDBEdit
    Left = 145
    Top = 128
    Width = 242
    Height = 21
    DataField = 'NOME'
    DataSource = dsEMPRESA
    TabOrder = 9
  end
  object edCAMINHO_COPIA_XML: TDBEdit
    Left = 18
    Top = 235
    Width = 425
    Height = 21
    DataField = 'CAMINHO_COPIA_XML'
    DataSource = dsEMPRESA
    TabOrder = 6
  end
  object dsEMPRESA: TDataSource
    DataSet = DMManifestador.ZQueryEMPRESA
    Left = 288
    Top = 152
  end
  object OpenDialog1: TOpenDialog
    Left = 320
    Top = 152
  end
end
