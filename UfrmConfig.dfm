object frmConfig: TfrmConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es'
  ClientHeight = 343
  ClientWidth = 403
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 113
    Caption = 'Automatiza'#231#227'o'
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 78
      Width = 105
      Height = 13
      Caption = 'Temporizador minutos'
    end
    object cbxVERIFICAR_AUTOMATICO: TDBCheckBox
      Left = 16
      Top = 24
      Width = 332
      Height = 17
      Caption = 'Efetuar verifica'#231#227'o de novas notas fiscais automaticamente'
      DataField = 'VERIFICAR_AUTOMATICO'
      DataSource = dsCFG
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object edTIMER: TDBEdit
      Left = 129
      Top = 78
      Width = 33
      Height = 21
      DataField = 'TIMER'
      DataSource = dsCFG
      TabOrder = 1
    end
    object cbxDOWNLOAD_AUTOMATICO: TDBCheckBox
      Left = 16
      Top = 47
      Width = 348
      Height = 17
      Caption = 'Manifestar ci'#234'ncia da opera'#231#227'o e download do xml automaticamente'
      DataField = 'DOWNLOAD_AUTOMATICO'
      DataSource = dsCFG
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 311
    Width = 75
    Height = 25
    Caption = 'OK'
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
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 89
    Top = 311
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 127
    Width = 385
    Height = 178
    Caption = 'Email'
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 26
      Height = 13
      Caption = 'SMTP'
    end
    object Label3: TLabel
      Left = 320
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object Label4: TLabel
      Left = 16
      Top = 72
      Width = 108
      Height = 13
      Caption = 'Nome da conta (Login)'
    end
    object Label5: TLabel
      Left = 271
      Top = 72
      Width = 75
      Height = 13
      Caption = 'Senha da conta'
    end
    object Label6: TLabel
      Left = 16
      Top = 120
      Width = 95
      Height = 13
      Caption = 'Nome do remetente'
    end
    object Label7: TLabel
      Left = 162
      Top = 120
      Width = 92
      Height = 13
      Caption = 'Email do remetente'
    end
    object edSMTP: TDBEdit
      Left = 16
      Top = 43
      Width = 297
      Height = 21
      DataField = 'SMTP'
      DataSource = dsCFG
      TabOrder = 0
    end
    object edSMTP_PORTA: TDBEdit
      Left = 319
      Top = 43
      Width = 54
      Height = 21
      DataField = 'SMTP_PORTA'
      DataSource = dsCFG
      TabOrder = 1
    end
    object edSMTP_CONTA: TDBEdit
      Left = 16
      Top = 91
      Width = 249
      Height = 21
      DataField = 'SMTP_CONTA'
      DataSource = dsCFG
      TabOrder = 2
    end
    object edSMTP_SENHA: TDBEdit
      Left = 273
      Top = 91
      Width = 100
      Height = 21
      DataField = 'SMTP_SENHA'
      DataSource = dsCFG
      PasswordChar = '*'
      TabOrder = 3
    end
    object edSMTP_REMETENTE: TDBEdit
      Left = 16
      Top = 139
      Width = 140
      Height = 21
      DataField = 'SMTP_REMETENTE'
      DataSource = dsCFG
      TabOrder = 4
    end
    object edSMTP_EMAIL: TDBEdit
      Left = 162
      Top = 139
      Width = 211
      Height = 21
      DataField = 'SMTP_EMAIL'
      DataSource = dsCFG
      TabOrder = 5
    end
  end
  object dsCFG: TDataSource
    DataSet = DMManifestador.ZQueryCFG
    Left = 232
    Top = 96
  end
end
