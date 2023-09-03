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

; Custom exe mute pointers to fix some apps, dont forget to use , in the end
; Also make sure to uncomment customExePairs lines that you want to use

customExePairs := "ApplicationFrameHost.exe|XboxPcApp.exe,"
;customExePairs .= "app2.exe|target2.exe,"
;customExePairs .= "app3.exe|target3.exe,"
;customExePairs .= "app4.exe|target4.exe,"
;customExePairs .= "app5.exe|target5.exe,"


; Define a hotkey (F1) to toggle mute/unmute the active window
F1:: 
    exeName := GetActiveWindowExe()
    
    ; Split the customExePairs into an array of pairs based on the comma delimiter
    customPairs := StrSplit(customExePairs, ",")
    
    ; Iterate through the array and mute the target executable if the display executable matches
    Loop, % customPairs.Length() {
        pair := customPairs[A_Index]
        parts := StrSplit(pair, "|")
        displayExe := parts[1]
        targetExe := parts[2]
        
        if (exeName = displayExe) {
            ; Use the "Switch" command with svcl.exe to mute the specified target executable
            RunWait, %ScriptDir%\svcl.exe /Switch "%targetExe%", , Hide
            return ; Exit the loop after muting one target executable
        }
    }
    
    ; If no custom match was found, mute/unmute the active window's .exe
    if (exeName) {
        RunWait, %ScriptDir%\svcl.exe /Switch "%exeName%", , Hide
    }
return
