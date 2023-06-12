unit UfrmEnviarXMLContabilidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset, DateUtils,
  Vcl.Buttons;

type
  TfrmEnviarXMLContabilidade = class(TForm)
    gbxPeriodo: TGroupBox;
    edIni: TDateTimePicker;
    edFim: TDateTimePicker;
    GroupBox1: TGroupBox;
    edEmail: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    gbxNotasFiscais: TGroupBox;
    DBGrid1: TDBGrid;
    ZQueryNF: TZQuery;
    ZQueryNFCODIGO: TLargeintField;
    ZQueryNFNUMERO: TLargeintField;
    ZQueryNFNSU: TLargeintField;
    ZQueryNFSERIE: TLargeintField;
    ZQueryNFCNPJ: TWideStringField;
    ZQueryNFNOME: TWideStringField;
    ZQueryNFEMISSAO: TDateField;
    ZQueryNFVALOR: TFloatField;
    ZQueryNFTIPO: TWideStringField;
    ZQueryNFSITUACAO: TWideStringField;
    ZQueryNFCHAVE: TWideStringField;
    ZQueryNFIE: TWideStringField;
    ZQueryNFPROTOCOLO: TWideStringField;
    ZQueryNFDATAREC: TDateField;
    ZQueryNFMANIFESTACAO: TWideStringField;
    ZQueryNFDOWNLOAD: TWideStringField;
    ZQueryNFAMBIENTE: TWideStringField;
    ZQueryNFID_EMPRESA: TLargeintField;
    dsNF: TDataSource;
    btnEnviar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edIniChange(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private

    { Private declarations }
    procedure ListarNotas;

  public

    { Public declarations }
    procedure Enviar;

  end;

var
  frmEnviarXMLContabilidade: TfrmEnviarXMLContabilidade;

implementation

{$R *.dfm}

uses UDMManifestador;

procedure TfrmEnviarXMLContabilidade.FormCreate(Sender: TObject);
begin

  edIni.Date := Date;
  edFim.Date := Date;

  if MonthOf(Date) = 1 then
  begin

    edIni.Date := StrToDate('01/12/'+ IntToStr(YearOf(Date) - 1));
    edFim.Date := StrToDate('31/12/'+ IntToStr(YearOf(Date) - 1));

  end
  else
  begin

    edIni.Date := StrToDate('01/'+ IntToStr(MonthOf(Date)-1) + '/' + IntToStr(YearOf(Date) ));
    edFim.Date := StrToDate('01/'+ IntToStr(MonthOf(Date)) + '/' + IntToStr(YearOf(Date) ))-1;

  end;

  ListarNotas;

end;

procedure TfrmEnviarXMLContabilidade.btnEnviarClick(Sender: TObject);
begin

  if (ZQueryNF.RecordCount = 0) then
    raise Exception.Create('Não existem notas fiscais no período selecionado!');


  if (edEmail.Text = '') then
  begin

    edEmail.SetFocus;
    raise Exception.Create('Digite o endereço de email do destinatário!');

  end;

  if (DMManifestador.ZQueryCFGSMTP.Text = '') or (DMManifestador.ZQueryCFGSMTP_CONTA.AsString = '') or
     (DMManifestador.ZQueryCFGSMTP_REMETENTE.Text = '') or (DMManifestador.ZQueryCFGSMTP_EMAIL.AsString = '') or
     (DMManifestador.ZQueryCFGSMTP_SENHA.Text = '') or (DMManifestador.ZQueryCFGSMTP_PORTA.AsInteger = 0) then
    raise Exception.Create('Não foram encontradas as configurações do servidor de email!');

  Enviar;

end;

procedure TfrmEnviarXMLContabilidade.edIniChange(Sender: TObject);
begin

  if (ZQueryNF.Active) then
    ListarNotas;

end;

procedure TfrmEnviarXMLContabilidade.ListarNotas;
begin

  ZQueryNF.Close;
  zQueryNF.ParamByName('ID_EMPRESA').AsInteger := DMManifestador.ZQueryEMPRESACODIGO.AsInteger;
  zQueryNF.ParamByName('INICIO').AsDate := edIni.Date;
  zQueryNF.ParamByName('FIM').AsDate := edFim.Date;
  ZQueryNF.Open;

end;

procedure TfrmEnviarXMLContabilidade.Enviar;
var
  Arquivos: TStringList;
  Arquivo: string;
  ArquivoZip: string;
begin

  Screen.Cursor := crHourGlass;
  Arquivos := TStringList.Create;

  try

    try

      with ZQueryNF do
      begin

        DisableControls;
        First;

        while not Eof do
        begin

          Arquivo := ExtractFilePath(Application.ExeName) +
                     'NotasFornecedores\' +
                     DMManifestador.ZQueryEMPRESACNPJ.AsString + '\' +
                     ZQueryNFCHAVE.AsString + '-nfe.xml';

          if FileExists(Arquivo) then
            Arquivos.Add(Arquivo);

          Next;

        end;

        First;
        EnableControls;

        if (Arquivos.Count > 0) then
        begin

          ArquivoZip := ExtractFilePath(Application.ExeName) +
                       'NotasFornecedores\' +
                        DMManifestador.ZQueryEMPRESACNPJ.AsString + '\NotasFiscais.zip';
          DMManifestador.GerarZip(ArquivoZip,
                                  Arquivos);
          DMManifestador.ConfigurarAcbrMail;
          DMManifestador.ACBrMail1.AddAddress(edEmail.Text);
          DMManifestador.ACBrMail1.AddAttachment(ArquivoZip);
          DMManifestador.ACBrMail1.Send;
          Application.MessageBox('Email enviado com sucesso!', 'Manifestador', MB_OK + MB_ICONINFORMATION);

        end;

      end;

    except

      on E:Exception do
      begin

        raise Exception.Create('TfrmEnviarXMLContabilidade.Enviar -> '+ E.Message);

      end;

    end;

  finally

    Screen.Cursor := crDefault;
    Arquivos.Free;

  end;

end;

end.
