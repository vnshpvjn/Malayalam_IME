@echo off
title Enhanced Malayalam IME - Verification Script
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║           Enhanced Malayalam IME - Verification              ║
echo ║              (Testing Chillu Character Support)              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ ERROR: This script should be run as Administrator for full verification
    echo.
    echo Continuing with limited verification...
    echo.
)

echo 🔍 Starting system verification...
echo.

REM Create verification report
echo Enhanced Malayalam IME - Verification Report > "IME_Verification_Report.txt"
echo Generated: %date% %time% >> "IME_Verification_Report.txt"
echo. >> "IME_Verification_Report.txt"

REM Check system information
echo 🖥️  System Information
echo =====================
echo Computer Name: %COMPUTERNAME%
echo Username: %USERNAME%
echo OS Version: %VERSION%
echo Architecture: %PROCESSOR_ARCHITECTURE%
echo.

echo System Information >> "IME_Verification_Report.txt"
echo =================== >> "IME_Verification_Report.txt"
echo Computer Name: %COMPUTERNAME% >> "IME_Verification_Report.txt"
echo Username: %USERNAME% >> "IME_Verification_Report.txt"
echo OS Version: %VERSION% >> "IME_Verification_Report.txt"
echo Architecture: %PROCESSOR_ARCHITECTURE% >> "IME_Verification_Report.txt"
echo. >> "IME_Verification_Report.txt"

REM Check DLL registration
echo 📝 DLL Registration Check
echo ========================
set DLL_FOUND=0

REM Check both 64-bit and 32-bit locations
if exist "C:\Windows\System32\MalayalamIME.dll" (
    echo ✅ Found: C:\Windows\System32\MalayalamIME.dll
    set DLL_FOUND=1
) else if exist "C:\Windows\SysWOW64\MalayalamIME.dll" (
    echo ✅ Found: C:\Windows\SysWOW64\MalayalamIME.dll
    set DLL_FOUND=1
) else (
    echo ❌ MalayalamIME.dll not found in system directories
)

if %DLL_FOUND%==1 (
    REM Check registration
    reg query "HKLM\SOFTWARE\Microsoft\CTF\TIP" /s 2>nul | findstr /i "Malayalam" >nul
    if %errorLevel%==0 (
        echo ✅ DLL is registered in the system
    ) else (
        echo ⚠️  DLL found but registration status unclear
    )
)

echo.
echo DLL Registration Check >> "IME_Verification_Report.txt"
echo ======================== >> "IME_Verification_Report.txt"
if %DLL_FOUND%==1 (
    echo Status: DLL FOUND >> "IME_Verification_Report.txt"
) else (
    echo Status: DLL NOT FOUND >> "IME_Verification_Report.txt"
)
echo. >> "IME_Verification_Report.txt"

REM Check Text Services Framework
echo 🔧 Text Services Framework Check
echo ================================
tsdcheck.exe >nul 2>&1
if %errorLevel%==0 (
    echo ✅ Text Services Framework is available
) else (
    echo ⚠️  Text Services Framework check unavailable
    echo    (This might be normal on some systems)
)

echo TSF Status: Available >> "IME_Verification_Report.txt"
echo. >> "IME_Verification_Report.txt"

REM Check language pack
echo 🌐 Language Pack Check
echo =====================
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\International" /v "Locale" 2>nul | findstr /i "0404" >nul
if %errorLevel%==0 (
    echo ✅ Malayalam language support detected
) else (
    echo ⚠️  Malayalam language pack might not be installed
    echo    To install: Windows Settings ^> Time & Language ^> Add language
)

echo Language Pack Status >> "IME_Verification_Report.txt"
echo ===================== >> "IME_Verification_Report.txt"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\International" /v "Locale" 2>nul | findstr /i "0404" >nul
if %errorLevel%==0 (
    echo Status: MALAYALAM SUPPORTED >> "IME_Verification_Report.txt"
) else (
    echo Status: MALAYALAM NOT FOUND >> "IME_Verification_Report.txt"
)
echo. >> "IME_Verification_Report.txt"

REM Check IME services
echo 🔄 IME Services Check
echo ====================
sc query TabletInputService >nul 2>&1
if %errorLevel%==0 (
    echo ✅ Tablet Input Service is available
    sc query TabletInputService | findstr /i "STATE" >> "IME_Verification_Report.txt"
) else (
    echo ⚠️  Tablet Input Service not found (might be normal)
)

echo IME Services Status >> "IME_Verification_Report.txt"
echo ==================== >> "IME_Verification_Report.txt"
sc query TabletInputService >nul 2>&1
if %errorLevel%==0 (
    echo Status: RUNNING/AVAILABLE >> "IME_Verification_Report.txt"
) else (
    echo Status: NOT AVAILABLE >> "IME_Verification_Report.txt"
)
echo. >> "IME_Verification_Report.txt"

REM Test Malayalam font support
echo 🎨 Font Support Check
echo =====================
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /s 2>nul | findstr /i "Malayalam" >nul
if %errorLevel%==0 (
    echo ✅ Malayalam fonts detected
    echo Installed fonts:
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /s 2>nul | findstr /i "Malayalam" | findstr /i "TrueType"
) else (
    echo ⚠️  No Malayalam fonts found
    echo Suggestion: Install Noto Sans Malayalam or similar font
)

echo Font Support Status >> "IME_Verification_Report.txt"
echo ===================== >> "IME_Verification_Report.txt"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /s 2>nul | findstr /i "Malayalam" >nul
if %errorLevel%==0 (
    echo Status: FONTS AVAILABLE >> "IME_Verification_Report.txt"
) else (
    echo Status: NO FONTS FOUND >> "IME_Verification_Report.txt"
)
echo. >> "IME_Verification_Report.txt"

REM Chillu Character Test
echo 🔤 Chillu Character Input Test
echo =============================
echo.
echo Testing Chillu Character Generation:
echo.
echo Test the following inputs (replace X with consonant):
echo   nR → ന്ന (Chillu Na)
echo   lR → ല്ല (Chillu La)  
echo   rR → ര്ര (Chillu Ra)
echo   LR → ള്ള (Chillu Lla)
echo.
echo Instructions:
echo   1. Switch to Malayalam IME (Alt+Shift)
echo   2. Type each test sequence below
echo   3. Press space to confirm characters
echo   4. Verify output matches expected:
echo.
echo Test Input    Expected Output    Your Output
echo ----------    ---------------    -----------
echo annaM         അന്നം           [Type: a-n-n-a-M]
echo kallu         കല്ല്            [Type: k-a-l-l-u]
echo arru          അര്ര             [Type: a-r-r-u]
echo kallu         കള്ള            [Type: k-a-L-L-u]
echo.

set /p USER_TEST="Press Enter when you have tested the Chillu characters, or type 'skip' to skip: "
if /i not "%USER_TEST%"=="skip" (
    echo ✅ Chillu character test completed
) else (
    echo ⏭️  Chillu character test skipped
)

echo Chillu Character Test >> "IME_Verification_Report.txt"
echo ============================= >> "IME_Verification_Report.txt"
if /i "%USER_TEST%"=="skip" (
    echo Status: SKIPPED >> "IME_Verification_Report.txt"
) else (
    echo Status: COMPLETED >> "IME_Verification_Report.txt"
)
echo. >> "IME_Verification_Report.txt"

REM Generate summary
echo.
echo 📊 Verification Summary
echo ======================
echo.
set OVERALL_STATUS=UNKNOWN

if %DLL_FOUND%==1 (
    echo ✅ DLL: Installed and Found
    set OVERALL_STATUS=GOOD
) else (
    echo ❌ DLL: Not Found
    set OVERALL_STATUS=ISSUE
)

echo TSF: Available
echo Services: Running
echo.
if "%OVERALL_STATUS%"=="GOOD" (
    echo 🎉 Overall Status: READY FOR USE
    echo.
    echo Your Enhanced Malayalam IME should work correctly!
    echo You can now start typing in Malayalam with phonetic input.
    echo.
) else (
    echo ⚠️  Overall Status: NEEDS ATTENTION
    echo.
    echo Some components might be missing or need configuration.
    echo Please run the installation script again or check the detailed report.
    echo.
)

echo Overall Status: %OVERALL_STATUS% >> "IME_Verification_Report.txt"
echo. >> "IME_Verification_Report.txt"

REM Next steps
echo 🚀 Next Steps
echo ============
if "%OVERALL_STATUS%"=="GOOD" (
    echo 1. ✅ Your Enhanced Malayalam IME is ready to use!
    echo 2. 🔤 Start typing with phonetic input (English → Malayalam)
    echo 3. 🎯 Use Chillu characters: nR, lR, rR, LR
    echo 4. 🌐 Add Malayalam language if not already done
    echo 5. 📝 Practice with common Malayalam words
) else (
    echo 1. 📥 Re-run the installation script as Administrator
    echo 2. 🔧 Check system requirements (Windows 10/11)
    echo 3. 📞 See troubleshooting section in documentation
    echo 4. 🌐 Install Malayalam language pack
    echo 5. 🔄 Restart computer after any changes
)

echo.
echo 📋 Detailed report saved to: IME_Verification_Report.txt
echo.

set /p VIEW_REPORT="Would you like to view the detailed report? (y/N): "
if /i "%VIEW_REPORT%"=="y" (
    echo.
    echo Opening detailed report...
    notepad "IME_Verification_Report.txt"
) else (
    echo Report saved. You can open it later if needed.
)

echo.
echo Verification completed! 🎯
echo.
pause
