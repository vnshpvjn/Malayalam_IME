#pragma once

#define WIN32_LEAN_AND_MEAN
#define _UNICODE
#define UNICODE

#include <windows.h>
#include <windowsx.h>
#include <commctrl.h>
#include <imm.h>
#include <ole.h>
#include <ole2.h>
#include <oleauto.h>
#include <olectl.h>
#include <comdef.h>
#include <comutil.h>
#include <msctf.h>

// IME Specific definitions
#define WM_IME_COMPOSITION 0x010F
#define WM_IME_ENDCOMPOSITION 0x010E
#define WM_IME_NOTIFY 0x0282

// Helper macros
#define SAFE_RELEASE(p) do { if (p) { (p)->Release(); (p) = NULL; } } while(0)
#define SAFE_DELETE(p) do { if (p) { delete (p); (p) = NULL; } } while(0)
#define SAFE_DELETE_ARRAY(p) do { if (p) { delete[] (p); (p) = NULL; } } while(0)
