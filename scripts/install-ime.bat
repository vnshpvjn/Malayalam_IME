@echo off
title Enhanced Malayalam IME - Installation Script
color 0A

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║         Enhanced Malayalam IME - Installation                ║
echo ║              (Enhanced Chillu Character Support)             ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ ERROR: This script must be run as Administrator
    echo.
    echo Please right-click this script and select "Run as Administrator"
    echo Or run this command in Command Prompt (Admin):
    echo     cd /d "%~dp0"
    echo     install-ime.bat
    echo.
    pause
    exit /b 1
)

echo ✅ Administrator privileges confirmed
echo.

REM Check if MalayalamIME.dll exists
if not exist "MalayalamIME.dll" (
    echo ❌ ERROR: MalayalamIME.dll not found in current directory
    echo.
    echo Please ensure the following files are in the same folder as this script:
    echo   - MalayalamIME.dll
    echo   - install-ime.bat
    echo.
    echo Download from GitHub Actions or compile locally first.
    echo.
    pause
    exit /b 1
)

echo ✅ Found MalayalamIME.dll
echo.

REM Check Windows version
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
echo 🖥️  Windows Version: %VERSION%
echo.

REM Determine system architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set SYSTEM_DIR=System32
    set SYSTEM_ARCH=64-bit
) else if "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
    set SYSTEM_DIR=System32
    set SYSTEM_ARCH=64-bit
) else (
    set SYSTEM_DIR=SysWOW64
    set SYSTEM_ARCH=32-bit
)

echo 🏗️  System Architecture: %SYSTEM_ARCH%
echo.

REM Copy DLL to system directory
echo 📁 Copying MalayalamIME.dll to system directory...
copy "MalayalamIME.dll" "C:\Windows\%SYSTEM_DIR%\MalayalamIME.dll"
if %errorLevel% neq 0 (
    echo ❌ ERROR: Failed to copy DLL to system directory
    echo.
    echo Try running as Administrator or check file permissions
    pause
    exit /b 1
)

echo ✅ DLL copied successfully to C:\Windows\%SYSTEM_DIR%\
echo.

REM Register the IME
echo 📝 Registering MalayalamIME.dll...
regsvr32 /s "C:\Windows\%SYSTEM_DIR%\MalayalamIME.dll"
if %errorLevel% neq 0 (
    echo ❌ ERROR: Failed to register DLL
    echo.
    echo This might be due to missing dependencies or incorrect architecture
    pause
    exit /b 1
)

echo ✅ DLL registered successfully
echo.

REM Check for existing Malayalam language pack
echo 🌐 Checking Malayalam language support...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\International" /v "Locale" | findstr /i "0404" >nul
if %errorLevel% neq 0 (
    echo ⚠️  WARNING: Malayalam language pack might not be installed
    echo.
    echo To enable Malayalam language:
    echo   1. Go to Windows Settings (Win + I)
    echo   2. Time & Language ^> Language & region
    echo   3. Add a language ^> Malayalam
    echo   4. Install the language pack
    echo.
)

REM Create verification log
echo Creating installation log...
echo Enhanced Malayalam IME - Installation Log > "IME_Installation_Log.txt"
echo Date: %date% %time% >> "IME_Installation_Log.txt"
echo System: %COMPUTERNAME% >> "IME_Installation_Log.txt"
echo OS Version: %VERSION% >> "IME_Installation_Log.txt"
echo Architecture: %SYSTEM_ARCH% >> "IME_Installation_Log.txt"
echo DLL Location: C:\Windows\%SYSTEM_DIR%\MalayalamIME.dll >> "IME_Installation_Log.txt"
echo Installation Status: SUCCESS >> "IME_Installation_Log.txt"
echo. >> "IME_Installation_Log.txt"
echo Chillu Character Support: >> "IME_Installation_Log.txt"
echo   - ന്ന (nR input) >> "IME_Installation_Log.txt"
echo   - ല്ല (lR input) >> "IME_Installation_Log.txt"
echo   - ര്ര (rR input) >> "IME_Installation_Log.txt"
echo   - ള്ള (LR input) >> "IME_Installation_Log.txt"

echo ✅ Installation log created: IME_Installation_Log.txt
echo.

REM Success message
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                     INSTALLATION COMPLETE!                   ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  Enhanced Malayalam IME with Chillu Character Support       ║
echo ║                                                              ║
echo ║  Next Steps:                                                 ║
echo ║  1. Restart your computer (recommended)                      ║
echo ║  2. Go to Windows Settings ^> Language & region              ║
echo ║  3. Add Malayalam language if not already installed          ║
echo ║  4. Select "Enhanced Malayalam IME" as keyboard layout       ║
echo ║  5. Start typing with phonetic input!                        ║
echo ║                                                              ║
echo ║  Chillu Character Input:                                     ║
echo ║    nR → ന്ന     lR → ല്ല     rR → ര്ര     LR → ള്ള              ║
echo ║                                                              ║
echo ║  Files installed:                                            ║
echo ║    - C:\Windows\%SYSTEM_DIR%\MalayalamIME.dll                      ║
echo ║    - IME_Installation_Log.txt                               ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Optional: Ask to restart
set /p RESTART="Would you like to restart now? (y/N): "
if /i "%RESTART%"=="y" (
    echo.
    echo Restarting computer in 10 seconds...
    echo Press Ctrl+C to cancel
    timeout /t 10
    shutdown /r /t 0
) else (
    echo.
    echo Please remember to restart your computer later for full functionality.
)

echo.
echo Installation completed successfully! 🎉
echo.
pause
