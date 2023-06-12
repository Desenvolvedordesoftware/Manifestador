unit UfrmEmpresaEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, ACBrDFeSSL;

type
  TFrmEmpresaEdit = class(TForm)
    dsEMPRESA: TDataSource;
    edCNPJ: TDBEdit;
    edCertificadoPFX: TDBEdit;
    edSenha: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelSenha: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    btnSelecionarPFX: TSpeedButton;
    OpenDialog1: TOpenDialog;
    edCodigoUF: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    edCaminhoXML: TDBEdit;
    edNumeroSerie: TDBEdit;
    Label6: TLabel;
    btnSelecionarNumeroSerie: TSpeedButton;
    edNome: TDBEdit;
    Label7: TLabel;
    DBText1: TDBText;
    Label8: TLabel;
    edCAMINHO_COPIA_XML: TDBEdit;
    Label3: TLabel;
    procedure btnSelecionarPFXClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelecionarNumeroSerieClick(Sender: TObject);
    procedure edCertificadoPFXExit(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEmpresaEdit: TFrmEmpresaEdit;

implementation

uses
  UDMManifestador;

{$R *.dfm}

procedure TFrmEmpresaEdit.FormCreate(Sender: TObject);
begin

  // Coloca a tela automaticamente em edição
  // Se o usuário ainda não configurou o caminho do xml então sugere a pasta
  // "NotasFornecedores" no caminho do app
  if (DMManifestador.ZQueryEMPRESACAMINHO.AsString = '') then
    DMManifestador.ZQueryEMPRESACAMINHO.AsString :=  ExtractFilePath(Application.ExeName) +
                                                     'NotasFornecedores\';

  // Campo "Senha" só fica visível quando o caminho do PFX estiver preenchido
  edSenha.Visible := DMManifestador.ZQueryEMPRESACERTIFICADO.Text <> '';
  LabelSenha.Visible := edSenha.Visible;

end;

procedure TFrmEmpresaEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  // Se usuário clicar em Ok então salva o registro caso contrário cancela a edição
  if ModalResult = mrOk then
  begin

    // Validação do preenchimento do código da UF
    if (dsEMPRESA.DataSet.FieldByName('UF').AsString = '') then
    begin

      dsEMPRESA.DataSet.FieldByName('UF').FocusControl;
      raise Exception.Create('Não foi informado o código da UF!');

    end;

    DMManifestador.ZQueryEMPRESA.Post;

  end
  else
  begin

    DMManifestador.ZQueryEMPRESA.Cancel;

  end;


end;

procedure TFrmEmpresaEdit.btnSelecionarNumeroSerieClick(Sender: TObject);
begin

  // Exibe diálogo para selecionar certificado digital instalado na máquina
  DMManifestador.ZQueryEMPRESANUMERO_SERIE.AsString := DMManifestador.ACBrNFe.SSL.SelecionarCertificado;
  // Configura componente ACBR para acesso via Capicom
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryCapicom;
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpWinHttp;
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLXmlSignLib := xsMsXmlCapicom;
  DMManifestador.ACBrNFe.Configuracoes.Certificados.NumeroSerie := DMManifestador.ZQueryEMPRESANUMERO_SERIE.AsString;
  // Preenche automaticamente a razão social e o cnpj com os dados do certificado
  DMManifestador.ZQueryEMPRESANOME.AsString := DMManifestador.ACBrNFe.SSL.CertRazaoSocial;
  DMManifestador.ZQueryEMPRESACNPJ.AsString := DMManifestador.ACBrNFe.SSL.CertCNPJ;

end;

procedure TFrmEmpresaEdit.btnSelecionarPFXClick(Sender: TObject);
begin

  // Exibe diálogo para o usuário informar o caminho do certificado digital
  if (OpenDialog1.Execute) then
  begin

    DMManifestador.ZQueryEMPRESACERTIFICADO.AsString := OpenDialog1.FileName;
    edSenha.Visible := DMManifestador.ZQueryEMPRESACERTIFICADO.Text <> '';
    LabelSenha.Visible := edSenha.Visible ;

  end;

end;

procedure TFrmEmpresaEdit.edCertificadoPFXExit(Sender: TObject);
begin

  // Campo "Senha" só fica visível quando o caminho do PFX estiver preenchido
  edSenha.Visible := DMManifestador.ZQueryEMPRESACERTIFICADO.Text <> '';
  LabelSenha.Visible := edSenha.Visible ;

end;

procedure TFrmEmpresaEdit.edSenhaExit(Sender: TObject);
begin

  // Ao digitar a senha configura o acbr para acesso direto ao pfx
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryWinCrypt;
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpWinHttp;
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLXmlSignLib := xsXmlSec;
  DMManifestador.ACBrNFe.Configuracoes.Certificados.ArquivoPFX := DMManifestador.zQueryEMPRESACERTIFICADO.AsString;
  DMManifestador.ACBrNFe.Configuracoes.Certificados.Senha := edSenha.Text;
  // Preenche automaticamente a razão social e o cnpj com os dados do certificado
  DMManifestador.ZQueryEMPRESANOME.AsString := DMManifestador.ACBrNFe.SSL.CertRazaoSocial;
  DMManifestador.ZQueryEMPRESACNPJ.AsString := DMManifestador.ACBrNFe.SSL.CertCNPJ;

end;

end.
