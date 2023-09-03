#Persistent
SetTitleMatchMode, 2

; Get the directory of the AutoHotkey script
ScriptDir := A_ScriptDir

; Function to get the active window's .exe file name
GetActiveWindowExe() {
    WinGetActiveTitle, title
    WinGet, processName, ProcessName, %title%
    return processName
}

; Define a hotkey (F1) to toggle mute/unmute the active window
F1:: 
    exeName := GetActiveWindowExe()
    if (exeName) {
        ; Use the "Switch" command with svcl.exe from the script directory
        RunWait, %ScriptDir%\svcl.exe /Switch "%exeName%", , Hide
    }
return
