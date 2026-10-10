@echo off

set ARC_EXE=7z.exe
for /f "tokens=1-3 delims=/.- " %%a in ('DATE /T') do set ARC_DATE=%%c%%b%%a
set ARC_DLL_NAME=SmartMath_%ARC_DATE%_dll
set ARC_DLL_NAME_64=SmartMath_%ARC_DATE%_dll_x64

if not exist "Build-Win32\SmartMath.dll" (
  echo Running Compile32.bat...
  call "Compile32.bat"
)

if not exist "Build-Win64\SmartMath.dll" (
  echo Running Compile64.bat...
  call "Compile64.bat"
)

cd "Notepad++"

REM 32-bit dll...
copy /Y "..\Build-Win32\SmartMath.dll" ".\"
if exist "..\%ARC_DLL_NAME%.zip" del /Q "..\%ARC_DLL_NAME%.zip"
"%ARC_EXE%" a -tzip "..\%ARC_DLL_NAME%.zip" . -mx5
"%ARC_EXE%" t "..\%ARC_DLL_NAME%.zip"
del /Q ".\SmartMath.dll"

REM 64-bit dll...
copy /Y "..\Build-Win64\SmartMath.dll" ".\"
if exist "..\%ARC_DLL_NAME_64%.zip" del /Q "..\%ARC_DLL_NAME_64%.zip"
"%ARC_EXE%" a -tzip "..\%ARC_DLL_NAME_64%.zip" . -mx5
"%ARC_EXE%" t "..\%ARC_DLL_NAME_64%.zip"
del /Q ".\SmartMath.dll"
