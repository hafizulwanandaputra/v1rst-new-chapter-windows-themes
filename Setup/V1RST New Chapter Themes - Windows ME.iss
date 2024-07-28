; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "V1RST New Chapter Themes"
#define MyAppVersion "1.0.2"
#define MyAppPublisher "HWPweb"
#define MyAppURL "http://legacy.aku-hafizulwananda.com/articles/hwparticle-v1rst-new-chapter-theme-for-windows-1711205952"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B56AFC36-31C4-43CE-9AB6-C2D9A84F2E0C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} v{#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL=http://legacy.aku-hafizulwananda.com
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\Plus!\Themes
DefaultGroupName={#MyAppName} v{#MyAppVersion}
DisableProgramGroupPage=yes
OutputBaseFilename=v1rstnewchapterthemes-{#MyAppVersion}-winme
Compression=lzma2/ultra64
LZMAUseSeparateProcess=yes
LZMADictionarySize=262144
LZMANumFastBytes=273
MinVersion=4.90,0
SolidCompression=yes
UninstallFilesDir={pf}\{#MyAppName} Uninstall
DirExistsWarning=no
DisableWelcomePage=no
ShowLanguageDialog=auto
DisableDirPage=yes
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany={#MyAppPublisher}
VersionInfoCopyright={#MyAppName} is not affiliated, associated, or in any way officially connected with Kapital Entertainment. � All rights reserved Kapital Entertainment 2024
VersionInfoDescription={#MyAppName} for Windows Millennium Edition
AppCopyright={#MyAppName} is not affiliated, associated, or in any way officially connected with Kapital Entertainment. � All rights reserved Kapital Entertainment 2024
SetupIconFile="Wizard Images\msiexec_1.ico" 
WizardImageFile="Wizard Images\WizardImage.bmp"
WizardSmallImageFile="Wizard Images\WizardSmallImage.bmp"
LicenseFile="..\LICENSE.txt"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppName} - Version {#MyAppVersion}

[LangOptions]
DialogFontName=MS Sans Serif
DialogFontSize=8
WelcomeFontName=MS Serif
WelcomeFontSize=18

[Types]
Name: "full"; Description: {cm:T_Full}
Name: "base"; Description: {cm:T_Base}
Name: "custom"; Description: {cm:T_Custom}; Flags: iscustom

[Components]
Name: "base"; Description: "Base Theme"; Types: full base custom; Flags: fixed
Name: "wallpaper"; Description: "Additional Wallpapers Sizes"; Types: full custom; Flags:

[Files]
Source: "..\Theme Files\Windows ME\*"; DestDir: "{app}"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Wallpaper\*"; DestDir: "{win}"; Components: base; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\Additional Wallpaper\*"; DestDir: "{win}"; Components: wallpaper; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[CustomMessages]
T_Full=Full
TD_Full=Installs all of the components
T_Base=Base Theme Only
TD_Base=Installs base theme without additional variants
T_Custom=Custom
TD_Custom=Installs only selected components

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\{#MyAppName} Readme"; Filename: "{app}\V1RST New Chapter Themes Readme.txt"
Name: "{group}\{#MyAppName} Windows Explorer Web View Images"; Filename:"{win}\EXPLORER.EXE"; Parameters:"{app}\V1RST New Chapter Web View Images"
Name: "{group}\{#MyAppName} Gradient Color Fix\Values for Display Properties"; Filename: "{app}\V1RST New Chapter Gradient Color Values.txt"
Name: "{group}\{#MyAppName} Gradient Color Fix\Standard"; Filename: "{app}\V1RST New Chapter.reg"

[Run]
Filename: "{pf}\Plus!\Themes.exe"; Description: "Open Desktop Themes"; Flags: nowait postinstall shellexec skipifsilent

[Code]
#include "DescriptiveTypes.isi"
procedure InitializeWizard();
begin
  InitializeDescriptiveTypes();
end;

function Desktopthemes(): boolean;
begin
  result := RegKeyExists(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Themes.exe');
end;

function GetNumber(var temp: String): Integer;
var
  part: String;
  pos1: Integer;
begin
  if Length(temp) = 0 then
  begin
    Result := -1;
    Exit;
  end;
    pos1 := Pos('.', temp);
    if (pos1 = 0) then
    begin
      Result := StrToInt(temp);
    temp := '';
    end
    else
    begin
    part := Copy(temp, 1, pos1 - 1);
      temp := Copy(temp, pos1 + 1, Length(temp));
      Result := StrToInt(part);
    end;
end;
 
function CompareInner(var temp1, temp2: String): Integer;
var
  num1, num2: Integer;
begin
  num1 := GetNumber(temp1);
  num2 := GetNumber(temp2);
  if (num1 = -1) or (num2 = -1) then
  begin
    Result := 0;
    Exit;
  end;
      if (num1 > num2) then
      begin
        Result := 1;
      end
      else if (num1 < num2) then
      begin
        Result := -1;
      end
      else
      begin
        Result := CompareInner(temp1, temp2);
      end;
end;
 
function CompareVersion(str1, str2: String): Integer;
var
  temp1, temp2: String;
begin
    temp1 := str1;
    temp2 := str2;
    Result := CompareInner(temp1, temp2);
end;

function InitializeSetup(): Boolean;
var
  oldVersion: String;
  uninstaller: String;
  ErrorCode: Integer;
begin
  if RegKeyExists(HKEY_LOCAL_MACHINE,
      'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B56AFC36-31C4-43CE-9AB6-C2D9A84F2E0C}_is1') then
    begin
      RegQueryStringValue(HKEY_LOCAL_MACHINE,
        'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B56AFC36-31C4-43CE-9AB6-C2D9A84F2E0C}_is1',
        'DisplayVersion', oldVersion);
      if (CompareVersion(oldVersion, ExpandConstant('{#MyAppVersion}')) < 0) then
      begin
        if MsgBox('Version ' + oldVersion + ' of V1RST New Chapter Themes is already installed. Clicking "Yes" will uninstall the old version. Continue setup?',
          mbConfirmation, MB_YESNO) = IDNO then
        begin
          Abort;
        end
        else
        begin
            RegQueryStringValue(HKEY_LOCAL_MACHINE,
              'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B56AFC36-31C4-43CE-9AB6-C2D9A84F2E0C}_is1', 'UninstallString', uninstaller);
            ShellExec('', uninstaller, '/SILENT', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
            Result := True;
        end;
      end
      else
      begin
        if MsgBox('Version ' + oldVersion + ' of V1RST New Chapter Themes is already installed. Do you want to reinstall or downgrade to this version?',
          mbConfirmation, MB_YESNO) = IDNO then
        begin
          Abort;
        end
        else
        begin
            RegQueryStringValue(HKEY_LOCAL_MACHINE,
              'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B56AFC36-31C4-43CE-9AB6-C2D9A84F2E0C}_is1', 'UninstallString', uninstaller);
            ShellExec('', uninstaller, '/SILENT', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
            Result := True;
        end;
      end;
    end
    else
    begin
      Result := True;
    end;
    result := Desktopthemes();
    if not result then
      MsgBox('Desktop Themes is not installed, you must install Desktop Themes from Add/Remove Programs -> Windows Setup', mbCriticalError, MB_OK);
  end;
end.