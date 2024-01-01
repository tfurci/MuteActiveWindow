#Requires AutoHotkey v2.0
#SingleInstance

global ScriptDir := A_ScriptDir
global ConfigDir := ScriptDir . "\Config"
global ExcludedAppsFile := ConfigDir . "\ExcludedApps.txt"
global HotkeyFile := ConfigDir . "\Hotkey.txt"
global UserHotkey := "" ; Variable for storing the hotkey

; Read hotkey from file
FileObj := FileOpen(HotkeyFile, "r")
if (FileObj) {
    UserHotkey := FileObj.ReadLine()
    FileObj.Close()
}
if (UserHotkey != "")
    Hotkey UserHotkey RunMute

RunMute:
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

; Function to check if a process is excluded
IsExcluded(name, exclusionFile) {
    FileObj := FileOpen(exclusionFile, "r")
    if (FileObj) {
        excludedApps := FileObj.Read()
        FileObj.Close()
    } else {
        excludedApps := ""
    }

    excludedList := StrSplit(excludedApps, "`n", "`r")
    for each, excludedName in excludedList {
        if (name = Trim(excludedName))
            return true
    }
    return false
}

