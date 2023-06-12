unit UfrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.ImgList,
  Data.DB, Vcl.ExtCtrls, Vcl.StdCtrls, pcnConversao, System.ImageList;

type
  TfrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    DBGrid1: TDBGrid;
    CoolBar1: TCoolBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ActionArquivoSair: TAction;
    Sair1: TMenuItem;
    ActionObterNotas: TAction;
    ActionManifestar: TAction;
    ActionDownload: TAction;
    ActionVisualizar: TAction;
    ImageList: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    DataSource: TDataSource;
    Panel1: TPanel;
    gbxPeriodo: TGroupBox;
    edDataInicial: TDateTimePicker;
    edDataFinal: TDateTimePicker;
    ActionEmpresas: TAction;
    Configuraes1: TMenuItem;
    rgFiltro: TRadioGroup;
    PopupMenuGrid: TPopupMenu;
    Manifestar1: TMenuItem;
    Download1: TMenuItem;
    Visualizar1: TMenuItem;
    gbxEmpresa: TGroupBox;
    ComboBoxEmpresa: TComboBox;
    ActionPDF: TAction;
    ToolButton6: TToolButton;
    ActionEnviarContabilidade: TAction;
    EnviarXMLcontabilidade1: TMenuItem;
    N1: TMenuItem;
    ActionConfig: TAction;
    Configuraes2: TMenuItem;
    Splitter1: TSplitter;
    DBGrid2: TDBGrid;
    dsNF_LOG: TDataSource;
    procedure ActionArquivoSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edDataInicialChange(Sender: TObject);
    procedure ActionObterNotasExecute(Sender: TObject);
    procedure ActionEmpresasExecute(Sender: TObject);
    procedure ActionManifestarExecute(Sender: TObject);
    procedure ActionVisualizarExecute(Sender: TObject);
    procedure ActionDownloadExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure ActionPDFExecute(Sender: TObject);
    procedure ComboBoxEmpresaChange(Sender: TObject);
    procedure ActionEnviarContabilidadeExecute(Sender: TObject);
    procedure ActionConfigExecute(Sender: TObject);
  private

    { Private declarations }
    procedure ListarNotas;
    procedure ExibirEmpresas;
    procedure Manifestar;
    procedure AtualizarComboBoxEmpresas;

  public
    { Public declarations }

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  UDMManifestador, UFrmOpcoesManifestar, UFrmEmpresas,
  UfrmEnviarXMLContabilidade, UfrmConfig;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

  // Inicialização da data inicia e final com a data atual
  edDataInicial.Date := Date;
  edDataFinal.Date := Date;
  // Atualiza a status bar com a informação do atual do ambiente do webservice da receita
  if (DMManifestador.ACBRNFe.Configuracoes.WebServices.Ambiente = taProducao) then
    StatusBar1.Panels[0].Text := 'Ambiente: Produção'
  else
    StatusBar1.Panels[0].Text := 'Ambiente: Homologação';

  // Seta as Actions "Manifestar", "Download" e "Visualizar" para que possam
  // ser habilitadas/desabilidadas conforme a situação de cada xml
  DMManifestador.ActionManifestar := ActionManifestar;
  DMManifestador.ActionDownload := ActionDownload;
  DMManifestador.ActionVisualizar := ActionVisualizar;
  // Exibe as notas fiscais
  ListarNotas;
  // Exibe tela de configuração no primeiro acesso
  if (DMManifestador.ZQueryEMPRESA.RecordCount = 0) then
    ExibirEmpresas;

  // Lista as empresas no CombBox
  AtualizarComboBoxEmpresas;

end;

procedure TfrmPrincipal.edDataInicialChange(Sender: TObject);
begin

  // Ao alterar a data inicial o final atualiza a lista de notas fiscais
  if (DMManifestador.ZQueryNF.Active) then
    ListarNotas;

end;

procedure TFrmPrincipal.ListarNotas;
begin

  // Verifica o filtro desejado na exibição das notas fiscais
  case rgFiltro.ItemIndex of

    // Todas
    0: DMManifestador.ListarNotas(edDataInicial.Date, edDataFinal.Date, False, False);

    // Baixadas
    1: DMManifestador.ListarNotas(edDataInicial.Date, edDataFinal.Date, True, False);

    // Manifestadas
    2: DMManifestador.ListarNotas(edDataInicial.Date, edDataFinal.Date, False, True);

  end;

end;

procedure TfrmPrincipal.ExibirEmpresas;
begin

  // Exibe o diálogo de cadastro de empresas

  try

    frmEmpresas := TfrmEmpresas.Create(Self);

    if (frmEmpresas.ShowModal = mrOk) then
      AtualizarComboBoxEmpresas;

    ActionObterNotas.Enabled := DMManifestador.ZQueryEMPRESA.RecordCount > 0;

  finally

    FreeAndNil(frmEmpresas);

  end;

end;

procedure TFrmPrincipal.AtualizarComboBoxEmpresas;
var
  ItemIndexAnterior: Integer;
begin

  // Memoriza em qual empresa o usuário estava trabalhando
  ItemIndexAnterior := ComboBoxEmpresa.ItemIndex;
  // Limpa a lista de empresas
  ComboBoxEmpresa.Items.Clear;

  // Percorre o cadastro de empresas adicionando os nomes na combobox
  with DMManifestador.ZQueryEMPRESA do
  begin

    First;

    while not Eof do
    begin

      ComboBoxEmpresa.Items.Add(DMManifestador.ZQueryEMPRESANOME.AsString);
      Next;

    end;

    First;

  end;

  // Posicionando a combobox na empresa selecionada anteriormente
  if (ComboBoxEmpresa.Items.Count > 0)  then
  begin

    // No primeiro acesso não tem ItemIndexAnterior então posiciona na primeira empresa
    if (ItemIndexAnterior= -1) then
      ComboBoxEmpresa.ItemIndex := 0
    else
      ComboBoxEmpresa.ItemIndex := ItemIndexAnterior;

    // Força evento Change do combobox para sincronizar com a ZQueryEmpresa
    ComboBoxEmpresaChange(ComboBoxEmpresa)

  end;

end;

procedure TfrmPrincipal.ComboBoxEmpresaChange(Sender: TObject);
begin

  // Ao selecionar a empresa que usuário deseja trabalhar, posiciona o ponteiro da
  // ZQuery para a empresa selecionada no combobox
  DMManifestador.ZQueryEMPRESA.Locate('NOME', ComboBoxEmpresa.Text, []);
  // Carrega as configurações do Acbr para a empresa selecionada
  DMManifestador.ConfigurarAcbr;
  // Atualiza a lista de notas
  ListarNotas;

end;

procedure TfrmPrincipal.Manifestar;
begin

  // Exibe o diálogo com as opções de manifestação
  try

    FrmOpcoesManifestar := TFrmOpcoesManifestar.Create(Self);

    // Se usuário escolher Ok no diálogo então dispara a rotina de manifesto
    if (FrmOpcoesManifestar.ShowModal = mrOk) then
      DMManifestador.Manifestar(DMManifestador.ZQueryNFCODIGO.AsInteger,
                                FrmOpcoesManifestar.RadioGroup1.ItemIndex,
                                DMManifestador.ZQueryNFCHAVE.AsString,
                                True);

  finally

    FrmOpcoesManifestar.Free;

  end;

end;

procedure TfrmPrincipal.ActionEmpresasExecute(Sender: TObject);
begin

  // Exibe o diálogo das configurações do App
  ExibirEmpresas;

end;

procedure TfrmPrincipal.ActionEnviarContabilidadeExecute(Sender: TObject);
begin

  // Exibe o formulário de envio de xml para a contabilidade
  frmEnviarXMLContabilidade := TfrmEnviarXMLContabilidade.Create(Self);

  try

    frmEnviarXMLContabilidade.ShowModal;

  finally

    FreeAndNil(frmEnviarXMLContabilidade);

  end;

end;

procedure TfrmPrincipal.ActionConfigExecute(Sender: TObject);
begin

  // Exibe formulário de configurações
  frmConfig := TfrmConfig.Create(Self);

  try

    if (frmConfig.ShowModal = mrOk) then
      DMManifestador.ConfigurarTimer;

  finally

    FreeAndNil(frmConfig);

  end;

end;

procedure TfrmPrincipal.ActionDownloadExecute(Sender: TObject);
begin

  // Efetua o download da nota fiscal atual
  DMManifestador.Download(DMManifestador.ZQueryNFCODIGO.AsInteger,
                          DMManifestador.ZQueryNFCHAVE.AsString,
                          True);

end;

procedure TfrmPrincipal.ActionManifestarExecute(Sender: TObject);
begin

  // Exibe o dialog de manifestação
  Manifestar;

end;

procedure TfrmPrincipal.ActionObterNotasExecute(Sender: TObject);
begin

  // Verifica no webservice se existem novas notas fiscais disponíveis
  DMManifestador.ObterNotas;

end;


procedure TfrmPrincipal.ActionPDFExecute(Sender: TObject);
begin

  // Gera PDF do Danfe da NFe
  DMManifestador.Visualizar(True);

end;

procedure TfrmPrincipal.ActionVisualizarExecute(Sender: TObject);
begin

  // Exibe visualização da impressão da NFe
  DMManifestador.Visualizar(False);

end;

procedure TfrmPrincipal.DBGrid1DblClick(Sender: TObject);
begin

  // Visualiza o danfe do xml caso esteja disponível
  DMManifestador.Visualizar(False);

end;

procedure TfrmPrincipal.ActionArquivoSairExecute(Sender: TObject);
begin

  // Termina a aplicação
  Application.Terminate;

end;

end.
