# 🔧 Build Instructions - Enhanced Malayalam IME

## 📋 Prerequisites

### Required Software
1. **Visual Studio 2022** (Community, Professional, or Enterprise)
   - Download from: https://visualstudio.microsoft.com/downloads/
   - Include "Desktop development with C++" workload

2. **Windows 10 SDK** (latest version)
   - Installed automatically with Visual Studio 2022

3. **Git** (optional, for cloning repository)

### Visual Studio Components
Ensure these components are installed:
- MSVC v143 compiler toolset
- Windows 10/11 SDK (latest)
- CMake tools for Windows
- ATL (Active Template Library)

## 🚀 Local Build Process

### Method 1: Visual Studio IDE (Recommended)

1. **Open Solution**
   ```
   - Double-click: src/MalayalamIME.sln
   - Or: File → Open → Project/Solution → Browse to MalayalamIME.sln
   ```

2. **Select Build Configuration**
   ```
   Configuration: Release
   Platform: x64
   ```

3. **Build Project**
   ```
   - Press Ctrl+Shift+B (Build Solution)
   - Or: Build → Build Solution (F6)
   - Or: Right-click solution → Build
   ```

4. **Verify Build Output**
   ```
   - Location: src/Release/MalayalamIME.dll
   - Size: Approximately 50-100 KB
   - Check for no errors in Output window
   ```

### Method 2: Command Line Build

1. **Open Developer Command Prompt**
   ```
   - Start Menu → Visual Studio 2022 → Developer Command Prompt for VS 2022
   ```

2. **Navigate to Source Directory**
   ```bash
   cd path\to\your\repository\src
   ```

3. **Clean Previous Builds**
   ```bash
   rmdir /s /q Release
   mkdir Release
   ```

4. **Compile**
   ```bash
   cl /LD MalayalamIME.cpp Register.cpp /FoRelease\ /DWIN32_LEAN_AND_MEAN /DUNICODE /D_UNICODE /link /DLL /OUT:Release\MalayalamIME.dll
   ```

### Method 3: Using Provided Scripts

1. **Using Build Script**
   ```bash
   cd scripts
   build-ime.bat
   ```

2. **Alternative Minimal Build**
   ```bash
   build-minimal.bat
   ```

## 🛠️ Build Troubleshooting

### Common Issues

#### Error: "Cannot find stdafx.h"
**Solution:**
```
- Ensure stdafx.h is in the same directory as MalayalamIME.cpp
- Check project settings: Configuration Properties → C/C++ → Precompiled Headers
- Set to "Use (/Yu)" for stdafx.h
```

#### Error: "Cannot find vcvars64.bat"
**Solution:**
```
- Reinstall Visual Studio 2022 with C++ workload
- Restart computer after installation
- Use Developer Command Prompt for VS 2022
```

#### Error: "Cannot find atldbch.h" or ATL headers
**Solution:**
```
- Install ATL components in Visual Studio Installer
- Go to: Visual Studio Installer → Modify → Individual Components
- Check: "ATL (Active Template Library)"
- Click Modify
```

#### Error: "Cannot find Windows SDK headers"
**Solution:**
```
- Install latest Windows 10/11 SDK
- Check: Control Panel → Programs → Programs and Features
- Find Visual Studio 2022 → Modify
- Ensure Windows SDK is selected
```

### Build Verification

After successful build, verify:

1. **File Exists**
   ```
   src/Release/MalayalamIME.dll
   ```

2. **File Size**
   ```
   Should be between 50-200 KB
   ```

3. **Dependencies**
   ```
   Use Dependency Walker to check for missing DLLs:
   - Download: https://dependencywalker.com/
   - Open: src/Release/MalayalamIME.dll
   ```

## 📁 Build Output

### Successful Build Results
```
src/
├── Release/
│   ├── MalayalamIME.dll     ← Final compiled IME
│   ├── MalayalamIME.lib     ← Import library
│   └── MalayalamIME.obj     ← Object files
└── [source files...]
```

### File Descriptions
- **MalayalamIME.dll** - Main IME DLL for distribution
- **MalayalamIME.lib** - Import library for linking
- **MalayalamIME.obj** - Intermediate object files

## 🔄 Development Workflow

### For Contributors

1. **Fork Repository**
   ```
   - Click "Fork" on GitHub
   - Clone your fork locally
   ```

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**
   ```
   - Edit source files in src/
   - Test locally with Visual Studio
   ```

4. **Test Build**
   ```
   - Ensure Release build succeeds
   - Verify no warnings or errors
   ```

5. **Submit Pull Request**
   ```
   - Push to your fork
   - Create Pull Request on GitHub
   ```

### Code Style Guidelines
- Use consistent indentation (4 spaces)
- Follow Microsoft C++ coding standards
- Add comments for complex logic
- Test phonetic mappings thoroughly

## 🚀 GitHub Actions Alternative

For automatic cloud builds:

1. **Push to Repository**
   ```bash
   git add .
   git commit -m "Your changes"
   git push origin main
   ```

2. **Check GitHub Actions**
   ```
   - Go to: github.com/your-username/malayalam-ime-enhanced/actions
   - Click on latest workflow run
   - Download MalayalamIME-Enhanced artifact
   ```

## 📞 Support

If you encounter build issues:

1. **Check Prerequisites** - Ensure all requirements are installed
2. **Review Error Messages** - Look for specific missing components
3. **Check Documentation** - See INSTALL_GUIDE.md and CHILLU_CHARACTERS.md
4. **Create Issue** - Report on GitHub with error details and system info

### System Information to Include
```
- Windows version (Windows 10/11)
- Visual Studio version (2022)
- Build configuration (Release/x64)
- Complete error message
```

## ✅ Build Checklist

Before submitting or distributing:

- [ ] Release build succeeds without errors
- [ ] MalayalamIME.dll is generated in src/Release/
- [ ] File size is reasonable (50-200 KB)
- [ ] No missing dependencies in Dependency Walker
- [ ] Phonetic mappings work correctly
- [ ] Chillu characters generate properly
- [ ] Installation script works (scripts/install-ime.bat)

---

**Happy Building! 🎯**
