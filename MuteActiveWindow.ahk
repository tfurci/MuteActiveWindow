#Persistent
SetTitleMatchMode, 2

; Get the directory of the AutoHotkey script
ScriptDir := A_ScriptDir

; Variable to track mute state
muted := false

; Function to get the active window's .exe file name
GetActiveWindowExe() {
    WinGetActiveTitle, title
    WinGet, processName, ProcessName, %title%
    return processName
}

; Define a hotkey (F1) to toggle mute/unmute the active window
F16:: 
    exeName := GetActiveWindowExe()
    if (exeName) {
        if (muted) {
            ; Unmute the active window using svcl.exe from the script directory
            Run, %ScriptDir%\svcl.exe /Unmute "%exeName%", , Hide
        } else {
            ; Mute the active window using svcl.exe from the script directory
            Run, %ScriptDir%\svcl.exe /Mute "%exeName%", , Hide
        }
        ; Toggle the mute state
        muted := !muted
    }
return
