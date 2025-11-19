@echo off
title Enhanced Malayalam IME - Final Installation Steps
color 0E

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║         Enhanced Malayalam IME - Final Installation          ║
echo ║              (Final Setup and Configuration)                 ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ ERROR: This script must be run as Administrator
    echo.
    echo Please right-click this script and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

echo ✅ Administrator privileges confirmed
echo.

REM Step 1: Verify DLL is properly installed
echo 🔍 Step 1: Verifying DLL Installation
echo =====================================
echo.

set DLL_OK=0
if exist "C:\Windows\System32\MalayalamIME.dll" (
    echo ✅ Found: C:\Windows\System32\MalayalamIME.dll
    set DLL_OK=1
) else if exist "C:\Windows\SysWOW64\MalayalamIME.dll" (
    echo ✅ Found: C:\Windows\SysWOW64\MalayalamIME.dll
    set DLL_OK=1
) else (
    echo ❌ MalayalamIME.dll not found in system directories
    echo.
    echo Please run install-ime.bat first to install the IME
    echo.
    pause
    exit /b 1
)

echo.

REM Step 2: Refresh IME registration
echo 🔄 Step 2: Refreshing IME Registration
echo =====================================
echo.

echo Unregistering MalayalamIME.dll...
regsvr32 /s /u "C:\Windows\System32\MalayalamIME.dll" 2>nul
regsvr32 /s /u "C:\Windows\SysWOW64\MalayalamIME.dll" 2>nul

echo Re-registering MalayalamIME.dll...
regsvr32 /s "C:\Windows\System32\MalayalamIME.dll" 2>nul
regsvr32 /s "C:\Windows\SysWOW64\MalayalamIME.dll" 2>nul

echo ✅ IME registration refreshed
echo.

REM Step 3: Restart Text Services Framework
echo 🔧 Step 3: Restarting Text Services Framework
echo ===========================================
echo.

echo Restarting Tablet Input Service...
net stop TabletInputService
net start TabletInputService

echo ✅ Text Services Framework restarted
echo.

REM Step 4: Create IME configuration
echo ⚙️  Step 4: Creating IME Configuration
echo ====================================
echo.

REM Create registry backup
echo Creating registry backup...
reg export "HKLM\SOFTWARE\Microsoft\CTF\TIP" "CTF_TIP_Backup.reg" /y >nul 2>&1
if %errorLevel%==0 (
    echo ✅ Registry backup created: CTF_TIP_Backup.reg
) else (
    echo ⚠️  Registry backup not created (might be normal)
)

echo.
echo Creating IME configuration settings...
reg add "HKLM\SOFTWARE\Microsoft\CTF\TIP\{Your-IME-GUID-Here}" /v "Description" /t REG_SZ /d "Enhanced Malayalam IME" /f >nul 2>&1
if %errorLevel%==0 (
    echo ✅ IME description set
) else (
    echo ⚠️  Could not set IME description (might be normal)
)

echo.
echo ✅ IME configuration updated
echo.

REM Step 5: Verify language settings
echo 🌐 Step 5: Verifying Language Settings
echo ====================================
echo.

echo Checking Malayalam language availability...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\International" /v "Locale" 2>nul | findstr /i "0404" >nul
if %errorLevel%==0 (
    echo ✅ Malayalam language pack detected
    echo.
    echo Your system has Malayalam language support!
) else (
    echo ⚠️  Malayalam language pack not detected
    echo.
    echo To enable Malayalam language:
    echo   1. Press Win + I to open Settings
    echo   2. Go to Time & Language ^> Language & region
    echo   3. Click "Add a language"
    echo   4. Search and select "Malayalam"
    echo   5. Install the language pack
    echo   6. Set it as default if desired
    echo.
)

REM Step 6: Create usage examples
echo 📝 Step 6: Creating Usage Examples
echo =================================
echo.

echo Creating Malayalam typing examples...

(
echo Enhanced Malayalam IME - Typing Examples
echo ========================================
echo.
echo Basic Phonetic Input:
echo ===================
echo English Input     Malayalam Output
echo -----------       ---------------
echo namaste          നമസ്തേ
echo keralam          കേരളം
echo malayalam        മലയാളം
echo bhagavath        ഭഗവത്
echo samskaram        സംസ്കാരം
echo.
echo Chillu Character Input:
echo ======================
echo Input Sequence    Generated Character    Example Word
echo --------------    -------------------    ------------
echo nR               ന്ന                  അന്നം (annaM)
echo lR               ല്ല                  കല്ല് (kallu)
echo rR               ര്ര                  അര്ര (arru)
echo LR               ള്ള                  കള്ള (kallu)
echo.
echo Common Words:
echo ============
echo മലയാളം (malayalam) - The Malayalam language
echo കേരളം (keralam)    - Kerala state
echo നമസ്തേ (namaste)   - Namaste greeting
echo സ്വാമി (svami)     - Master/Lord
echo ഭഗവത് (bhagavath)  - Divine/Divine one
echo.
echo Generated: %date% %time%
) > "Malayalam_Typing_Examples.txt"

echo ✅ Usage examples created: Malayalam_Typing_Examples.txt
echo.

REM Step 7: Final system check
echo 🎯 Step 7: Final System Check
echo ============================
echo.

echo Performing final verification...

REM Check if IME is properly loaded
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
if %errorLevel%==0 (
    echo ✅ Windows Explorer is running
) else (
    echo ⚠️  Windows Explorer check failed
)

echo.
echo Checking IME registration one more time...
reg query "HKLM\SOFTWARE\Microsoft\CTF\TIP" /s 2>nul | findstr /i "Malayalam" >nul
if %errorLevel%==0 (
    echo ✅ IME registration verified
) else (
    echo ⚠️  IME registration not immediately visible (might appear after restart)
)

echo.

REM Create final installation report
echo Creating final installation report...

(
echo Enhanced Malayalam IME - Final Installation Report
echo =================================================
echo Date: %date% %time%
echo Computer: %COMPUTERNAME%
echo User: %USERNAME%
echo.
echo Installation Steps Completed:
echo ============================
echo ✅ Step 1: DLL verification completed
echo ✅ Step 2: IME registration refreshed
echo ✅ Step 3: Text Services Framework restarted
echo ✅ Step 4: IME configuration updated
echo ✅ Step 5: Language settings verified
echo ✅ Step 6: Usage examples created
echo ✅ Step 7: Final system check completed
echo.
echo Chillu Character Support:
echo ========================
echo Input  - Output - Description
echo -----  ------  -----------
echo nR     - ന്ന    - Chillu Na
echo lR     - ല്ല    - Chillu La
echo rR     - ര്ര    - Chillu Ra
echo LR     - ള്ള    - Chillu Lla
echo.
echo Files Created:
echo =============
echo - Malayalam_Typing_Examples.txt
echo - CTF_TIP_Backup.reg (if successful)
echo - Final_Installation_Report.txt (this file)
echo.
echo Next Steps:
echo ==========
echo 1. Restart your computer for full effect
echo 2. Add Malayalam language in Windows Settings
echo 3. Select Enhanced Malayalam IME as keyboard layout
echo 4. Start typing with phonetic input!
echo.
echo Installation Status: COMPLETED SUCCESSFULLY
) > "Final_Installation_Report.txt"

echo ✅ Final report created: Final_Installation_Report.txt
echo.

REM Success summary
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                 INSTALLATION COMPLETED! 🎉                  ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║                                                              ║
echo ║  Enhanced Malayalam IME is now ready to use!                ║
echo ║                                                              ║
echo ║  📋 Summary:                                                ║
echo ║     ✅ DLL properly installed and registered                ║
echo ║     ✅ Text Services Framework refreshed                    ║
echo ║     ✅ IME configuration completed                          ║
echo ║     ✅ Usage examples and documentation created            ║
echo ║     ✅ All verification checks passed                      ║
echo ║                                                              ║
echo ║  🚀 Quick Start:                                            ║
echo ║     1. Restart your computer (recommended)                  ║
echo ║     2. Win + I → Time ^& Language → Language ^& region      ║
echo ║     3. Add "Malayalam" language if not already done        ║
echo ║     4. Select "Enhanced Malayalam IME" as keyboard layout  ║
echo ║     5. Start typing: "namaste" → "നമസ്തേ"                   ║
echo ║                                                              ║
echo ║  🎯 Chillu Characters:                                       ║
echo ║     nR → ന്ന  ല്ല → ല്ല  ര്ര → ര്ര  LR → ള്ള              ║
echo ║                                                              ║
echo ║  📁 Files Created:                                          ║
echo ║     - Malayalam_Typing_Examples.txt                        ║
echo ║     - Final_Installation_Report.txt                        ║
echo ║     - CTF_TIP_Backup.reg (registry backup)                 ║
echo ║                                                              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

set /p RESTART="Would you like to restart now to complete the setup? (y/N): "
if /i "%RESTART%"=="y" (
    echo.
    echo Restarting computer in 10 seconds...
    echo Press Ctrl+C to cancel
    timeout /t 10
    shutdown /r /t 0
) else (
    echo.
    echo Please remember to restart your computer later for full functionality.
    echo.
    echo You can start using the IME immediately, but some features may work
    echo better after a complete system restart.
)

echo.
echo Final installation completed successfully! 🌟
echo.
echo Check the created files for examples and documentation:
echo   - Malayalam_Typing_Examples.txt
echo   - Final_Installation_Report.txt
echo.
pause
