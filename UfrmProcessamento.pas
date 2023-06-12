unit UfrmProcessamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmProcessamento = class(TForm)
    Panel1: TPanel;
    btnFechar: TButton;
    MemoMensagem: TMemo;
    btnSalvar: TButton;
    ListBoxMensagens: TListBox;
    SaveDialog: TSaveDialog;
    procedure btnFecharClick(Sender: TObject);
    procedure ListBoxMensagensClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure ListBoxMensagensEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcessamento: TfrmProcessamento;

implementation

{$R *.dfm}

procedure TfrmProcessamento.btnFecharClick(Sender: TObject);
begin

  Self.Close;

end;

procedure TfrmProcessamento.ListBoxMensagensClick(Sender: TObject);
begin

  MemoMensagem.Lines.Clear;
  MemoMensagem.Lines.Add(ListBoxMensagens.Items[ListBoxMensagens.ItemIndex]);

end;

procedure TfrmProcessamento.ListBoxMensagensEnter(Sender: TObject);
begin

  MemoMensagem.Lines.Clear;
  MemoMensagem.Lines.Add(ListBoxMensagens.Items[ListBoxMensagens.ItemIndex]);

end;

procedure TfrmProcessamento.btnSalvarClick(Sender: TObject);
begin

  if (SaveDialog.Execute) then
    ListBoxMensagens.Items.SaveToFile(SaveDialog.FileName);

end;

end.
