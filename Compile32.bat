@echo off

rem Specify the correct path to FreeBASIC here:
set "FB_HOME=C:\tools\FreeBASIC"

if not exist "%FB_HOME%" (
    echo ERROR: FreeBASIC not found in "%FB_HOME%". Please specify the correct path to FreeBASIC in "%~nx0".
    exit /b 1
)
if not exist "%FB_HOME%\bin\win32" (
    echo ERROR: FreeBASIC bin\win32 not found in "%FB_HOME%\bin\win32"
    exit /b 1
)

set "PATH=%PATH%;%FB_HOME%;%FB_HOME%\bin\win32"
set "OUT_DIR=%~dp0Build-Win32"
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"

rem fbc flags (see also Compile64.bat):
rem   -strip     Passes -s to ld: remove symbol table / relocation info from the PE (smaller file).
rem   -O 2       FreeBASIC compiler optimization level on its IR before emitting C (-gen gcc).
rem   -Wc -Os    GCC: optimize for size.
rem   -Wc -O2    GCC: optimize for speed.
rem 32-bit DLL can be slightly larger than 64-bit for the same source: more stack spills / different
rem tuning in libgcc+runtime, x87 vs SSE paths, and x64 sometimes shrinking hot code via extra GPRs.

echo Compiling (32-bit)...
fbc -dll -gen gcc -arch 386 -x "%OUT_DIR%\SmartMath.dll" -strip -O 2 -Wc -O2 "Smart-Math.bas" "Smart-Math-Format.bas" "Smart-Math-CopyNormalize.bas" "Smart-Math-About.bas" "MathParser.bas" "ConfigManager.bas" "Res\Resource.rc"
if exist "%OUT_DIR%\*.a" del "%OUT_DIR%\*.a"
if exist "%OUT_DIR%\*.o" del "%OUT_DIR%\*.o"
REM pause
