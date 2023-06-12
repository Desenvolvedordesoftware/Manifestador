unit UFrmEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TfrmEmpresas = class(TForm)
    DBGrid1: TDBGrid;
    dsEmpresa: TDataSource;
    btnNovo: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    Button1: TButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmpresas: TfrmEmpresas;

implementation

{$R *.dfm}

uses UDMManifestador, UfrmEmpresaEdit;

procedure TfrmEmpresas.btnNovoClick(Sender: TObject);
begin

  // Exibe di�logo para inclus�o de nova empresa
  try

    DMManifestador.ZQueryEMPRESA.Insert;
    FrmEmpresaEdit := TFrmEmpresaEdit.Create(Self);
    FrmEmpresaEdit.ShowModal;
    DMManifestador.ZQueryEMPRESA.Refresh;

  finally

    FreeAndNil(FrmEmpresaEdit);

  end;

end;

procedure TfrmEmpresas.btnAlterarClick(Sender: TObject);
begin

  // Exibe di�logo para altera��o da empresa
  try

    DMManifestador.ZQueryEMPRESA.Edit;
    FrmEmpresaEdit := TFrmEmpresaEdit.Create(Self);
    FrmEmpresaEdit.ShowModal;
    DMManifestador.ZQueryEMPRESA.Refresh;

  finally

    FreeAndNil(FrmEmpresaEdit);

  end;


end;

procedure TfrmEmpresas.btnExcluirClick(Sender: TObject);
begin

  // Pede para usu�rio confirmar a exclus�o da empresa
  if (Application.MessageBox('Deseja realmente excluir?', 'Confirma��o', MB_YESNO) = IDYES) then
    DMManifestador.ZQueryEMPRESA.Delete;

end;


end.
