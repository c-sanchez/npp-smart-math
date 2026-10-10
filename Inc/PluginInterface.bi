#ifndef PLUGININTERFACE_H
#define PLUGININTERFACE_H

#include "Notepad_plus_msgs.bi"

const nbChar = 64
const NPPM_ADDTOOLBARICON_FORDARKMODE = (NPPMSG + 101)

type NppData
  as HWND _nppHandle
  as HWND _scintillaMainHandle
  as HWND _scintillaSecondHandle
end type

type ToolbarIcons
  as HBITMAP hToolbarBmp
  as HICON hToolbarIcon
end type

type toolbarIconsWithDarkMode
  as HBITMAP hToolbarBmp
  as HICON hToolbarIcon
  as HICON hToolbarIconDarkMode
end type

type SCNotification
  nmhdr as NMHDR
  position as integer
  ch as long
  modifiers as long
  modificationType as long
end type

type PFUNCPLUGINCMD as sub cdecl ()

type ShortcutKey
  as WINBOOL _isCtrl
  as WINBOOL _isAlt
  as WINBOOL _isShift
  as UBYTE _key
end type

type FuncItem
  as WSTRING * nbChar _itemName
  as PFUNCPLUGINCMD _pFunc
  as long _cmdID
  as WINBOOL _init2Check
  as ShortcutKey ptr _pShKey
end type

#endif