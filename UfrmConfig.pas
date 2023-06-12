unit UfrmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, Data.DB;

type
  TfrmConfig = class(TForm)
    GroupBox1: TGroupBox;
    cbxVERIFICAR_AUTOMATICO: TDBCheckBox;
    edTIMER: TDBEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbxDOWNLOAD_AUTOMATICO: TDBCheckBox;
    dsCFG: TDataSource;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    edSMTP: TDBEdit;
    edSMTP_PORTA: TDBEdit;
    Label3: TLabel;
    edSMTP_CONTA: TDBEdit;
    Label4: TLabel;
    edSMTP_SENHA: TDBEdit;
    Label5: TLabel;
    edSMTP_REMETENTE: TDBEdit;
    Label6: TLabel;
    edSMTP_EMAIL: TDBEdit;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.dfm}

uses UDMManifestador;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin

  if (DMManifestador.ZQueryCFG.RecordCount = 0) then
    DMManifestador.ZQueryCFG.Insert
  else
    DMManifestador.ZQueryCFG.Edit;

end;

procedure TfrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if (DMManifestador.ZQueryCFG.State in [dsInsert, dsEdit]) then
  begin

    if (Self.ModalResult = MrOk) then
      DMManifestador.ZQueryCFG.Post
    else
      DMManifestador.ZQueryCFG.Cancel;

  end;

end;

end.
