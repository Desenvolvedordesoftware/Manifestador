program Manifestador;

uses
  Vcl.Forms,
  UfrmPrincipal in 'UfrmPrincipal.pas' {frmPrincipal},
  UDMManifestador in 'UDMManifestador.pas' {DMManifestador: TDataModule},
  UfrmProcessamento in 'UfrmProcessamento.pas' {frmProcessamento},
  UfrmEmpresaEdit in 'UfrmEmpresaEdit.pas' {FrmEmpresaEdit},
  UFrmOpcoesManifestar in 'UFrmOpcoesManifestar.pas' {FrmOpcoesManifestar},
  UFrmEmpresas in 'UFrmEmpresas.pas' {frmEmpresas},
  UfrmEnviarXMLContabilidade in 'UfrmEnviarXMLContabilidade.pas' {frmEnviarXMLContabilidade},
  UfrmConfig in 'UfrmConfig.pas' {frmConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMManifestador, DMManifestador);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmEmpresas, frmEmpresas);
  Application.Run;
end.
