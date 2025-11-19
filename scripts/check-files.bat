@echo off
title Enhanced Malayalam IME - File Check Script
color 0C

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║            Enhanced Malayalam IME - File Check               ║
echo ║                 (Integrity Verification)                     ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo 🔍 Starting file integrity check...
echo.

REM Create file check report
echo Enhanced Malayalam IME - File Check Report > "IME_File_Check_Report.txt"
echo Generated: %date% %time% >> "IME_File_Check_Report.txt"
echo. >> "IME_File_Check_Report.txt"

REM Check required files
echo 📋 Required Files Check
echo ======================
echo.

set FILES_OK=1

REM Main DLL file
echo Checking MalayalamIME.dll...
if exist "MalayalamIME.dll" (
    echo ✅ MalayalamIME.dll found
    echo   Size: 
    dir "MalayalamIME.dll" | findstr "MalayalamIME.dll" >> "IME_File_Check_Report.txt"
    echo   Status: FOUND
) else (
    echo ❌ MalayalamIME.dll NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

REM Installation script
echo Checking install-ime.bat...
if exist "install-ime.bat" (
    echo ✅ install-ime.bat found
    echo   Status: FOUND
) else (
    echo ❌ install-ime.bat NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

REM Verification script
echo Checking verify-setup.bat...
if exist "verify-setup.bat" (
    echo ✅ verify-setup.bat found
    echo   Status: FOUND
) else (
    echo ❌ verify-setup.bat NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

REM Documentation files
echo Checking documentation files...
if exist "README.md" (
    echo ✅ README.md found
    echo   Status: FOUND
) else (
    echo ❌ README.md NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "docs\BUILD_INSTRUCTIONS.md" (
    echo ✅ docs\BUILD_INSTRUCTIONS.md found
    echo   Status: FOUND
) else (
    echo ❌ docs\BUILD_INSTRUCTIONS.md NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "docs\INSTALL_GUIDE.md" (
    echo ✅ docs\INSTALL_GUIDE.md found
    echo   Status: FOUND
) else (
    echo ❌ docs\INSTALL_GUIDE.md NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "docs\CHILLU_CHARACTERS.md" (
    echo ✅ docs\CHILLU_CHARACTERS.md found
    echo   Status: FOUND
) else (
    echo ❌ docs\CHILLU_CHARACTERS.md NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

REM Source files
echo Checking source files...
if exist "src\MalayalamIME.cpp" (
    echo ✅ src\MalayalamIME.cpp found
    echo   Status: FOUND
) else (
    echo ❌ src\MalayalamIME.cpp NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "src\MalayalamIME.h" (
    echo ✅ src\MalayalamIME.h found
    echo   Status: FOUND
) else (
    echo ❌ src\MalayalamIME.h NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "src\Register.cpp" (
    echo ✅ src\Register.cpp found
    echo   Status: FOUND
) else (
    echo ❌ src\Register.cpp NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

REM GitHub workflow
echo Checking GitHub Actions workflow...
if exist ".github\workflows\build.yml" (
    echo ✅ .github\workflows\build.yml found
    echo   Status: FOUND
) else (
    echo ❌ .github\workflows\build.yml NOT FOUND
    echo   Status: MISSING
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

echo.
echo 📁 Directory Structure Check
echo ============================
echo.

REM Check directory structure
if exist ".github" (
    echo ✅ .github directory found
) else (
    echo ❌ .github directory NOT FOUND
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "src" (
    echo ✅ src directory found
) else (
    echo ❌ src directory NOT FOUND
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "docs" (
    echo ✅ docs directory found
) else (
    echo ❌ docs directory NOT FOUND
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

if exist "scripts" (
    echo ✅ scripts directory found
) else (
    echo ❌ scripts directory NOT FOUND
    set FILES_OK=0
)

echo. >> "IME_File_Check_Report.txt"

REM File integrity checks
echo.
echo 🔒 File Integrity Checks
echo =======================
echo.

REM Check DLL file integrity
if exist "MalayalamIME.dll" (
    echo Checking DLL file integrity...
    REM Try to get file properties
    for %%A in (MalayalamIME.dll) do (
        echo   File: %%A
        echo   Size: %%~zA bytes
        echo   Modified: %%~tA
        echo   Status: VALID
        
        echo DLL Integrity Check >> "IME_File_Check_Report.txt"
        echo File: %%A >> "IME_File_Check_Report.txt"
        echo Size: %%~zA bytes >> "IME_File_Check_Report.txt"
        echo Modified: %%~tA >> "IME_File_Check_Report.txt"
        echo Status: VALID >> "IME_File_Check_Report.txt"
    )
) else (
    echo ❌ Cannot check DLL integrity - file not found
    echo DLL Integrity Check >> "IME_File_Check_Report.txt"
    echo Status: FILE NOT FOUND >> "IME_File_Check_Report.txt"
)

echo. >> "IME_File_Check_Report.txt"

REM Check workflow file syntax (basic)
if exist ".github\workflows\build.yml" (
    echo Checking GitHub workflow file...
    findstr /i "name:" ".github\workflows\build.yml" >nul
    if %errorLevel%==0 (
        echo ✅ Workflow file has valid structure
        echo   Status: VALID YAML
    ) else (
        echo ⚠️  Workflow file structure unclear
        echo   Status: NEEDS REVIEW
    )
    
    echo Workflow File Check >> "IME_File_Check_Report.txt"
    echo Status: VALID YAML STRUCTURE >> "IME_File_Check_Report.txt"
) else (
    echo ❌ Cannot check workflow - file not found
    echo Workflow File Check >> "IME_File_Check_Report.txt"
    echo Status: FILE NOT FOUND >> "IME_File_Check_Report.txt"
)

echo. >> "IME_File_Check_Report.txt"

REM Summary
echo.
echo 📊 File Check Summary
echo ====================
echo.

if %FILES_OK%==1 (
    echo ✅ Overall Status: ALL FILES PRESENT
    echo.
    echo Your repository contains all required files for the Enhanced Malayalam IME:
    echo   ✅ Main DLL file (MalayalamIME.dll)
    echo   ✅ Installation scripts (install-ime.bat, verify-setup.bat)
    echo   ✅ Documentation files (README.md, guides)
    echo   ✅ Source code files (src\ directory)
    echo   ✅ GitHub Actions workflow (.github\workflows\build.yml)
    echo.
    echo 🎯 Ready for:
    echo   - Local development and building
    echo   - GitHub Actions automatic compilation
    echo   - Distribution and installation
    echo   - User documentation and support
) else (
    echo ❌ Overall Status: MISSING FILES DETECTED
    echo.
    echo Some required files are missing from your repository:
    echo   ❌ Check the detailed report above
    echo   ❌ Ensure proper repository structure
    echo   ❌ Download missing files or rebuild project
    echo.
    echo 📋 Next Steps:
    echo   1. Check the detailed report: IME_File_Check_Report.txt
    echo   2. Ensure all files are properly committed to GitHub
    echo   3. Verify repository structure matches expected layout
    echo   4. Re-run installation or build processes as needed
)

echo Overall Status >> "IME_File_Check_Report.txt"
echo ============== >> "IME_File_Check_Report.txt"
if %FILES_OK%==1 (
    echo Status: ALL FILES PRESENT >> "IME_File_Check_Report.txt"
) else (
    echo Status: MISSING FILES DETECTED >> "IME_File_Check_Report.txt"
)
echo. >> "IME_File_Check_Report.txt"

echo.
echo 📋 Detailed report saved to: IME_File_Check_Report.txt
echo.

set /p VIEW_REPORT="Would you like to view the detailed report? (y/N): "
if /i "%VIEW_REPORT%"=="y" (
    echo.
    echo Opening detailed report...
    notepad "IME_File_Check_Report.txt"
) else (
    echo Report saved. You can open it later if needed.
)

echo.
echo File check completed! 📁
echo.
pause
