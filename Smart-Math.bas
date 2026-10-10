#include "windows.bi"
#include "crt.bi"
#include "Inc\PluginInterface.bi"
#include "Inc\Scintilla.bi"
#include "Inc\MathParser.bi"
#include "Inc\ConfigManager.bi"
#include "Inc\Smart-Math-Format.bi"
#include "Inc\Smart-Math-CopyNormalize.bi"
#include "Inc\Smart-Math-About.bi"

const PLUGIN_NAME = wstr("Smart Math")
const DOCUMENTATION_FILE_NAME = wstr("SmartMath.md")
const UDL_NAME = wstr("SmartMath")
const UDL_NAME_DARK = wstr("SmartMath (dark mode)")
const UDL_FILE_NAME = wstr("userDefineLangs\SmartMath.udl.xml")
const UDL_FILE_NAME_DARK = wstr("userDefineLangs\SmartMath_Dark.udl.xml")
const AUTOCOMPL_FILE_NAME = wstr("autoCompletion\SmartMath.xml")
const TB_BMP_ID = 100
const TB_ICON_LIGHT_ID = 101
const TB_ICON_DARK_ID = 102
const IDX_TOGGLEPLUGIN = 0
const IDX_SEPARATOR1 = 1
const IDX_PREC0 = 2
const IDX_USETHOUSANDS = 11
const IDX_COMPLEX = 12
const IDX_SHOWERRORS = 13
const IDX_SYNTAXHIGHLIGHT = 14
const IDX_SEPARATOR2 = 15
const IDX_DOCUMENTATION = 16
const IDX_ABOUT = 17
const NB_FUNC = 18
const STYLE_BRACEBAD = 35
const ANN_STYLE_DEFAULT = 0
const ANN_STYLE_ERROR = 1
const EOLANNOTATION_STANDARD = 1
const EOLANNOTATION_HIDDEN = 0
#ifndef CF_UNICODETEXT
const CF_UNICODETEXT = 13
#endif
#ifndef CP_UTF8
const CP_UTF8 = 65001
#endif

dim shared as HINSTANCE hInst
dim shared as NppData nppData
dim shared as FuncItem funcItems(NB_FUNC - 1)
dim shared as boolean isNppClosing = FALSE
dim shared as WNDPROC oldSciProc = 0
dim shared as boolean g_cacheReady = FALSE
dim shared as string g_cachePath
dim shared as integer g_smartMathUdlCmdId = 0
dim shared as wstring * MAX_PATH nppRootDir ' set by initCommonPaths()
dim shared as wstring * MAX_PATH smartmathDllDir ' set by initCommonPaths()
dim shared as wstring * MAX_PATH documentationFilePath ' set by initCommonPaths()
redim shared g_annText(0 to 0) as string
redim shared g_cachedLineText(0 to 0) as string
redim shared g_cachedResult(0 to 0) as string

declare sub UpdateAnnotations(byval forceFull as boolean = FALSE, byval startLine as integer = -1)
declare function getSmartMathUdlId() as integer
declare sub ApplySmartMathUDL()
declare sub SetPrecision(p as integer, byval saveConfig as boolean)
declare function CopyResultForLine(byval hScintilla as HWND, byval lineIdx as integer) as boolean
declare function SciSubclassProc(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

sub DllLoad() constructor
  const cFlags = GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS or GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT
  GetModuleHandleEx(cFlags, cast(any ptr, @DllLoad), @hInst)
end sub

function getSmartMathUdlId() as integer
  dim as integer baseId = 0, nUdl, i, cmdId
  dim as boolean isDarkMode
  dim as wstring * 256 itemName
  dim as HMENU hMenu = GetMenu(nppData._nppHandle)
  if hMenu = 0 then return 0

  isDarkMode = SendMessage(nppData._nppHandle, NPPM_ISDARKMODEENABLED, 0, 0) <> 0
  nUdl = SendMessage(nppData._nppHandle, NPPM_GETNBUSERLANG, 0, cast(LPARAM, @baseId))
  if nUdl <= 0 then return 0

  for i = 1 to nUdl
    cmdId = baseId + i
    if GetMenuStringW(hMenu, cmdId, cast(LPWSTR, @itemName), 255, MF_BYCOMMAND) > 0 then
      if isDarkMode then
        if itemName = UDL_NAME_DARK then return cmdId
      else
        if itemName = UDL_NAME then return cmdId
      end if
    end if
  next i

  return 0
end function

private sub initCommonPaths(hNppWnd as HWND)
  dim as integer iLen, i
  dim as ushort ch

  nppRootDir[0] = 0
  SendMessage(hNppWnd, NPPM_GETNPPDIRECTORY, MAX_PATH, cast(LPARAM, @nppRootDir))
  iLen = Len(nppRootDir)
  if iLen > 0 then
    ch = nppRootDir[iLen - 1]
    if ch = asc("\") orelse ch = asc("/") then
      nppRootDir[iLen - 1] = 0 ' remove the trailing slash
    end if
  end if

  smartmathDllDir[0] = 0
  GetModuleFileNameW(hInst, @smartmathDllDir, MAX_PATH)
  iLen = Len(smartmathDllDir)
  for i = iLen - 1 to 0 step -1
    ch = smartmathDllDir[i]
    if ch = asc("\") orelse ch = asc("/") then
      smartmathDllDir[i] = 0 ' truncate at the last slash
      exit for
    end if
  next i

  documentationFilePath = smartmathDllDir & "\doc\" & DOCUMENTATION_FILE_NAME
  if GetFileAttributesW(@documentationFilePath) <> INVALID_FILE_ATTRIBUTES then exit sub

  documentationFilePath = smartmathDllDir & "\" & DOCUMENTATION_FILE_NAME
  if GetFileAttributesW(@documentationFilePath) <> INVALID_FILE_ATTRIBUTES then exit sub

  documentationFilePath = nppRootDir & "\plugins\doc\" & DOCUMENTATION_FILE_NAME
end sub

private sub verifySyntaxFilesExist()
  dim as boolean isUdlMissed = false
  dim as boolean isUdlUnderDllDir = false
  dim as boolean isUdlDarkMissed = false
  dim as boolean isUdlDarkUnderDllDir = false
  dim as boolean isAutoComplMissed = false
  dim as boolean isAutoComplUnderDllDir = false
  dim as wstring * MAX_PATH filePath

  filePath = nppRootDir & "\" & UDL_FILE_NAME
  if GetFileAttributesW(@filePath) = INVALID_FILE_ATTRIBUTES then
    isUdlMissed = true
    filePath = smartmathDllDir & "\" & UDL_FILE_NAME
    if GetFileAttributesW(@filePath) <> INVALID_FILE_ATTRIBUTES then isUdlUnderDllDir = true
  end if

  filePath = nppRootDir & "\" & UDL_FILE_NAME_DARK
  if GetFileAttributesW(@filePath) = INVALID_FILE_ATTRIBUTES then
    isUdlDarkMissed = true
    filePath = smartmathDllDir & "\" & UDL_FILE_NAME_DARK
    if GetFileAttributesW(@filePath) <> INVALID_FILE_ATTRIBUTES then isUdlDarkUnderDllDir = true
  end if

  filePath = nppRootDir & "\" & AUTOCOMPL_FILE_NAME
  if GetFileAttributesW(@filePath) = INVALID_FILE_ATTRIBUTES then
    isAutoComplMissed = true
    filePath = smartmathDllDir & "\" & AUTOCOMPL_FILE_NAME
    if GetFileAttributesW(@filePath) <> INVALID_FILE_ATTRIBUTES then isAutoComplUnderDllDir = true
  end if

  if isUdlMissed orelse isUdlDarkMissed orelse isAutoComplMissed then
    ' some syntax files are missing, show a warning message
    dim as wstring * (MAX_PATH*6) msg
    msg[0] = 0
    msg &= "Syntax files for " & PLUGIN_NAME & " are missing." & wchr(13, 10) & _
           "To enable Syntax Highlighting, place the following files" & wchr(13, 10) & _
           "inside """ & nppRootDir & """:" & wchr(13, 10)

    if isUdlMissed then
      msg &= wchr(13, 10) & UDL_FILE_NAME
    end if
    if isUdlDarkMissed then
      msg &= wchr(13, 10) & UDL_FILE_NAME_DARK
    end if
    if isAutoComplMissed then
      msg &= wchr(13, 10) & AUTOCOMPL_FILE_NAME
    end if

    if isUdlUnderDllDir orelse isUdlDarkUnderDllDir orelse isAutoComplUnderDllDir then
      msg &= wchr(13, 10, 13, 10) & "Please copy these files from:" & wchr(13, 10) & _
             wchr(13, 10) & smartmathDllDir & "\"
    end if

    MessageBoxW(nppData._nppHandle, @msg, PLUGIN_NAME, MB_OK or MB_ICONWARNING)
  end if
end sub

sub ApplySmartMathUDL()
  if g_smartMathUdlCmdId = 0 then exit sub
  SendMessage(nppData._nppHandle, NPPM_MENUCOMMAND, 0, g_smartMathUdlCmdId)
end sub

function FindMyPluginMenu() as HMENU
  dim as HMENU hMain = GetMenu(nppData._nppHandle)
  dim as integer i, j, k
  dim as HMENU hSub, hDeep
  dim as integer targetID = funcItems(0)._cmdID

  for i = 0 to GetMenuItemCount(hMain) - 1
    hSub = GetSubMenu(hMain, i)
    if hSub <> 0 then
      for j = 0 to GetMenuItemCount(hSub) - 1
        hDeep = GetSubMenu(hSub, j)
        if hDeep <> 0 then
          for k = 0 to GetMenuItemCount(hDeep) - 1
            if GetMenuItemID(hDeep, k) = targetID then
              return hDeep
            end if
          next k
        end if
      next j
    end if
  next i
  return 0
end function

sub OrganizeMenu()
  dim as HMENU hMyMenu = FindMyPluginMenu()
  if hMyMenu = 0 then exit sub

  dim as HMENU hSubMenuDecimal = CreatePopupMenu()
  dim as integer i

  for i = 0 to 8
    RemoveMenu(hMyMenu, funcItems(IDX_PREC0 + i)._cmdID, MF_BYCOMMAND)
    AppendMenu(hSubMenuDecimal, MF_STRING, funcItems(IDX_PREC0 + i)._cmdID, wstr(str(i)))
  next i

  dim as integer nItems = GetMenuItemCount(hMyMenu)
  dim as integer cmdPos = -1, insertPos = -1
  dim as integer cmdId = funcItems(IDX_USETHOUSANDS)._cmdID
  for i = 0 to nItems - 1
    if GetMenuItemID(hMyMenu, i) = cmdId then
      cmdPos = i
      exit for
    end if
  next i
  if cmdPos > 0 then
    insertPos = cmdPos
  elseif nItems > 0 then
    insertPos = nItems
  end if
  if insertPos >= 0 then
    InsertMenu(hMyMenu, insertPos, MF_BYPOSITION or MF_STRING or MF_POPUP, cast(UINT_PTR, hSubMenuDecimal), wstr("Decimal Places"))
  else
    AppendMenu(hMyMenu, MF_STRING or MF_POPUP, cast(UINT_PTR, hSubMenuDecimal), wstr("Decimal Places"))
  end if
  ModifyMenu(hMyMenu, funcItems(IDX_SEPARATOR1)._cmdID, MF_BYCOMMAND or MF_SEPARATOR, funcItems(IDX_SEPARATOR1)._cmdID, NULL)
  ModifyMenu(hMyMenu, funcItems(IDX_SEPARATOR2)._cmdID, MF_BYCOMMAND or MF_SEPARATOR, funcItems(IDX_SEPARATOR2)._cmdID, NULL)
  DrawMenuBar(nppData._nppHandle)
  SetPrecision(Config_GetDecimalPlaces(), FALSE)
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_USETHOUSANDS)._cmdID, iif(Config_GetUseThousandsSep(), 1, 0))
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_COMPLEX)._cmdID, iif(Config_GetSupportComplexNumbers(), 1, 0))
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_SHOWERRORS)._cmdID, iif(Config_GetShowErrors(), 1, 0))
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_SYNTAXHIGHLIGHT)._cmdID, iif(Config_GetSyntaxHighlight(), 1, 0))
end sub

function GetCurrentPath() as string
  dim as integer bufferID
  dim as wstring * (MAX_PATH*2) fullPath
  bufferID = SendMessage(nppData._nppHandle, NPPM_GETCURRENTBUFFERID, 0, 0)
  SendMessage(nppData._nppHandle, NPPM_GETFULLPATHFROMBUFFERID, bufferID, cast(LPARAM, @fullPath))
  return str(fullPath)
end function

function GetCurrentScintilla() as HWND
  dim as integer iCurView
  if nppData._nppHandle = 0 then return 0
  iCurView = SendMessage(nppData._nppHandle, NPPM_GETCURRENTVIEW, 0, 0)
  if iCurView = 0 then return nppData._scintillaMainHandle
  return nppData._scintillaSecondHandle
end function

function GetScintillaLineText(byval hScintilla as HWND, byval lineIdx as integer) as string
  dim as integer lineBufLen, iStart, iEnd, lineContentLen
  dim as zstring ptr pLineBuf
  dim as string sLine

  lineBufLen = SendMessage(hScintilla, SCI_LINELENGTH, lineIdx, 0)
  if lineBufLen <= 0 then return ""
  iStart = SendMessage(hScintilla, SCI_POSITIONFROMLINE, lineIdx, 0)
  iEnd = SendMessage(hScintilla, SCI_GETLINEENDPOSITION, lineIdx, 0)
  lineContentLen = iEnd - iStart

  pLineBuf = callocate(lineBufLen + 1)
  SendMessage(hScintilla, SCI_GETLINE, lineIdx, cast(LPARAM, pLineBuf))
  if lineContentLen < lineBufLen then
    pLineBuf[lineContentLen] = 0
  else
    pLineBuf[lineBufLen] = 0
  end if
  sLine = *pLineBuf
  deallocate(pLineBuf)
  return sLine
end function

function DisplayTextFromEval(byref sLine as string) as string
  dim as RawResult raw
  dim as string sRes, sErr
  if Parser_TryEvaluateExRaw(sLine, raw) then
    sRes = FormatRawEvaluationResult(raw)
    if Len(sRes) > 0 then return sRes
  else
    sErr = Parser_GetLastError()
    if Len(sErr) = 0 then return ""
    if Config_GetShowErrors() orelse Parser_IsFunctionHintError(sErr) then
      return SMARTMATH_ERROR_PREFIX & sErr
    end if
  end if
  return ""
end function

function GetEolAnnotationText(byval hScintilla as HWND, byval lineIdx as integer) as string
  dim as integer nLen, nGot, nAlloc
  dim as zstring ptr pBuf
  dim as string sText
  if (hScintilla = 0) orelse (lineIdx < 0) then return ""
  nLen = SendMessage(hScintilla, SCI_EOLANNOTATIONGETTEXT, lineIdx, 0)
  if nLen < 0 then nLen = 0
  if nLen > 65536 then nLen = 65536
  nAlloc = nLen
  if nAlloc < 1 then nAlloc = 4096
  pBuf = callocate(nAlloc + 1)
  if pBuf = 0 then return ""
  nGot = SendMessage(hScintilla, SCI_EOLANNOTATIONGETTEXT, lineIdx, cast(LPARAM, pBuf))
  if nGot <= 0 then
    deallocate(pBuf)
    return ""
  end if
  if nGot > nAlloc then nGot = nAlloc
  pBuf[nGot] = 0
  sText = *pBuf
  deallocate(pBuf)
  return sText
end function

function LineFromClientY(byval hScintilla as HWND, byval y as integer) as integer
  dim as integer lineH, firstVis, firstDoc, firstPos, y0, vis, nLines, lineIdx
  if hScintilla = 0 then return 0
  nLines = SendMessage(hScintilla, SCI_GETLINECOUNT, 0, 0)
  if nLines <= 0 then return 0
  lineH = SendMessage(hScintilla, SCI_TEXTHEIGHT, 0, 0)
  if lineH < 1 then lineH = 1
  firstVis = SendMessage(hScintilla, SCI_GETFIRSTVISIBLELINE, 0, 0)
  firstDoc = SendMessage(hScintilla, SCI_DOCLINEFROMVISIBLE, firstVis, 0)
  firstPos = SendMessage(hScintilla, SCI_POSITIONFROMLINE, firstDoc, 0)
  y0 = SendMessage(hScintilla, SCI_POINTYFROMPOSITION, 0, firstPos)
  vis = firstVis + (y - y0) \ lineH
  if vis < 0 then vis = 0
  lineIdx = SendMessage(hScintilla, SCI_DOCLINEFROMVISIBLE, vis, 0)
  if lineIdx < 0 then lineIdx = 0
  if lineIdx >= nLines then lineIdx = nLines - 1
  return lineIdx
end function

function TryCopyResultAtClientPoint(byval hScintilla as HWND, byval x as integer, byval y as integer) as boolean
  dim as integer lineIdx, lineEnd, xLineEnd, caretPos
  if hScintilla = 0 then return FALSE
  lineIdx = LineFromClientY(hScintilla, y)
  lineEnd = SendMessage(hScintilla, SCI_GETLINEENDPOSITION, lineIdx, 0)
  xLineEnd = SendMessage(hScintilla, SCI_POINTXFROMPOSITION, 0, lineEnd)
  if x < xLineEnd then return FALSE
  if CopyResultForLine(hScintilla, lineIdx) = FALSE then return FALSE
  caretPos = SendMessage(hScintilla, SCI_GETCURRENTPOS, 0, 0)
  SendMessage(hScintilla, SCI_SETEMPTYSELECTION, caretPos, 0)
  return TRUE
end function

function SciSubclassProc(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
  if uMsg = WM_LBUTTONDBLCLK then
    if Config_IsFileEnabled(GetCurrentPath()) then
      dim as integer x = cint(cshort(loword(lParam)))
      dim as integer y = cint(cshort(hiword(lParam)))
      if TryCopyResultAtClientPoint(hWnd, x, y) then return 0
    end if
  end if
  if oldSciProc <> 0 then
    return CallWindowProc(oldSciProc, hWnd, uMsg, wParam, lParam)
  end if
  return DefWindowProc(hWnd, uMsg, wParam, lParam)
end function

sub HookScintilla(byval hSci as HWND)
  dim as WNDPROC cur, prev
  if hSci = 0 then exit sub
  cur = cast(WNDPROC, GetWindowLongPtr(hSci, GWLP_WNDPROC))
  if cur = @SciSubclassProc then exit sub
  prev = cast(WNDPROC, SetWindowLongPtr(hSci, GWLP_WNDPROC, cast(LONG_PTR, @SciSubclassProc)))
  if oldSciProc = 0 then oldSciProc = prev
end sub

sub EnsureSciHooked()
  HookScintilla(nppData._scintillaMainHandle)
  HookScintilla(nppData._scintillaSecondHandle)
end sub

sub UnhookSci()
  if oldSciProc = 0 then exit sub
  if nppData._scintillaMainHandle <> 0 then
    if cast(WNDPROC, GetWindowLongPtr(nppData._scintillaMainHandle, GWLP_WNDPROC)) = @SciSubclassProc then
      SetWindowLongPtr(nppData._scintillaMainHandle, GWLP_WNDPROC, cast(LONG_PTR, oldSciProc))
    end if
  end if
  if nppData._scintillaSecondHandle <> 0 then
    if cast(WNDPROC, GetWindowLongPtr(nppData._scintillaSecondHandle, GWLP_WNDPROC)) = @SciSubclassProc then
      SetWindowLongPtr(nppData._scintillaSecondHandle, GWLP_WNDPROC, cast(LONG_PTR, oldSciProc))
    end if
  end if
  oldSciProc = 0
end sub

function CopyTextToClipboard(byref sText as string) as boolean
  dim as integer cch, cbBytes
  dim as HGLOBAL hMem
  dim as wstring ptr pMem
  if Len(sText) = 0 then return FALSE
  if OpenClipboard(nppData._nppHandle) = FALSE then return FALSE
  EmptyClipboard()

  cch = MultiByteToWideChar(CP_UTF8, 0, strptr(sText), Len(sText), 0, 0)
  if cch <= 0 then
    CloseClipboard()
    return FALSE
  end if
  cbBytes = (cch + 1) * sizeof(wstring)
  hMem = GlobalAlloc(GMEM_MOVEABLE, cbBytes)
  if hMem = 0 then
    CloseClipboard()
    return FALSE
  end if
  pMem = cast(wstring ptr, GlobalLock(hMem))
  if pMem = 0 then
    GlobalFree(hMem)
    CloseClipboard()
    return FALSE
  end if
  MultiByteToWideChar(CP_UTF8, 0, strptr(sText), Len(sText), pMem, cch)
  pMem[cch] = 0
  GlobalUnlock(hMem)
  if SetClipboardData(CF_UNICODETEXT, hMem) = 0 then
    GlobalFree(hMem)
    CloseClipboard()
    return FALSE
  end if
  CloseClipboard()
  return TRUE
end function

sub EnsureErrorAnnotationStyle(byval hScintilla as HWND)
  dim as integer styleOffset, badFore
  if hScintilla = 0 then exit sub
  styleOffset = SendMessage(hScintilla, SCI_EOLANNOTATIONGETSTYLEOFFSET, 0, 0)
  if styleOffset = 0 then
    styleOffset = SendMessage(hScintilla, SCI_ALLOCATEEXTENDEDSTYLES, 2, 0)
    if styleOffset > 0 then
      SendMessage(hScintilla, SCI_EOLANNOTATIONSETSTYLEOFFSET, styleOffset, 0)
    end if
  end if
  if styleOffset > 0 then
    badFore = SendMessage(hScintilla, SCI_STYLEGETFORE, STYLE_BRACEBAD, 0)
    SendMessage(hScintilla, SCI_STYLESETFORE, styleOffset + ANN_STYLE_ERROR, badFore)
  end if
end sub

function AnnotationStyleForText(byref sText as string) as integer
  dim as string sErr
  if Left(sText, Len(SMARTMATH_ERROR_PREFIX)) <> SMARTMATH_ERROR_PREFIX then return ANN_STYLE_DEFAULT
  sErr = Mid(sText, Len(SMARTMATH_ERROR_PREFIX) + 1)
  if Parser_IsFunctionHintError(sErr) then return ANN_STYLE_DEFAULT
  return ANN_STYLE_ERROR
end function

function CopyResultForLine(byval hScintilla as HWND, byval lineIdx as integer) as boolean
  if not g_cacheReady then return FALSE
  dim as string sRes, sCopy
  if (lineIdx >= 0) andalso (lineIdx <= ubound(g_annText)) then
    sRes = g_annText(lineIdx)
  end if
  if Len(Trim(sRes)) = 0 then sRes = GetEolAnnotationText(hScintilla, lineIdx)
  if Len(Trim(sRes)) = 0 then return FALSE
  sCopy = NormalizeCopiedResult(sRes)
  if Len(sCopy) = 0 then return FALSE
  return CopyTextToClipboard(sCopy)
end function

sub SetLineAnnotation(byval hScintilla as HWND, byval lineIdx as integer, byval padding as integer, byref sText as string)
  dim as string sResText = space(padding) & sText
  dim as integer annStyle = AnnotationStyleForText(sText)
  if (lineIdx >= 0) andalso (lineIdx <= ubound(g_annText)) then
    g_annText(lineIdx) = sResText
    SendMessage(hScintilla, SCI_EOLANNOTATIONSETTEXT, lineIdx, cast(LPARAM, strptr(sResText)))
  else
    SendMessage(hScintilla, SCI_EOLANNOTATIONSETTEXT, lineIdx, cast(LPARAM, strptr(sResText)))
  end if
  if (annStyle = ANN_STYLE_ERROR) andalso _
     (SendMessage(hScintilla, SCI_EOLANNOTATIONGETSTYLEOFFSET, 0, 0) = 0) then
    annStyle = ANN_STYLE_DEFAULT
  end if
  SendMessage(hScintilla, SCI_EOLANNOTATIONSETSTYLE, lineIdx, annStyle)
end sub

sub ClearLineAnnotation(byval hScintilla as HWND, byval lineIdx as integer)
  if (lineIdx >= 0) andalso (lineIdx <= ubound(g_annText)) then
    g_annText(lineIdx) = ""
  end if
  SendMessage(hScintilla, SCI_EOLANNOTATIONSETTEXT, lineIdx, 0)
end sub

sub InvalidateAnnotationCache()
  g_cacheReady = FALSE
  g_cachePath = ""
end sub

sub UpdateAnnotations(byval forceFull as boolean = FALSE, byval startLine as integer = -1)
  dim as string curPath = GetCurrentPath()
  if Config_IsFileEnabled(curPath) = FALSE then exit sub

  dim as HWND hScintilla = GetCurrentScintilla()
  dim as integer i, nLines, oldMask, oldCount, firstChanged
  dim as integer maxContentLen = 0, padding = 0, lineLen
  dim as boolean cacheOk
  dim as RawResult raw
  dim as string sLine

  if hScintilla = 0 then exit sub
  EnsureErrorAnnotationStyle(hScintilla)

  nLines = SendMessage(hScintilla, SCI_GETLINECOUNT, 0, 0)
  if nLines < 1 then nLines = 1

  oldCount = 0
  cacheOk = (g_cacheReady andalso (g_cachePath = curPath))
  if cacheOk then oldCount = ubound(g_cachedLineText) + 1

  firstChanged = 0
  if (forceFull = FALSE) andalso cacheOk then
    if startLine >= 0 then
      firstChanged = startLine
      if firstChanged > nLines - 1 then firstChanged = nLines - 1
      if firstChanged > oldCount then firstChanged = 0
    elseif oldCount = nLines then
      firstChanged = -1
      for i = 0 to nLines - 1
        sLine = GetScintillaLineText(hScintilla, i)
        if sLine <> g_cachedLineText(i) then
          firstChanged = i
          exit for
        end if
      next i
      if firstChanged < 0 then exit sub
    end if
  end if

  oldMask = SendMessage(hScintilla, SCI_GETMODEVENTMASK, 0, 0)
  SendMessage(hScintilla, SCI_SETMODEVENTMASK, 0, 0)
  SendMessage(hScintilla, SCI_EOLANNOTATIONSETVISIBLE, EOLANNOTATION_STANDARD, 0)

  Parser_ClearVariables()
  Parser_SetSupportComplexNumbers(Config_GetSupportComplexNumbers())

  redim preserve g_cachedLineText(0 to nLines - 1)
  redim preserve g_cachedResult(0 to nLines - 1)
  redim preserve g_annText(0 to nLines - 1)

  for i = 0 to firstChanged - 1
    Parser_TryEvaluateExRaw(g_cachedLineText(i), raw)
    lineLen = Len(g_cachedLineText(i))
    if lineLen > maxContentLen then maxContentLen = lineLen
  next i

  for i = firstChanged to nLines - 1
    sLine = GetScintillaLineText(hScintilla, i)
    lineLen = Len(sLine)
    if lineLen > maxContentLen then maxContentLen = lineLen
    g_cachedLineText(i) = sLine
    g_cachedResult(i) = DisplayTextFromEval(sLine)
  next i

  ' separate loop for quick annotations update
  for i = firstChanged to nLines - 1
    if Len(g_cachedResult(i)) > 0 then
      padding = maxContentLen - Len(g_cachedLineText(i)) + 5
      SetLineAnnotation(hScintilla, i, padding, g_cachedResult(i))
    else
      ClearLineAnnotation(hScintilla, i)
    end if
  next i

  g_cacheReady = TRUE
  g_cachePath = curPath
  SendMessage(hScintilla, SCI_SETMODEVENTMASK, oldMask, 0)
end sub

sub UpdateUIState()
  dim as string curPath = GetCurrentPath()
  dim as boolean isEnabled = Config_IsFileEnabled(curPath)

  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(0)._cmdID, iif(isEnabled, 1, 0))

  InvalidateAnnotationCache()

  if isEnabled then
    UpdateAnnotations()
    if Config_GetSyntaxHighlight() then ApplySmartMathUDL()
  else
    dim as HWND hScintilla = GetCurrentScintilla()
    if hScintilla <> 0 then
      SendMessage(hScintilla, SCI_EOLANNOTATIONCLEARALL, 0, 0)
      SendMessage(hScintilla, SCI_EOLANNOTATIONSETVISIBLE, EOLANNOTATION_HIDDEN, 0)
    end if
  end if
end sub

sub TogglePlugin cdecl()
  dim as string curPath = GetCurrentPath()
  ' MessageBoxA(nppData._nppHandle, curPath, "Smart Math Toggle", MB_OK or MB_ICONWARNING)
  Config_ToggleFile(curPath)
  Config_Save()
  UpdateUIState()
end sub

sub SetPrecision(p as integer, byval saveConfig as boolean)
  Config_SetDecimalPlaces(p)
  dim as integer i
  for i = 0 to 8
    SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_PREC0 + i)._cmdID, 0)
  next i
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_PREC0 + p)._cmdID, 1)

  if saveConfig then Config_Save()
  if Config_IsFileEnabled(GetCurrentPath()) then UpdateAnnotations(TRUE)
end sub

sub SetPrec0 cdecl() : SetPrecision(0, TRUE) : end sub
sub SetPrec1 cdecl() : SetPrecision(1, TRUE) : end sub
sub SetPrec2 cdecl() : SetPrecision(2, TRUE) : end sub
sub SetPrec3 cdecl() : SetPrecision(3, TRUE) : end sub
sub SetPrec4 cdecl() : SetPrecision(4, TRUE) : end sub
sub SetPrec5 cdecl() : SetPrecision(5, TRUE) : end sub
sub SetPrec6 cdecl() : SetPrecision(6, TRUE) : end sub
sub SetPrec7 cdecl() : SetPrecision(7, TRUE) : end sub
sub SetPrec8 cdecl() : SetPrecision(8, TRUE) : end sub

sub ToggleUseThousandsSep cdecl()
  dim as boolean enabled = not Config_GetUseThousandsSep()
  Config_SetUseThousandsSep(enabled)
  Config_Save()
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_USETHOUSANDS)._cmdID, iif(enabled, 1, 0))
  if Config_IsFileEnabled(GetCurrentPath()) then UpdateAnnotations(TRUE)
end sub

sub ToggleComplexNumbers cdecl()
  dim as boolean enabled = not Config_GetSupportComplexNumbers()
  Config_SetSupportComplexNumbers(enabled)
  Config_Save()
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_COMPLEX)._cmdID, iif(enabled, 1, 0))
  if Config_IsFileEnabled(GetCurrentPath()) then UpdateAnnotations(TRUE)
end sub

sub ToggleShowErrors cdecl()
  dim as boolean enabled = not Config_GetShowErrors()
  Config_SetShowErrors(enabled)
  Config_Save()
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_SHOWERRORS)._cmdID, iif(enabled, 1, 0))
  if Config_IsFileEnabled(GetCurrentPath()) then UpdateAnnotations(TRUE)
end sub

sub ToggleSyntaxHighlight cdecl()
  dim as boolean enabled = not Config_GetSyntaxHighlight()
  Config_SetSyntaxHighlight(enabled)
  Config_Save()
  SendMessage(nppData._nppHandle, NPPM_SETMENUITEMCHECK, funcItems(IDX_SYNTAXHIGHLIGHT)._cmdID, iif(enabled, 1, 0))
  if enabled andalso Config_IsFileEnabled(GetCurrentPath()) then
    verifySyntaxFilesExist()
    ApplySmartMathUDL()
  end if
end sub

sub ShowDocumentation cdecl()
  dim as wstring * (MAX_PATH + 64) sMsg
  if GetFileAttributesW(@documentationFilePath) = INVALID_FILE_ATTRIBUTES then
    sMsg = "The file does not exist:" & wchr(13, 10) & documentationFilePath
    MessageBoxW(nppData._nppHandle, @sMsg, PLUGIN_NAME, MB_OK or MB_ICONWARNING)
    exit sub
  end if
  SendMessage(nppData._nppHandle, NPPM_DOOPEN, 0, cast(LPARAM, @documentationFilePath))
end sub

sub ShowAbout cdecl()
  ShowAboutDialog(nppData._nppHandle)
end sub

extern "C"

sub setInfo(byval notpadPlusData as NppData) export
  nppData = notpadPlusData
end sub

function getName() as const wstring ptr export
  return @PLUGIN_NAME
end function

function getFuncsArray(byval nbF as integer ptr) as FuncItem ptr export
  *nbF = NB_FUNC
  dim as wstring * 64 sMainName = "Smart Math"

  with funcItems(IDX_TOGGLEPLUGIN)
    ._itemName = sMainName
    ._pFunc = @TogglePlugin
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_SEPARATOR1)
    ._itemName = ""
    ._pFunc = NULL
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  static as PFUNCPLUGINCMD pFuncs(8) => { _
    @SetPrec0, @SetPrec1, @SetPrec2, @SetPrec3, @SetPrec4, _
    @SetPrec5, @SetPrec6, @SetPrec7, @SetPrec8 }

  dim as integer i
  dim as wstring * 64 sTempName
  for i = 0 to 8
    sTempName = "Decimal places " & i
    with funcItems(IDX_PREC0 + i)
      ._itemName = sTempName
      ._pFunc = pFuncs(i)
      ._cmdID = 0
      ._init2Check = FALSE
      ._pShKey = NULL
    end with
  next i

  with funcItems(IDX_USETHOUSANDS)
    ._itemName = "Use Thousands Separator"
    ._pFunc = @ToggleUseThousandsSep
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_COMPLEX)
    ._itemName = "Complex Numbers"
    ._pFunc = @ToggleComplexNumbers
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_SHOWERRORS)
    ._itemName = "Show Errors"
    ._pFunc = @ToggleShowErrors
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_SYNTAXHIGHLIGHT)
    ._itemName = "Syntax Highlighting"
    ._pFunc = @ToggleSyntaxHighlight
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_SEPARATOR2)
    ._itemName = ""
    ._pFunc = NULL
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_DOCUMENTATION)
    ._itemName = "Documentation..."
    ._pFunc = @ShowDocumentation
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  with funcItems(IDX_ABOUT)
    ._itemName = "About"
    ._pFunc = @ShowAbout
    ._cmdID = 0
    ._init2Check = FALSE
    ._pShKey = NULL
  end with

  return @funcItems(0)
end function

sub beNotified(byval pNotify as SCNotification ptr) export
  if pNotify->nmhdr.code = NPPN_READY then
    Config_Init(nppData._nppHandle)
    Config_Load()
    OrganizeMenu()
    g_smartMathUdlCmdId = getSmartMathUdlId()
    initCommonPaths(nppData._nppHandle)
    if Config_GetSyntaxHighlight() then verifySyntaxFilesExist()
    EnsureSciHooked()
    SendMessage(nppData._nppHandle, NPPM_ADDSCNMODIFIEDFLAGS, 0, SC_MOD_TEXT_FLAGS)
    UpdateUIState()

  elseif pNotify->nmhdr.code = NPPN_TBMODIFICATION then
    dim as HDC hdc = GetDC(NULL)
    dim as integer bmpX = 16, bmpY = 16
    dim as integer icoX = 32, icoY = 32

    if hdc then
      bmpX = MulDiv(16, GetDeviceCaps(hdc, LOGPIXELSX), 96)
      bmpY = MulDiv(16, GetDeviceCaps(hdc, LOGPIXELSY), 96)
      icoX = MulDiv(32, GetDeviceCaps(hdc, LOGPIXELSX), 96)
      icoY = MulDiv(32, GetDeviceCaps(hdc, LOGPIXELSY), 96)
      ReleaseDC(NULL, hdc)
    end if

    dim as HBITMAP hBmp = LoadImage(hInst, MAKEINTRESOURCE(TB_BMP_ID), IMAGE_BITMAP, bmpX, bmpY, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS)
    dim as HICON hIconLight = LoadImage(hInst, MAKEINTRESOURCE(TB_ICON_LIGHT_ID), IMAGE_ICON, icoX, icoY, LR_DEFAULTSIZE)
    dim as HICON hIconDark = LoadImage(hInst, MAKEINTRESOURCE(TB_ICON_DARK_ID), IMAGE_ICON, icoX, icoY, LR_DEFAULTSIZE)

    if hIconDark = 0 then hIconDark = hIconLight

    dim as toolbarIconsWithDarkMode tbIcons
    tbIcons.hToolbarBmp = hBmp
    tbIcons.hToolbarIcon = hIconLight
    tbIcons.hToolbarIconDarkMode = hIconDark

    SendMessage(nppData._nppHandle, NPPM_ADDTOOLBARICON_FORDARKMODE, funcItems(0)._cmdID, cast(LPARAM, @tbIcons))

  elseif pNotify->nmhdr.code = NPPN_BUFFERACTIVATED then
    UpdateUIState()

  elseif pNotify->nmhdr.code = NPPN_WORDSTYLESUPDATED _
      orelse pNotify->nmhdr.code = NPPN_LANGCHANGED then
    if Config_IsFileEnabled(GetCurrentPath()) then
      dim as HWND hSciTheme = GetCurrentScintilla()
      if hSciTheme <> 0 then EnsureErrorAnnotationStyle(hSciTheme)
    end if

  elseif pNotify->nmhdr.code = SCN_MODIFIED then
    if (pNotify->modificationType and SC_MOD_TEXT_FLAGS) <> 0 then
      if Config_IsFileEnabled(GetCurrentPath()) then
        dim as HWND hSciMod = GetCurrentScintilla()
        dim as integer startLine = 0
        if hSciMod <> 0 then
          startLine = SendMessage(hSciMod, SCI_LINEFROMPOSITION, pNotify->position, 0)
        end if
        UpdateAnnotations(FALSE, startLine)
      end if
    end if

  elseif pNotify->nmhdr.code = NPPN_BEFORESHUTDOWN _
      orelse pNotify->nmhdr.code = NPPN_SHUTDOWN then
    isNppClosing = TRUE
    UnhookSci()

  elseif pNotify->nmhdr.code = NPPN_FILEBEFORECLOSE then
    if isNppClosing = FALSE then
      dim as integer bufferID = pNotify->nmhdr.idFrom
      dim as wstring * (MAX_PATH*2) fullPath
      SendMessage(nppData._nppHandle, NPPM_GETFULLPATHFROMBUFFERID, bufferID, cast(LPARAM, @fullPath))
      Config_DisableFile(str(fullPath))
    end if

  elseif pNotify->nmhdr.code = NPPN_DARKMODECHANGED then
    dim as integer prevUdlId = g_smartMathUdlCmdId
    g_smartMathUdlCmdId = getSmartMathUdlId()
    if (prevUdlId <> g_smartMathUdlCmdId) andalso Config_IsFileEnabled(GetCurrentPath()) then
      if Config_GetSyntaxHighlight() then ApplySmartMathUDL()
    end if

  end if
end sub

function messageProc(byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT export
  return TRUE
end function

function isUnicode() as WINBOOL export
  return TRUE
end function

end extern
