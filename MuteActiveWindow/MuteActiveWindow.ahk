#Requires AutoHotkey v2.0
#SingleInstance
F1::
{
    global TrueWindow := 0
    activeWin := WinActive("A") ; Get the active window
    processName := WinGetProcessName(activeWin)
    MsgBox processName
    if (processName == "ApplicationFrameHost.exe") {
        DllCall("EnumChildWindows", "ptr", activeWin, "ptr", CallbackCreate(EnumChildWindows, "F"), "uint", 0)
        if (TrueWindow) {
            uwpprocess := WinGetProcessName("ahk_id " . TrueWindow)
            MsgBox uwpprocess
        }
    } else {
        MsgBox processName
    }
}

EnumChildWindows(hwnd) {
    global TrueWindow
    if WinGetProcessName(hwnd) != "ApplicationFrameHost.exe" {
        TrueWindow := hwnd
        return false
    }
    return true
}
