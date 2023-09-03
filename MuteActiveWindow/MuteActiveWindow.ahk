#Persistent
SetTitleMatchMode, 2

; Get the directory of the AutoHotkey script
ScriptDir := A_ScriptDir

; Specify the directory for configuration files
ConfigDir := ScriptDir . "\Config"

; Define a variable to control debugging messages
EnableDebug := true ; Set this to false to disable debugging messages

; Function to get the active window's .exe file name
GetActiveWindowExe() {
    WinGetActiveTitle, title
    WinGet, processName, ProcessName, %title%
    return processName
}

; Construct the full path to the ExcludedApps.txt file in the Config folder
ExcludedAppsFile := ConfigDir . "\ExcludedApps.txt"

; Define a variable to store the hotkey
Hotkey := ""

; Check if the script is running for the first time
if (A_PriorHotkey = "") {
    ; Read the hotkey from the external file "Hotkey.txt" in the Config folder
    HotkeyFile := ConfigDir . "\Hotkey.txt"
    FileReadLine, Hotkey, %HotkeyFile%, 1 ; Read the first line

    ; Define a hotkey dynamically based on the value read from "Hotkey.txt"
    if (Hotkey != "") {
        HotkeyName := Hotkey
        Hotkey, %HotkeyName%, RunMute ; Call RunMute when the hotkey is pressed
    }
}

; Rename ToggleHotkey to RunMute
RunMute:
    ; Check if the hotkey is being pressed
    if GetKeyState(HotkeyName, "P") {
        ; Get the process name (EXE) of the active window
        WinGet, processName, ProcessName, A

        ; Check if the active window's process is ApplicationFrameHost.exe
        if (processName = "ApplicationFrameHost.exe") {
            ; Get the title of the active window (topbar text)
            WinGetActiveTitle, title

            ; Check if the title or exe is excluded, and skip muting if it is
            if (!IsExcluded(title, ExcludedAppsFile) && !IsExcluded(processName, ExcludedAppsFile)) {
                ; Run the svcl.exe command to mute/unmute the application without waiting
                RunWait, svcl.exe /Switch "%title%", , Hide, output  ; Capture the output
            }
        } else {
            ; Get the .exe name of the active window
            exeName := GetActiveWindowExe()

            ; Check if the title or exe is excluded, and skip muting if it is
            if (!IsExcluded(exeName, ExcludedAppsFile) && !IsExcluded(processName, ExcludedAppsFile)) {
                ; Run the svcl.exe command to mute/unmute the active window's .exe
                RunWait, %ScriptDir%\svcl.exe /Switch "%exeName%", , Hide, output  ; Capture the output
            }
        }
    }
return

; Function to check if a title or exe is in the exclusion list
IsExcluded(name, exclusionFile) {
    ; Read the exclusion list from the specified file in the Config folder
    FileRead, excludedApps, %exclusionFile%
    
    ; Split the exclusion list into an array of excluded items using line breaks
    excludedList := StrSplit(excludedApps, "`r`n") ; Use "`r`n" for Windows line breaks
    
    ; Iterate through the list and check if the name is in the exclusion list
    Loop, % excludedList.Length() {
        excludedName := Trim(excludedList[A_Index])
        
        if (name = excludedName) {
            return true
        }
    }
    
    return false
}
