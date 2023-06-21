unit ufrmPrincipal;

interface

uses
  udtmPrincipal, uListarDiretorio, SHELLAPI, FileCtrl,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, WebView2,
  Winapi.ActiveX, Vcl.Edge, Vcl.OleCtrls, SHDocVw, System.ImageList, Vcl.ImgList,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TfrmPrincipal = class(TForm)
    btnCriarBanco: TButton;
    lblInstancia: TLabel;
    lblVersion: TLabel;
    Label1: TLabel;
    btnTestarConexao: TButton;
    edtPath: TSearchBox;
    btnChecarBanco: TButton;
    imgLogoVS: TImage;
//    procedure btnCriarBancoClick(Sender: TObject);
    procedure btnTestarConexaoClick(Sender: TObject);
    procedure edtPathInvokeSearch(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnChecarBancoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCriarBancoClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConectarBanco;
    procedure CriarBanco;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnChecarBancoClick(Sender: TObject);
begin
  dtmPrincipal.qrySQL.Close();
  dtmPrincipal.qrySQL.SQL.Clear();
  dtmPrincipal.qrySQL.SQL.Text := 'SELECT COUNT(name) ' + QuotedStr('Qtd') + ' FROM sys.databases WHERE name = ' + QuotedStr('GCOM');
  dtmPrincipal.qrySQL.Open();



  dtmPrincipal.qrySQL.Close();
  dtmPrincipal.qrySQL.SQL.Clear();
  dtmPrincipal.qrySQL.SQL.Text := 'SELECT COUNT(*) Qtd FROM GCOM.sys.objects';
  dtmPrincipal.qrySQL.Open();

  if dtmPrincipal.qrySQL.FieldByName('Qtd').AsInteger > 1000 then
    ShowMessage('Banco de dados criado com sucesso!')
  else
  begin
    if MessageDlg('Banco de dados criado incorretamente. Deseja tentar deletar o banco GCOM atual e criar novamente?',mtConfirmation,mbYesNo,0) = mrYes then
    begin
      btnChecarBanco.Enabled := False;

      dtmPrincipal.qrySQL.Close();
      dtmPrincipal.qrySQL.SQL.Clear();
      dtmPrincipal.qrySQL.SQL.Add('USE [master]');
      //dtmPrincipal.qrySQL.SQL.Add('GO');

      dtmPrincipal.qrySQL.SQL.Add('IF DB_ID(''GCOM'') IS NOT NULL BEGIN');
      dtmPrincipal.qrySQL.SQL.Add('  ALTER DATABASE [GCOM] SET SINGLE_USER WITH ROLLBACK IMMEDIATE');
      dtmPrincipal.qrySQL.SQL.Add('  DROP DATABASE [GCOM]');
      dtmPrincipal.qrySQL.SQL.Add('END');
      //dtmPrincipal.qrySQL.SQL.Add('GO');

      dtmPrincipal.qrySQL.Execute();

      btnCriarBanco.Enabled := True;
      btnCriarBanco.Click();
      btnCriarBanco.Enabled := False;
      btnChecarBanco.Enabled := True;
    end;
  end;
end;

procedure TfrmPrincipal.CriarBanco();
var
  sql: TStringList;
  cmd: PWideChar;
  PathStructure: String;
  PathDump: String;
begin

  if not DirectoryExists(edtPath.Text) then
      ForceDirectories(edtPath.Text);
    try
      if DirectoryExists(edtPath.Text) then
      begin
        sql := TStringList.Create();
        try
          dtmPrincipal.qrySQL.SQL.Clear();
          dtmPrincipal.qrySQL.SQL.Add('RESTORE DATABASE GCOM');
          dtmPrincipal.qrySQL.SQL.Add('FROM DISK=' + QuotedStr('C:\GSOFT\GCOM_NEW.bak'));
          dtmPrincipal.qrySQL.SQL.Add('WITH MOVE ' + QuotedStr('GCOM_Data') + ' TO ' + QuotedStr(edtPath.Text + '\GCOM_Data.mdf') + ',');
          dtmPrincipal.qrySQL.SQL.Add('MOVE ' + QuotedStr('GCOM_Log') + ' TO ' + QuotedStr(edtPath.Text + '\GCOM_Log.ldf') + ',');
          dtmPrincipal.qrySQL.SQL.Add('REPLACE;');
          dtmPrincipal.qrySQL.Execute();

          btnChecarBanco.Click();
        finally
          sql.Free();
        end;
      end
      else
        ShowMessage('O caminho especificado ' + edtPath.Text + ' n�o foi encontrado, tente outro local!');

    except
      raise Exception.Create('N�o foi poss�vel encontrar o caminho especificado!');
    end;
  {cmd :=  PChar('/C sqlcmd -S ' + dtmPrincipal.UniConnection.Server + ' -U sa -P ' + dtmPrincipal.UniConnection.Password + ' -Q "RESTORE DATABASE GCOM FROM DISK= ' + QuotedStr('C:\GSOFT\GCOM_NEW.bak') + ' WITH MOVE ' + QuotedStr('GCOM_Data') + ' TO ' + QuotedStr(edtPath.Text + '\GCOM_Data.mdf') + ', MOVE ' + QuotedStr('GCOM_LOG') + ' TO ' + QuotedStr(edtPath.Text + '\GCOM_log.ldf') + '"');
  try
    ShellExecute(0, nil, 'cmd.exe', cmd, nil, SW_SHOW);
  except
    raise Exception.Create('Falha ao criar banco de dados!');
  end;
  }

  {
  PathStructure := 'C:\GSOFT\Scripts\structure.sql';
  PathDump := 'C:\GSOFT\Scripts\dump.sql';

  sql := TStringList.Create();
  try
    if FileExists(PathStructure) then
    begin
      //Criar estrutura do banco
      sql.LoadFromFile(PathStructure);
      sql.Text := StringReplace(sql.Text, 'D:\DEV_BASE\WINCASH\GCOM', edtPath.Text, [rfReplaceAll]);
      sql.SaveToFile(PathStructure);

      cmd :=  PChar('/C sqlcmd -S ' + dtmPrincipal.UniConnection.Server + ' -U sa -P ' + dtmPrincipal.UniConnection.Password + '  -i "' + PathStructure + '"');

      ShellExecute(0, nil, 'cmd.exe', cmd, nil, SW_SHOW);
    end;
  finally
    sql.Free();
  end;

  sql := TStringList.Create();
  try
    if FileExists(PathDump) then
    begin
      //Dump dos dados
      sql.Clear();
      sql.LoadFromFile(PathDump);
      sql.Text := StringReplace(sql.Text, 'D:\DEV_BASE\WINCASH\GCOM', edtPath.Text, [rfReplaceAll]);

      cmd :=  PChar('/C sqlcmd -S ' + dtmPrincipal.UniConnection.Server + ' -U sa -P ' + dtmPrincipal.UniConnection.Password + '  -i "' + PathDump + '"');

      ShellExecute(0, nil, 'cmd.exe', cmd, nil, SW_SHOW);

    end;
  finally
    sql.Free();
  end;
  }
end;

procedure TfrmPrincipal.btnCriarBancoClick(Sender: TObject);
begin
  CriarBanco();
end;

{
procedure TfrmPrincipal.btnCriarBancoClick(Sender: TObject);
var
  sqlCreate: TStringList;
  cmd: PWideChar;
  ScriptsPath: String;
  sList: TStringList;
begin
  ScriptsPath := 'C:\GSOFT\Scripts\GCOM.sql';

  dtmPrincipal.qrySQL.Close();
  dtmPrincipal.qrySQL.SQL.Clear();
  dtmPrincipal.qrySQL.SQL.Text := 'SELECT * FROM sys.databases d WHERE d.name LIKE ''GCOM''';
  dtmPrincipal.qrySQL.Open();

  if dtmPrincipal.qrySQL.RecordCount > 0 then
  begin
    ShowMessage('Banco de dados j� existe!');
//    btnChecarBanco.Enabled := True;
  end
  else
  begin
    if not FileExists(ScriptsPath) then
      ShowMessage('N�o foi poss�vel localizar os arquivos para a cria��o do banco de dados!')
    else
    begin
      if not DirectoryExists(edtPath.Text) then
      begin
        try
          ForceDirectories(edtPath.Text);
        except
          raise Exception.Create('N�o foi poss�vel localizar o caminho de destino para a cria��o do banco de dados!');
        end;

      end;
//      btnCriarBanco.Enabled := False;
//      btnChecarBanco.Enabled := True;

      sqlCreate := TStringList.Create();
      try
        try
          sqlCreate.Add('CREATE DATABASE [GCOM]');
          sqlCreate.Add('ON PRIMARY(');
          sqlCreate.Add('    NAME = N' + QuotedStr('GCOM_Data') + ',');
          sqlCreate.Add('    FILENAME = N' + QuotedStr(edtPath.Text + '\GCOM_Data.MDF') + ',');
          sqlCreate.Add('    SIZE = 51904KB,');
          sqlCreate.Add('    MAXSIZE = UNLIMITED,');
          sqlCreate.Add('    FILEGROWTH = 10%');
          sqlCreate.Add(')');
          sqlCreate.Add('LOG ON(');
          sqlCreate.Add('    NAME = N' + QuotedStr('GCOM_Log') + ',');
          sqlCreate.Add('    FILENAME = N' + QuotedStr(edtPath.Text + '\GCOM_Log.LDF') + ',');
          sqlCreate.Add('    SIZE = 1024KB,');
          sqlCreate.Add('    MAXSIZE = UNLIMITED,');
          sqlCreate.Add('    FILEGROWTH = 10%');
          sqlCreate.Add(')');

          dtmPrincipal.qryCreateDataBase.SQL.Clear();
          dtmPrincipal.qryCreateDataBase.SQL.Add(sqlCreate.Text);
          dtmPrincipal.qryCreateDataBase.ExecSQL();

          dtmPrincipal.qryCreateDataBase.SQL.Clear();
          dtmPrincipal.qryCreateDataBase.SQL.Add('ALTER DATABASE [GCOM]              ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('SET                                ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('ANSI_NULL_DEFAULT OFF,             ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('ANSI_NULLS OFF,                    ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('ANSI_PADDING OFF,                  ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('ANSI_WARNINGS OFF,                 ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('ARITHABORT OFF,                    ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('AUTO_CLOSE OFF,                    ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('AUTO_CREATE_STATISTICS ON,         ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('AUTO_SHRINK ON,                    ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('AUTO_UPDATE_STATISTICS ON,         ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('AUTO_UPDATE_STATISTICS_ASYNC OFF,  ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('COMPATIBILITY_LEVEL = 100,         ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('CONCAT_NULL_YIELDS_NULL OFF,       ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('CURSOR_CLOSE_ON_COMMIT OFF,        ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('CURSOR_DEFAULT GLOBAL,             ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('DATE_CORRELATION_OPTIMIZATION OFF, ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('DB_CHAINING OFF,                   ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('HONOR_BROKER_PRIORITY OFF,         ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('MULTI_USER,                        ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('NUMERIC_ROUNDABORT OFF,            ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('PAGE_VERIFY NONE,                  ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('PARAMETERIZATION SIMPLE,           ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('QUOTED_IDENTIFIER OFF,             ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('READ_COMMITTED_SNAPSHOT OFF,       ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('RECOVERY SIMPLE,                   ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('RECURSIVE_TRIGGERS OFF,            ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('TRUSTWORTHY OFF                    ');
          dtmPrincipal.qryCreateDataBase.SQL.Add('WITH ROLLBACK IMMEDIATE            ');

          dtmPrincipal.qryCreateDataBase.ExecSQL();

          dtmPrincipal.qryCreateDataBase.SQL.Clear();

          if DirectoryExists(edtPath.Text) then
          begin
            cmd :=  PChar('/C sqlcmd -S ' + dtmPrincipal.UniConnection.Server + ' -U sa -P ' + dtmPrincipal.UniConnection.Password + '  -i "' + ScriptsPath + '"');

            ShellExecute(0, nil, 'cmd.exe', cmd, nil, SW_SHOW);

//            btnChecarBanco.Enabled := True;
          end
          else
            ShowMessage('N�o foi poss�vel acessar o diret�rio!');
        except
          raise Exception.Create('N�o foi poss�vel criar o banco de dados!');
        end;
      finally
        sqlCreate.Free();
      end;
    end;
  end;
end;
}

procedure TfrmPrincipal.edtPathInvokeSearch(Sender: TObject);
var
  DirSelected: string;
begin
  if SelectDirectory('selecione uma pasta', '',DirSelected) then
    edtPath.Text := DirSelected + '\';
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if MessageDlg('Deseja excluir os scripts de configura��o?',mtConfirmation,mbYesNo,0) = mrYes then
//    WinExec(PAnsiChar('cmd /c rmdir /s /q C:\GSOFT\Scripts exit'),SW_HIDE);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  fileDownload: TFileStream;
  sList: TStringList;
const path = 'C:\GSOFT\Scripts\';
begin
  if (Key = VK_F10) and (btnChecarBanco.Enabled = True) then
    if MessageDlg('Deseja iniciar a configura��o do banco de dados no padr�o Vale Safe?',mtConfirmation,mbYesNo,0) = mrYes then
    begin
      sList := TStringList.Create();
      try
        dtmPrincipal.UniConnection.Disconnect;
        dtmPrincipal.UniConnection.Database := 'GCOM';
        dtmPrincipal.UniConnection.Connect;

        sList.Clear();
        sList.LoadFromFile(path + 'DeleteAndDrop.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'MC_Config.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'MC_FormaPag.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'MC_FormasPadrao.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'MC_Grupo.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'MC_Setor.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'MC_TabelaPrecos.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'PC_Contas.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'sp_ExtratoConsolidadoResumoTitulos.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        sList.Clear();
        sList.LoadFromFile(path + 'sp_ExtratoConsolidadoSaldoDia.sql');
        dtmPrincipal.qryScript.SQL.Clear;
        dtmPrincipal.qryScript.SQL.Text := sList.Text;
        dtmPrincipal.qryScript.Execute;

        imgLogoVS.Picture.SaveToFile('C:\GSOFT\Wincash\Figuras\logo.jpg');

        ShowMessage('Configura��o realizada com sucesso!');
      finally
        sList.Free();
      end;
    end;
end;

procedure TfrmPrincipal.btnTestarConexaoClick(Sender: TObject);
begin
  ConectarBanco();
  btnCriarBanco.Enabled := True;
  btnChecarBanco.Enabled := True;
end;

procedure TfrmPrincipal.ConectarBanco;
var
  ConnectString: TStringList;
begin
  ConnectString := TStringList.Create;
  try
    ConnectString.LoadFromFile('C:\GSOFT\Wincash\Wincash.dll');
    lblInstancia.Caption := ConnectString.Text;
    dtmPrincipal.UniConnection.Disconnect;
    dtmPrincipal.UniConnection.ConnectString := ConnectString.Text;
    dtmPrincipal.UniConnection.Database := '';
    dtmPrincipal.UniConnection.Connect;
    dtmPrincipal.qryVersion.Close;
    dtmPrincipal.qryVersion.Open;
    lblVersion.Caption := dtmPrincipal.qryVersion.Fields[0].AsString;
    lblVersion.Visible := True;
    btnCriarBanco.Enabled := False;
    ShowMessage('Conex�o com a inst�ncia estabelecida com sucesso!');
  finally
    ConnectString.Free;
  end;
end;


end.
