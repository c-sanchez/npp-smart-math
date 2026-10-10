#include "windows.bi"
#include "crt.bi"
#include "Inc\PluginInterface.bi"
#include "Inc\ConfigManager.bi"

const INI_FILENAME = wstr("\SmartMath.ini")
const INI_SECTION_SETTINGS = wstr("Settings")
const INI_SECTION_OUTPUT = wstr("Output")
const DECIMAL_SEP_DEFAULT = "."
const THOUSANDS_SEP_DEFAULT = "'"
const ARRAY_OUTPUT_SEP_DEFAULT = ","
const DECIMAL_PLACES_DEFAULT = 2
const COMPLEX_NUMBERS_DEFAULT = 0
const SHOW_ERRORS_DEFAULT = 0
const SYNTAX_HIGHLIGHT_DEFAULT = 1
const USE_THOUSANDS_SEP_DEFAULT = 0
const NPPM_GETPLUGINSCONFIGDIR = (WM_USER + 1000 + 46)

dim shared as wstring * MAX_PATH iniFilePath
dim shared as integer storedDecimalPlaces = DECIMAL_PLACES_DEFAULT
dim shared as boolean storedUseThousandsSep = USE_THOUSANDS_SEP_DEFAULT <> 0
dim shared as boolean storedSupportComplexNumbers = COMPLEX_NUMBERS_DEFAULT <> 0
dim shared as boolean storedShowErrors = SHOW_ERRORS_DEFAULT <> 0
dim shared as boolean storedSyntaxHighlight = SYNTAX_HIGHLIGHT_DEFAULT <> 0
dim shared as string storedDecimalSep
dim shared as string storedThousandsSep
dim shared as string storedArrayOutputSep
dim shared as string enabledFiles()
dim shared as HWND hNppWnd

private sub PrepareIniPath()
  dim as wstring * MAX_PATH configDir
  SendMessage(hNppWnd, NPPM_GETPLUGINSCONFIGDIR, MAX_PATH, cast(LPARAM, @configDir))
  CreateDirectory(configDir, NULL)
  iniFilePath = configDir & INI_FILENAME
end sub

sub Config_Init(hNpp as HWND)
  hNppWnd = hNpp
  PrepareIniPath()
end sub

sub Config_SetDecimalPlaces(p as integer)
  if p < 0 then p = 0
  if p > 8 then p = 8
  storedDecimalPlaces = p
end sub

function Config_GetDecimalPlaces() as integer
  return storedDecimalPlaces
end function

sub Config_SetUseThousandsSep(byval enabled as boolean)
  storedUseThousandsSep = enabled
end sub

function Config_GetUseThousandsSep() as boolean
  return storedUseThousandsSep
end function

sub Config_SetSupportComplexNumbers(byval enabled as boolean)
  storedSupportComplexNumbers = enabled
end sub

function Config_GetSupportComplexNumbers() as boolean
  return storedSupportComplexNumbers
end function

sub Config_SetShowErrors(byval enabled as boolean)
  storedShowErrors = enabled
end sub

function Config_GetShowErrors() as boolean
  return storedShowErrors
end function

sub Config_SetSyntaxHighlight(byval enabled as boolean)
  storedSyntaxHighlight = enabled
end sub

function Config_GetSyntaxHighlight() as boolean
  return storedSyntaxHighlight
end function

function Config_GetDecimalSep() as string
  return storedDecimalSep
end function

function Config_GetThousandsSep() as string
  return storedThousandsSep
end function

function Config_GetArrayOutputSep() as string
  return storedArrayOutputSep
end function

function Config_IsFileEnabled(path as string) as boolean
  dim as integer i
  for i = lbound(enabledFiles) to ubound(enabledFiles)
    if enabledFiles(i) = path then return TRUE
  next i
  return FALSE
end function

function Config_ToggleFile(path as string) as boolean
  dim as integer i, idx = -1

  for i = lbound(enabledFiles) to ubound(enabledFiles)
    if enabledFiles(i) = path then
      idx = i
      exit for
    end if
  next i

  if idx = -1 then
    if ubound(enabledFiles) = -1 then
      redim enabledFiles(0)
    else
      redim preserve enabledFiles(ubound(enabledFiles) + 1)
    end if
    enabledFiles(ubound(enabledFiles)) = path
  else
    if idx < ubound(enabledFiles) then
      enabledFiles(idx) = enabledFiles(ubound(enabledFiles))
    end if
    if ubound(enabledFiles) > 0 then
      redim preserve enabledFiles(ubound(enabledFiles) - 1)
    else
      erase enabledFiles
    end if
  end if

  return idx = -1 ' TRUE - added, FALSE - removed
end function

sub Config_DisableFile(path as string)
  dim as integer i, idx = -1

  for i = lbound(enabledFiles) to ubound(enabledFiles)
    if enabledFiles(i) = path then
      idx = i
      exit for
    end if
  next i

  if idx <> -1 then
    if idx < ubound(enabledFiles) then
      enabledFiles(idx) = enabledFiles(ubound(enabledFiles))
    end if

    if ubound(enabledFiles) > 0 then
      redim preserve enabledFiles(ubound(enabledFiles) - 1)
    else
      erase enabledFiles
    end if
    Config_Save()
  end if
end sub

sub Config_Save()
  dim as string allPaths = ""
  dim as integer i

  WritePrivateProfileString(INI_SECTION_SETTINGS, wstr("DecimalPlaces"), wstr(str(storedDecimalPlaces)), iniFilePath)
  WritePrivateProfileString(INI_SECTION_SETTINGS, wstr("UseThousandsSeparator"), wstr(iif(storedUseThousandsSep, "1", "0")), iniFilePath)
  WritePrivateProfileString(INI_SECTION_SETTINGS, wstr("ComplexNumbers"), wstr(iif(storedSupportComplexNumbers, "1", "0")), iniFilePath)
  WritePrivateProfileString(INI_SECTION_SETTINGS, wstr("ShowErrors"), wstr(iif(storedShowErrors, "1", "0")), iniFilePath)
  WritePrivateProfileString(INI_SECTION_SETTINGS, wstr("SyntaxHighlight"), wstr(iif(storedSyntaxHighlight, "1", "0")), iniFilePath)

  for i = lbound(enabledFiles) to ubound(enabledFiles)
    if len(enabledFiles(i)) > 0 then
      if len(allPaths) > 0 then allPaths &= "|"
      allPaths &= enabledFiles(i)
    end if
  next i

  WritePrivateProfileString(INI_SECTION_SETTINGS, wstr("ActiveTabs"), wstr(allPaths), iniFilePath)
end sub

#define BUFFER_SIZE 32768

sub Config_Load()
  dim as zstring * BUFFER_SIZE buffer

  storedDecimalSep = DECIMAL_SEP_DEFAULT
  storedThousandsSep = THOUSANDS_SEP_DEFAULT
  storedArrayOutputSep = ARRAY_OUTPUT_SEP_DEFAULT

  ' Read-only settings...
  buffer[0] = 0
  GetPrivateProfileString(INI_SECTION_OUTPUT, wstr("DecimalSeparatorChar"), wstr(DECIMAL_SEP_DEFAULT), @buffer, BUFFER_SIZE, iniFilePath)
  if buffer[0] <> 0 then storedDecimalSep = Left(buffer, 1)

  buffer[0] = 0
  GetPrivateProfileString(INI_SECTION_OUTPUT, wstr("ThousandsSeparatorChar"), wstr(THOUSANDS_SEP_DEFAULT), @buffer, BUFFER_SIZE, iniFilePath)
  if buffer[0] <> 0 then storedThousandsSep = Left(buffer, 1)

  buffer[0] = 0
  GetPrivateProfileString(INI_SECTION_OUTPUT, wstr("ArrayOutputSeparatorChar"), wstr(ARRAY_OUTPUT_SEP_DEFAULT), @buffer, BUFFER_SIZE, iniFilePath)
  if buffer[0] <> 0 then storedArrayOutputSep = Left(buffer, 1)

  ' Read-write settings...
  storedDecimalPlaces = GetPrivateProfileInt(INI_SECTION_SETTINGS, wstr("DecimalPlaces"), DECIMAL_PLACES_DEFAULT, iniFilePath)
  if storedDecimalPlaces < 0 then storedDecimalPlaces = 0
  if storedDecimalPlaces > 8 then storedDecimalPlaces = 8
  storedUseThousandsSep = (GetPrivateProfileInt(INI_SECTION_SETTINGS, wstr("UseThousandsSeparator"), USE_THOUSANDS_SEP_DEFAULT, iniFilePath) <> 0)
  storedSupportComplexNumbers = (GetPrivateProfileInt(INI_SECTION_SETTINGS, wstr("ComplexNumbers"), COMPLEX_NUMBERS_DEFAULT, iniFilePath) <> 0)
  storedShowErrors = (GetPrivateProfileInt(INI_SECTION_SETTINGS, wstr("ShowErrors"), SHOW_ERRORS_DEFAULT, iniFilePath) <> 0)
  storedSyntaxHighlight = (GetPrivateProfileInt(INI_SECTION_SETTINGS, wstr("SyntaxHighlight"), SYNTAX_HIGHLIGHT_DEFAULT, iniFilePath) <> 0)

  buffer[0] = 0
  GetPrivateProfileString(INI_SECTION_SETTINGS, wstr("ActiveTabs"), wstr(""), @buffer, BUFFER_SIZE, iniFilePath)

  erase enabledFiles

  dim as string sBuffer = buffer
  dim as integer pPipe, pStart = 1
  dim as string sPath

  if len(sBuffer) > 0 then
    do
      pPipe = instr(pStart, sBuffer, "|")
      if pPipe > 0 then
        sPath = mid(sBuffer, pStart, pPipe - pStart)
        pStart = pPipe + 1
      else
        sPath = mid(sBuffer, pStart)
      end if

      if len(sPath) > 0 then
        if ubound(enabledFiles) = -1 then
          redim enabledFiles(0)
        else
          redim preserve enabledFiles(ubound(enabledFiles) + 1)
        end if
        enabledFiles(ubound(enabledFiles)) = sPath
      end if
    loop while pPipe > 0
  end if
end sub