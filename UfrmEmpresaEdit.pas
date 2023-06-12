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

  // Coloca a tela automaticamente em edi��o
  // Se o usu�rio ainda n�o configurou o caminho do xml ent�o sugere a pasta
  // "NotasFornecedores" no caminho do app
  if (DMManifestador.ZQueryEMPRESACAMINHO.AsString = '') then
    DMManifestador.ZQueryEMPRESACAMINHO.AsString :=  ExtractFilePath(Application.ExeName) +
                                                     'NotasFornecedores\';

  // Campo "Senha" s� fica vis�vel quando o caminho do PFX estiver preenchido
  edSenha.Visible := DMManifestador.ZQueryEMPRESACERTIFICADO.Text <> '';
  LabelSenha.Visible := edSenha.Visible;

end;

procedure TFrmEmpresaEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  // Se usu�rio clicar em Ok ent�o salva o registro caso contr�rio cancela a edi��o
  if ModalResult = mrOk then
  begin

    // Valida��o do preenchimento do c�digo da UF
    if (dsEMPRESA.DataSet.FieldByName('UF').AsString = '') then
    begin

      dsEMPRESA.DataSet.FieldByName('UF').FocusControl;
      raise Exception.Create('N�o foi informado o c�digo da UF!');

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

  // Exibe di�logo para selecionar certificado digital instalado na m�quina
  DMManifestador.ZQueryEMPRESANUMERO_SERIE.AsString := DMManifestador.ACBrNFe.SSL.SelecionarCertificado;
  // Configura componente ACBR para acesso via Capicom
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLCryptLib := cryCapicom;
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLHttpLib := httpWinHttp;
  DMManifestador.ACBrNFe.Configuracoes.Geral.SSLXmlSignLib := xsMsXmlCapicom;
  DMManifestador.ACBrNFe.Configuracoes.Certificados.NumeroSerie := DMManifestador.ZQueryEMPRESANUMERO_SERIE.AsString;
  // Preenche automaticamente a raz�o social e o cnpj com os dados do certificado
  DMManifestador.ZQueryEMPRESANOME.AsString := DMManifestador.ACBrNFe.SSL.CertRazaoSocial;
  DMManifestador.ZQueryEMPRESACNPJ.AsString := DMManifestador.ACBrNFe.SSL.CertCNPJ;

end;

procedure TFrmEmpresaEdit.btnSelecionarPFXClick(Sender: TObject);
begin

  // Exibe di�logo para o usu�rio informar o caminho do certificado digital
  if (OpenDialog1.Execute) then
  begin

    DMManifestador.ZQueryEMPRESACERTIFICADO.AsString := OpenDialog1.FileName;
    edSenha.Visible := DMManifestador.ZQueryEMPRESACERTIFICADO.Text <> '';
    LabelSenha.Visible := edSenha.Visible ;

  end;

end;

procedure TFrmEmpresaEdit.edCertificadoPFXExit(Sender: TObject);
begin

  // Campo "Senha" s� fica vis�vel quando o caminho do PFX estiver preenchido
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
  // Preenche automaticamente a raz�o social e o cnpj com os dados do certificado
  DMManifestador.ZQueryEMPRESANOME.AsString := DMManifestador.ACBrNFe.SSL.CertRazaoSocial;
  DMManifestador.ZQueryEMPRESACNPJ.AsString := DMManifestador.ACBrNFe.SSL.CertCNPJ;

end;

end.
