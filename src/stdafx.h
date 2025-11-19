#pragma once

#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
#define _UNICODE
#define UNICODE
#define WINVER 0x0601
#define _WIN32_WINNT 0x0601

#include <windows.h>
#include <msctf.h>
#include <comdef.h>
#include <atlbase.h>
#include <atlcom.h>
#include <atlcoll.h>
#include <atlsafe.h>
#include <comutil.h>
#include <commctrl.h>
#include <shlwapi.h>
#include <strsafe.h>
#include <atlstr.h>
#include <atlwin.h>
#include <atlapp.h>

// Resource IDs
#define IDR_MALAYALAMIME                101
#define IDS_MALAYALAMIME_DESCRIPTION    102
#define IDS_MALAYALAMIME_NAME           103
#define IDS_MALAYALAMIME_TIPNAME        104
#define IDS_MALAYALAMIME_LANGBARNAME    105
