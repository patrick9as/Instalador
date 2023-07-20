#define MyAppName "Gsoft Wincash"
#define MyAppVersion "1.0"
#define MyAppPublisher "Gsoft do Brasil Sistemas"
#define MyAppURL "https://www.gsoft.com.br/"
#define MyAppExeName "Wincash.exe"
#define MyAppIcoName "Wincash_Icon.ico"
#define MyAppVersion "10.3.2040.4"
#define MyAppVerName "Gsoft Wincash Terminal 10.3.2040.4"

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
DefaultDirName=C:\GSOFT\
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
Source: ".\Dependencias\Modelo_Wincash_Terminal\*"; DestDir: "{app}\Wincash"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: ".\Dependencias\Atualizador\*"; DestDir: "{app}\Atualizador"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\Wincash\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange("Wincash", '&', '&&')}}"; Flags: nowait postinstall skipifsilent 