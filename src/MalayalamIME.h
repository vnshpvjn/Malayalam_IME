#pragma once

class CTransliterationEngine
{
public:
    struct SPhoneticMap
    {
        LPCWSTR pszInput;
        LPCWSTR pszOutput;
        int nInputLen;
    };

    static const SPhoneticMap m_aPhoneticMap[];

    static void Transliterate(const WCHAR* pszInput, WCHAR* pszOutput, int nOutputSize);
};

class CTextService : public ITfTextInputProcessor, public ITfDisplayAttributeProvider, public ITfThreadMgrEventSink
{
public:
    CTextService();
    virtual ~CTextService();

    // ITfTextInputProcessor
    STDMETHODIMP Activate(ITfThreadMgr *pThreadMgr, TfClientId tfClientId) override;
    STDMETHODIMP Deactivate() override;

    // ITfDisplayAttributeProvider
    STDMETHODIMP GetDisplayAttributeInfo(REFGUID guidDisplayAttribute, IEnumTfDisplayAttributeInfo **ppEnum) override;

    // ITfThreadMgrEventSink
    STDMETHODIMP OnInitDocumentMgr(ITfDocumentMgr *pDocMgr) override;
    STDMETHODIMP OnUninitDocumentMgr(ITfDocumentMgr *pDocMgr) override;
    STDMETHODIMP OnSetFocus(ITfDocumentMgr *pDocMgrFocus, ITfDocumentMgr *pDocMgrPrevFocus) override;

    static const GUID CLSID_MalayalamIME;
};
