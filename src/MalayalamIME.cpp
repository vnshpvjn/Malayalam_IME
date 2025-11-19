#include "stdafx.h"
#include "MalayalamIME.h"

// Global variables
HINSTANCE g_hInst = NULL;

// Product definition
EXTERN_C const CLSID CLSID_TfScriptXor = {0x8f8b8f88, 0x8b8b, 0x8b88, {0x8b, 0x8b, 0x8b, 0x88, 0x88, 0x88, 0x88, 0x88}};

// Malayalam IME phonetic mapping with comprehensive chillu characters
const CTransliterationEngine::SPhoneticMap CTransliterationEngine::m_aPhoneticMap[] = {
    // -----------------------------
    // 1. VOWELS (സ്വരങ്ങൾ)
    // -----------------------------
    {L"a",   L"അ", 1},
    {L"aa",  L"ആ", 2}, {L"a",  L"ആ", 1}, // long form
    {L"i",   L"ഇ", 1},
    {L"ee",  L"ഈ", 2}, {L"ii", L"ഈ", 2},
    {L"e",   L"എ", 1},
    {L"ai",  L"ഐ", 2},
    {L"u",   L"ഉ", 1},
    {L"oo",  L"ഊ", 2}, {L"uu", L"ഊ", 2},
    {L"o",   L"ഒ", 1},
    {L"au",  L"ഔ", 2}, {L"ow", L"ഔ", 2},

    // -----------------------------
    // 2. CONSONANTS (വ്യഞ്ജനങ്ങൾ)
    // -----------------------------
    // Velars (കണ്ഠോഷ്ഠ്യങ്ങൾ)
    {L"k",   L"ക", 1},
    {L"kh",  L"ഖ", 2},
    {L"g",   L"ഗ", 1},
    {L"gh",  L"ഘ", 2},
    {L"ng",  L"ങ്ങ", 2},

    // Palatals (താലവ്യങ്ങൾ)
    {L"ch",  L"ച", 2},
    {L"chh", L"ഛ", 3},
    {L"j",   L"ജ", 1},
    {L"jh",  L"ഝ", 2},
    {L"ny",  L"ഞ്ഞ", 2},

    // Retroflexes (മൂർദ്ധന്യങ്ങൾ)
    {L"t",   L"ട", 1},
    {L"th",  L"ഠ", 2},
    {L"d",   L"ഡ", 1},
    {L"dh",  L"ഢ", 2},
    {L"n",   L"ണ", 1},

    // Dentals (ദന്ത്യങ്ങൾ)
    {L"th",  L"ത", 2},
    {L"dh",  L"ധ", 2},
    {L"d",   L"ദ", 1},
    {L"n",   L"ന", 1},

    // Labials (ഓഷ്ഠ്യങ്ങൾ)
    {L"p",   L"പ", 1},
    {L"ph",  L"ഫ", 2},
    {L"b",   L"ബ", 1},
    {L"bh",  L"ഭ", 2},
    {L"m",   L"മ", 1},

    // Approximants and others
    {L"y",   L"യ", 1},
    {L"r",   L"ര", 1},
    {L"l",   L"ല", 1},
    {L"v",   L"വ", 1},
    {L"w",   L"വ", 1},
    {L"s",   L"സ", 1},
    {L"sh",  L"ഷ", 2},
    {L"h",   L"ഹ", 1},
    {L"z",   L"ഴ", 1}, // Zha
    {L"f",   L"ഫ", 1},

    // -----------------------------
    // 3. CHILLU CHARACTERS (ചില്ലുകൾ)
    // -----------------------------
    {L"nR",  L"ന്ന", 2},  // Chillu Na (ന + ് + ന)
    {L"lR",  L"ല്ല", 2},  // Chillu La (ല + ് + ല)
    {L"rR",  L"ര്ര", 2},  // Chillu Ra (ര + ് + ര)
    {L"LR",  L"ള്ള", 2},  // Chillu Lla (ള + ് + ള)

    // -----------------------------
    // 4. SPECIAL COMBINATIONS
    // -----------------------------
    {L"ksha", L"ക്ഷ", 4},
    {L"tra",  L"ത്ര", 3},
    {L"dra",  L"ദ്ര", 3},
    {L"pra",  L"പ്ര", 3},
    {L"bra",  L"ബ്ര", 3},
    {L"gra",  L"ഗ്ര", 3},

    // -----------------------------
    // 5. PUNCTUATION
    // -----------------------------
    {L".", L".", 1},
    {L",", L",", 1},
    {L";", L";", 1},
    {L":", L":", 1},
    {L"!", L"!", 1},
    {L"?", L"?", 1},
    {L"\"", L"\"", 1},
    {L"'", L"'", 1},

    // -----------------------------
    // 6. NUMBERS
    // -----------------------------
    {L"0", L"൦", 1},
    {L"1", L"൧", 1},
    {L"2", L"൨", 1},
    {L"3", L"൩", 1},
    {L"4", L"൪", 1},
    {L"5", L"൫", 1},
    {L"6", L"൬", 1},
    {L"7", L"൭", 1},
    {L"8", L"൮", 1},
    {L"9", L"൯", 1}
};

// Transliteration engine implementation
void CTransliterationEngine::Transliterate(const WCHAR* pszInput, WCHAR* pszOutput, int nOutputSize)
{
    if (!pszInput || !pszOutput || nOutputSize <= 0)
        return;

    // Simple transliteration - enhanced for chillu characters
    WCHAR* pOut = pszOutput;
    int nRemaining = nOutputSize - 1; // Leave room for null terminator
    
    while (*pszInput && nRemaining > 0)
    {
        BOOL bFound = FALSE;
        
        // Try longest matches first (for compound characters)
        for (int nLen = 4; nLen >= 1 && !bFound; nLen--)
        {
            if (wcsnicmp(pszInput, L"ksha", 4) == 0 && nLen == 4)
            {
                if (nRemaining >= 2)
                {
                    wcscpy(pOut, L"ക്ഷ");
                    pOut += 2;
                    pszInput += 4;
                    nRemaining -= 2;
                    bFound = TRUE;
                }
            }
            else if (wcsnicmp(pszInput, L"tra", 3) == 0 && nLen == 3)
            {
                if (nRemaining >= 2)
                {
                    wcscpy(pOut, L"ത്ര");
                    pOut += 2;
                    pszInput += 3;
                    nRemaining -= 2;
                    bFound = TRUE;
                }
            }
            // Chillu characters
            else if (wcsnicmp(pszInput, L"nR", 2) == 0 && nLen == 2)
            {
                if (nRemaining >= 2)
                {
                    wcscpy(pOut, L"ന്ന");
                    pOut += 2;
                    pszInput += 2;
                    nRemaining -= 2;
                    bFound = TRUE;
                }
            }
            else if (wcsnicmp(pszInput, L"lR", 2) == 0 && nLen == 2)
            {
                if (nRemaining >= 2)
                {
                    wcscpy(pOut, L"ല്ല");
                    pOut += 2;
                    pszInput += 2;
                    nRemaining -= 2;
                    bFound = TRUE;
                }
            }
            else if (wcsnicmp(pszInput, L"rR", 2) == 0 && nLen == 2)
            {
                if (nRemaining >= 2)
                {
                    wcscpy(pOut, L"ര്ര");
                    pOut += 2;
                    pszInput += 2;
                    nRemaining -= 2;
                    bFound = TRUE;
                }
            }
            else if (wcsnicmp(pszInput, L"LR", 2) == 0 && nLen == 2)
            {
                if (nRemaining >= 2)
                {
                    wcscpy(pOut, L"ള്ള");
                    pOut += 2;
                    pszInput += 2;
                    nRemaining -= 2;
                    bFound = TRUE;
                }
            }
        }
        
        if (!bFound)
        {
            // Single character or fallback
            if (nRemaining > 0)
            {
                *pOut = *pszInput;
                pOut++;
                pszInput++;
                nRemaining--;
            }
        }
    }
    
    *pOut = L'\0';
}

// DLL Entry Point
BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        g_hInst = (HINSTANCE)hModule;
        break;
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

// COM Registration
STDAPI DllCanUnloadNow(void)
{
    return S_OK;
}

STDAPI DllGetClassObject(REFCLSID rclsid, REFIID riid, void** ppv)
{
    return CLASS_E_CLASSNOTAVAILABLE;
}

STDAPI DllRegisterServer(void)
{
    return S_OK;
}

STDAPI DllUnregisterServer(void)
{
    return S_OK;
}
