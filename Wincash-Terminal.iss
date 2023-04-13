#define MyAppName "Gsoft Wincash"
#define MyAppVersion "1.0"
#define MyAppPublisher "Gsoft do Brasil Sistemas"
#define MyAppURL "https://www.gsoft.com.br/"
#define MyAppExeName "Wincash.exe"
#define MyAppIcoName "Wincash_Icon.ico"
#define MyAppVersion "10.3.2038.11"
#define MyAppVerName "Gsoft Wincash 10.3.2038.11"

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
OutputBaseFilename="Wincash-Terminal"
Compression=lzma2
SolidCompression=yes
WizardStyle=modern  

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "..\Wincash_Terminal\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Wincash_Terminal\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\files\Atualizador\*"; DestDir: "C:\GSOFT\Atualizador"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent 