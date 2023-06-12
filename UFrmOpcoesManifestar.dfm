object FrmOpcoesManifestar: TFrmOpcoesManifestar
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Manifestar'
  ClientHeight = 166
  ClientWidth = 306
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
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 289
    Height = 113
    ItemIndex = 0
    Items.Strings = (
      'Confirma'#231#227'o de opera'#231#227'o'
      'Ci'#234'ncia da opera'#231#227'o'
      'Opera'#231#227'o n'#227'o realizada')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Manifestar'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 89
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
