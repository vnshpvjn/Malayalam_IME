# 🎯 Enhanced Malayalam IME

[![Build Status](https://github.com/your-username/malayalam-ime-enhanced/workflows/Build%20Malayalam%20IME/badge.svg)](https://github.com/your-username/malayalam-ime-enhanced/actions)

A powerful and enhanced Malayalam Input Method Editor (IME) with comprehensive support for **150+ phonetic mappings** including **advanced chillu character support**.

## ✨ Key Features

### 🎯 Enhanced Phonetic Mapping
- **150+ comprehensive mappings** covering all Malayalam characters
- **Smart transliteration engine** for natural Malayalam input
- **Intelligent context awareness** for optimal character selection

### 🔤 Advanced Chillu Character Support
- **ന്ന** (chillu na) - Automatic with `nR` input
- **ല്ല** (chillu la) - Automatic with `lR` input  
- **ര്ര** (chillu ra) - Automatic with `rR` input
- **ള്ള** (chillu lla) - Automatic with `LR` input
- **Context-aware generation** for proper usage

### 🏗️ Professional Build System
- **GitHub Actions** - Automatic cloud compilation
- **Visual Studio 2022** - Latest build tools support
- **Multiple fallback methods** - Ensures successful builds
- **Artifact download** - Ready-to-use compiled DLL

## 🚀 Quick Start

### Method 1: Download Pre-built DLL (Recommended)
1. Go to [GitHub Actions](https://github.com/your-username/malayalam-ime-enhanced/actions)
2. Click on the latest successful workflow run
3. Download `MalayalamIME-Enhanced` artifact
4. Extract `MalayalamIME.dll`

### Method 2: Build from Source
1. Clone the repository
2. Follow [Build Instructions](docs/BUILD_INSTRUCTIONS.md)
3. Or use GitHub Actions for automatic building

### Method 3: Installation Scripts
1. Use provided batch scripts in `scripts/` folder
2. Run as Administrator for system integration

## 📁 Repository Structure

```
malayalam-ime-enhanced/
├── .github/workflows/build.yml    ← Working GitHub Actions workflow
├── src/                           ← Source code files
│   ├── MalayalamIME.cpp          ← Enhanced IME implementation
│   ├── MalayalamIME.h
│   ├── Register.cpp
│   └── [other Visual Studio files]
├── docs/                          ← Comprehensive documentation
│   ├── BUILD_INSTRUCTIONS.md      ← Local build guide
│   ├── INSTALL_GUIDE.md          ← Installation instructions
│   └── CHILLU_CHARACTERS.md      ← Chillu support details
├── scripts/                       ← Installation scripts
│   ├── install-ime.bat
│   └── verify-setup.bat
└── README.md                      ← This file
```

## 📚 Documentation

- **[Installation Guide](docs/INSTALL_GUIDE.md)** - Complete setup instructions
- **[Build Instructions](docs/BUILD_INSTRUCTIONS.md)** - Local development guide
- **[Chillu Characters](docs/CHILLU_CHARACTERS.md)** - Enhanced character support details
- **[Source Documentation](src/README.md)** - Code structure and files

## 🛠️ Build Requirements

- **Windows 10/11** (x64)
- **Visual Studio 2022** (Community/Professional/Enterprise)
- **C++ Build Tools** with ATL support
- **Windows 10 SDK** (latest version)

## 🎯 Chillu Character Examples

| Input | Output | Description |
|-------|--------|-------------|
| `nR`  | ന്ന    | Chillu na (ന + ്ന) |
| `lR`  | ല്ല    | Chillu la (ല + ്ല) |
| `rR`  | ര്ര    | Chillu ra (ര + ്ര) |
| `LR`  | ള്ള    | Chillu lla (ള + ്ള) |

## 🏗️ Build Status

The repository uses GitHub Actions for continuous integration:
- ✅ **Automatic compilation** on every push
- ✅ **Visual Studio 2022** setup
- ✅ **Multiple compilation methods** for reliability
- ✅ **Artifact generation** for easy distribution

## 📞 Support

For issues, questions, or contributions:
1. Check the [documentation](docs/) first
2. Search existing [GitHub Issues](https://github.com/your-username/malayalam-ime-enhanced/issues)
3. Create a new issue with detailed information

## 📄 License

This project is licensed under the MIT License - see the source files for details.

---

**Built with ❤️ for the Malayalam computing community**
