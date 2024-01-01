#Requires AutoHotkey v2.0
#SingleInstance
F1::
{
    activeWin := WinActive("A") ; Get the active window
    TrueWindow := 0 ; Initialize TrueWindow
    if WinGetProcessName(activeWin) == "ApplicationFrameHost.exe" {
        DllCall("EnumChildWindows", "ptr", activeWin, "ptr", CallbackCreate(EnumChildWindows, "F"), "uint", 0)
        if (TrueWindow) {
            processName := WinGetProcessName("ahk_id " . TrueWindow)
            MsgBox processName
        }
    }

    EnumChildWindows(hwnd) {
        if WinGetProcessName(hwnd) != "ApplicationFrameHost.exe" {
            TrueWindow := hwnd
            return false
        }
        return true
    }
}
