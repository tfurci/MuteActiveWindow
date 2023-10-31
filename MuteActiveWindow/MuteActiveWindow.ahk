#Requires AutoHotkey v2.0

F1::
{
DllCall("GetCursorPos", "int64P", &pt64 := 0)
hWndP := DllCall("WindowFromPoint","int64", pt64)
MsgBox(WinGetProcessName(hWndP))
}