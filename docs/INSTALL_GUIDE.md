# 📦 Installation Guide - Enhanced Malayalam IME

## 🎯 Overview

This guide provides step-by-step instructions for installing the Enhanced Malayalam IME with comprehensive chillu character support.

## 📋 Prerequisites

### System Requirements
- **Windows 10** or **Windows 11** (x64)
- **Administrator privileges** for installation
- **At least 50 MB** free disk space

### Required Components
- Text Services Framework (TSF) support (built into Windows)
- .NET Framework 4.5 or later (usually pre-installed)

## 🚀 Installation Methods

### Method 1: Pre-built DLL (Recommended)

#### Step 1: Download Compiled IME
1. Go to the repository: `github.com/your-username/malayalam-ime-enhanced`
2. Click on **"Actions"** tab
3. Find the latest successful workflow run (green checkmark)
4. Click on the workflow run
5. Under **"Artifacts"**, click **"MalayalamIME-Enhanced"**
6. Download and extract the zip file
7. You'll find `MalayalamIME.dll` inside

#### Step 2: Install the IME
1. **Run as Administrator:**
   - Right-click on command prompt → "Run as Administrator"
   - Or right-click on PowerShell → "Run as Administrator"

2. **Navigate to extracted folder:**
   ```bash
   cd path\to\extracted\folder
   ```

3. **Install IME:**
   ```bash
   regsvr32 MalayalamIME.dll
   ```

4. **Verify Installation:**
   ```bash
   regsvr32 /u MalayalamIME.dll  # For unregistering if needed
   ```

### Method 2: Using Installation Scripts

#### Step 1: Download Installation Script
Use the provided script for automated installation:

```batch
@echo off
echo Installing Enhanced Malayalam IME...
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script must be run as Administrator
    echo Right-click the script and select "Run as Administrator"
    pause
    exit /b 1
)

REM Copy DLL to system directory
echo Copying MalayalamIME.dll to system directory...
copy "MalayalamIME.dll" "C:\Windows\System32\MalayalamIME.dll"
if %errorLevel% neq 0 (
    copy "MalayalamIME.dll" "C:\Windows\SysWOW64\MalayalamIME.dll"
)

REM Register the IME
echo Registering MalayalamIME.dll...
regsvr32 /s "C:\Windows\System32\MalayalamIME.dll"

echo.
echo Installation completed successfully!
echo Please restart your computer and check language settings.
echo.
pause
```

### Method 3: Manual Installation

#### Step 1: Copy DLL File
1. **Locate MalayalamIME.dll** from build or download
2. **Copy to system directory:**
   - For 64-bit Windows: `C:\Windows\System32\MalayalamIME.dll`
   - For 32-bit applications on 64-bit: `C:\Windows\SysWOW64\MalayalamIME.dll`

#### Step 2: Register DLL
1. **Open Command Prompt as Administrator**
2. **Navigate to the DLL location:**
   ```bash
   cd C:\Windows\System32
   ```
3. **Register the DLL:**
   ```bash
   regsvr32 MalayalamIME.dll
   ```
4. **Success message:** "DllRegisterServer in MalayalamIME.dll succeeded"

#### Step 3: Configure Language Settings
1. **Open Windows Settings:**
   - Press `Windows + I`
   - Go to **Time & Language** → **Language & region**

2. **Add Malayalam Language:**
   - Click **"Add a language"**
   - Search for **"Malayalam"**
   - Select and install

3. **Enable IME:**
   - Select **"Malayalam (India)"**
   - Click **"Options"**
   - Add **"Enhanced Malayalam IME"** as keyboard layout

## 🎯 Chillu Character Setup

### Understanding Chillu Characters
Chillu characters are special consonant forms in Malayalam:
- **ന്ന** (chillu na) - Combined form of ന + ്ന
- **ല്ല** (chillu la) - Combined form of ല + ്ല  
- **ര്ര** (chillu ra) - Combined form of ര + ്ര
- **ള്ള** (chillu lla) - Combined form of ള + ്ള

### Input Method for Chillu Characters
| Input Sequence | Generated Character | Example Usage |
|---------------|-------------------|---------------|
| `nR`          | ന്ന              | അന്നം (annaM) |
| `lR`          | ല്ല              | കല്ല് (kallu) |
| `rR`          | ര്ര              | അര്ര (arru) |
| `LR`          | ള്ള              | കള്ള (kallu) |

### Testing Chillu Characters
1. **Open Notepad** or any text editor
2. **Switch to Malayalam IME**
3. **Type the input sequences:**
   - `nR` → Should produce ന്ന
   - `lR` → Should produce ല്ല
   - `rR` → Should produce ര്ര
   - `LR` → Should produce ള്ള

## 🔧 Configuration Options

### Registry Settings
Advanced users can modify registry settings:

**Location:** `HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\TIP\{GUID}`

**Key Settings:**
- `Description` - IME display name
- `IconFile` - Custom icon (optional)
- `Enable` - Enable/disable IME (1 = enabled)

### Language Bar Settings
1. **Right-click on Language Bar**
2. **Select "Settings"**
3. **Configure IME options:**
   - Conversion mode (On/Off/Hybrid)
   - Character width (Full/Half)
   - Keyboard layout preferences

## 📱 Using the IME

### Basic Usage
1. **Switch to Malayalam IME** using Alt+Shift or language bar
2. **Start typing** using phonetic input
3. **Press space** to confirm character selection
4. **Use backspace** to edit previous characters

### Advanced Features

#### Phonetic Input Examples
```
English Input → Malayalam Output
kumaara → കുമാര
sree → ശ്രീ
bhagavath → ഭഗവത്
samskaram → സംസ്കാരം
```

#### Chillu Character Context
- **Automatic generation** when appropriate consonants are followed by `R`
- **Intelligent context** detection for proper usage
- **Multiple variations** supported based on character combinations

## 🛠️ Troubleshooting

### Common Installation Issues

#### Error: "The module MalayalamIME.dll was loaded but the entry-point DllRegisterServer was not found"
**Solution:**
```
- Ensure you're using the correct DLL for your system architecture
- For 64-bit Windows, use the 64-bit version
- Rebuild the project for the correct platform
```

#### Error: "Access denied" during registration
**Solution:**
```
- Run Command Prompt as Administrator
- Disable antivirus temporarily during installation
- Ensure no other applications are using the DLL
```

#### Error: " Malayalam IME not appearing in language options"
**Solution:**
```
- Restart Windows after registration
- Check if Malayalam language pack is installed
- Verify registry entries are created correctly
```

### Runtime Issues

#### IME not switching
**Solutions:**
1. **Restart Text Services Framework:**
   ```bash
   net stop TabletInputService
   net start TabletInputService
   ```

2. **Check language settings:**
   - Ensure Malayalam is added to Windows
   - Verify IME is enabled in language options

#### Chillu characters not generating
**Solutions:**
1. **Check input method:**
   - Ensure using the Enhanced Malayalam IME
   - Type the correct input sequence (nR, lR, rR, LR)

2. **Font support:**
   - Ensure system has Malayalam font support
   - Try different fonts if characters appear incorrect

#### Application compatibility
**Solutions:**
1. **Compatible applications:**
   - Most Windows applications support TSF IMEs
   - Some older applications may require specific settings

2. **Administrator mode:**
   - Some applications may need to run as Administrator
   - Particularly for system-level text input

### Verification Steps

#### Check Installation Success
1. **Registry Check:**
   ```bash
   reg query "HKLM\SOFTWARE\Microsoft\CTF\TIP"
   ```

2. **DLL Registration:**
   ```bash
   regsvr32 /s MalayalamIME.dll
   ```

3. **Language Bar Check:**
   - Right-click language bar
   - Verify Malayalam IME is listed

#### Test Functionality
1. **Type test phrase:** "നമസ്തേ" (namaste)
2. **Test chillu:** Type "കന്നം" using "kanR"
3. **Verify conversion:** Check character recognition

## 🔄 Uninstallation

### Complete Removal
1. **Unregister DLL:**
   ```bash
   regsvr32 /u "C:\Windows\System32\MalayalamIME.dll"
   ```

2. **Remove DLL files:**
   ```bash
   del "C:\Windows\System32\MalayalamIME.dll"
   del "C:\Windows\SysWOW64\MalayalamIME.dll"  # If exists
   ```

3. **Clean registry (advanced users):**
   - Remove TIP entries under `HKLM\SOFTWARE\Microsoft\CTF\TIP`
   - Backup registry before making changes

4. **Remove from language options:**
   - Windows Settings → Time & Language → Language & region
   - Remove Malayalam IME from language options

### Using Uninstallation Script
```batch
@echo off
echo Uninstalling Enhanced Malayalam IME...
echo.

REM Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script must be run as Administrator
    pause
    exit /b 1
)

REM Unregister DLL
echo Unregistering MalayalamIME.dll...
regsvr32 /s /u "C:\Windows\System32\MalayalamIME.dll"

REM Remove DLL files
echo Removing DLL files...
del /q "C:\Windows\System32\MalayalamIME.dll"
del /q "C:\Windows\SysWOW64\MalayalamIME.dll"

echo.
echo Uninstallation completed.
echo Please restart your computer.
echo.
pause
```

## 📞 Support and Resources

### Getting Help
1. **Check Documentation:**
   - [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md) for development issues
   - [CHILLU_CHARACTERS.md](CHILLU_CHARACTERS.md) for character support details

2. **GitHub Issues:**
   - Report bugs at: `github.com/your-username/malayalam-ime-enhanced/issues`
   - Include system information and error details

3. **Community Support:**
   - Malayalam computing forums
   - Stack Overflow (tag: malayalam-ime)

### Additional Resources
- [Microsoft Text Services Framework Documentation](https://docs.microsoft.com/en-us/windows/win32/tsf/)
- [Malayalam Unicode Reference](https://unicode.org/charts/PDF/U0D00.pdf)
- [Windows IME Development Guide](https://docs.microsoft.com/en-us/windows/win32/tsf/text-services-framework)

---

**Enjoy Enhanced Malayalam Typing! 🎯✨**
