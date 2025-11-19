#include "stdafx.h"
#include "MalayalamIME.h"

// Component Category
const GUID CATID_TextService = {0x4F3B5AF1, 0x8F3D, 0x4A99, {0xBD, 0xA5, 0x2E, 0x1A, 0x3D, 0x4E, 0x6B, 0x8F}};

STDAPI DllRegisterServer(void)
{
    return S_OK;
}

STDAPI DllUnregisterServer(void)
{
    return S_OK;
}

// Component registration helper
class CIMEClassFactory : public IClassFactory
{
public:
    STDMETHODIMP CreateInstance(IUnknown* pUnkOuter, REFIID riid, void** ppvObject) override
    {
        if (pUnkOuter != NULL)
            return CLASS_E_NOAGGREGATION;

        CTextService* pService = new CTextService();
        if (!pService)
            return E_OUTOFMEMORY;

        HRESULT hr = pService->QueryInterface(riid, ppvObject);
        if (FAILED(hr))
            delete pService;

        return hr;
    }

    STDMETHODIMP LockServer(BOOL fLock) override
    {
        return S_OK;
    }
};

// Simple class factory
static CIMEClassFactory g_ClassFactory;

STDAPI DllGetClassObject(REFCLSID rclsid, REFIID riid, void** ppv)
{
    if (rclsid != CLSID_MalayalamIME)
        return CLASS_E_CLASSNOTAVAILABLE;

    return g_ClassFactory.QueryInterface(riid, ppv);
}
