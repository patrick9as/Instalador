#define MyAppName "Gsoft Wincash"
#define MyAppVersion "1.0"
#define MyAppPublisher "Gsoft do Brasil Sistemas"
#define MyAppURL "https://www.gsoft.com.br/"
#define MyAppExeName "Wincash.exe"
#define MyAppIcoName "Wincash_Icon.ico"
#define MyAppVersion "10.3.2038.11"
#define MyAppVerName "Gsoft Wincash Servidor 10.3.2038.11"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B612417A-4934-49EE-8DBA-E8890E1458F4}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppVerName}
VersionInfoVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\GSOFT\Wincash
DisableDirPage=yes
DisableProgramGroupPage=yes
LicenseFile=Gsoft do Brasil Sistemas.rtf
SetupIconFile=Instalador.ico
OutputDir=..\Release
OutputBaseFilename="Wincash-Servidor"
Compression=lzma2
SolidCompression=yes
WizardStyle=modern  

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "..\Modelo_Wincash_Servidor\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Files\Atualizador\*"; DestDir: "C:\GSOFT\Atualizador"; Flags: ignoreversion
Source: "..\Files\SQLEXPRADV_x64_PTB\*"; DestDir: "C:\GSOFT\SQLServer2019\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Files\CheckDb.exe"; DestDir: "C:\GSOFT\"; Flags: ignoreversion
Source: ".\ValeSafe\*"; DestDir: "C:\GSOFT\Scripts\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Files\GCOM_NEW.bak"; DestDir: "C:\GSOFT\"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange("Wincash", '&', '&&')}}"; Flags: nowait postinstall skipifsilent
Filename: "C:\GSOFT\SQLServer2019\SETUP.exe"; Parameters: "/q /ACTION=Install /INSTANCENAME=GSOFT /FEATURES=SQL /SECURITYMODE=SQL /SAPWD=@Gsbrasil12010590 /SQLSYSADMINACCOUNTS=BUILTIN\Administrators /IACCEPTSQLSERVERLICENSETERMS"; StatusMsg: "Instalando o SQL Server 2019..."; Flags: waituntilterminated
Filename: "cmd.exe"; Parameters: "/C sc config SQLBrowser start= auto"; WorkingDir: {win}; Flags: runhidden   
Filename: "cmd.exe"; Parameters: "/C net start SQLBrowser"; WorkingDir: {win}; Flags: runhidden waituntilterminated
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""SQL Server TCP"" dir=in action=allow protocol=TCP localport=1433,1434"; Flags: runhidden
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=""SQL Server UDP"" dir=in action=allow protocol=UDP localport=1433,1434"; Flags: runhidden
Filename: "C:\GSOFT\CheckDb.exe"; Flags: waituntilterminated runasoriginaluser