object frmEmpresas: TfrmEmpresas
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de empresas'
  ClientHeight = 361
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 609
    Height = 313
    DataSource = dsEmpresa
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
        FieldName = 'CODIGO'
        Title.Caption = '#'
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ'
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Raz'#227'o Social'
        Width = 370
        Visible = True
      end>
  end
  object btnNovo: TButton
    Left = 8
    Top = 327
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 1
    OnClick = btnNovoClick
  end
  object btnAlterar: TButton
    Left = 89
    Top = 327
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 2
    OnClick = btnAlterarClick
  end
  object btnExcluir: TButton
    Left = 170
    Top = 327
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 3
    OnClick = btnExcluirClick
  end
  object Button1: TButton
    Left = 251
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Fechar'
    ModalResult = 1
    TabOrder = 4
  end
  object dsEmpresa: TDataSource
    DataSet = DMManifestador.ZQueryEMPRESA
    Left = 336
    Top = 184
  end
end
