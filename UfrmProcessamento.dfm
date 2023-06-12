object frmProcessamento: TfrmProcessamento
  Left = 0
  Top = 0
  Caption = 'Processamento'
  ClientHeight = 337
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    677
    337)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 231
    Width = 677
    Height = 106
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      677
      106)
    object btnFechar: TButton
      Left = 8
      Top = 72
      Width = 81
      Height = 25
      Caption = 'Fechar'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object MemoMensagem: TMemo
      Left = 8
      Top = 16
      Width = 658
      Height = 50
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Lines.Strings = (
        '')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object btnSalvar: TButton
      Left = 96
      Top = 72
      Width = 81
      Height = 25
      Caption = 'Salvar'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnSalvarClick
    end
  end
  object ListBoxMensagens: TListBox
    Left = 8
    Top = 8
    Width = 658
    Height = 210
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBoxMensagensClick
    OnEnter = ListBoxMensagensEnter
  end
  object SaveDialog: TSaveDialog
    Left = 424
    Top = 48
  end
end
