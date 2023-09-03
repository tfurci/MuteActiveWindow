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

; Construct the full path to the CustomPairs.txt file
CustomPairsFile := ScriptDir . "\CustomPairs.txt"

; Construct the full path to the ExcludedApps.txt file
ExcludedAppsFile := ScriptDir . "\ExcludedApps.txt"

; Check if the CustomPairs.txt file exists
if !FileExist(CustomPairsFile) {
    MsgBox CustomPairs.txt not found in the script directory.
    ExitApp
}

; Define a variable to store the hotkey
Hotkey := ""

; Check if the script is running for the first time
if (A_PriorHotkey = "") {
    ; Read the hotkey from the external file "Hotkey.txt"
    HotkeyFile := ScriptDir . "\Hotkey.txt"
    FileReadLine, Hotkey, %HotkeyFile%, 1 ; Read the first line

    ; Define a hotkey dynamically based on the value read from "Hotkey.txt"
    if (Hotkey != "") {
        HotkeyName := Hotkey
        Hotkey, %HotkeyName%, RunMute ; Call RunMute when hotkey is pressed
    }
}

; Rename ToggleHotkey to RunMute
RunMute:
    ; Check if the hotkey is being pressed
    if GetKeyState(HotkeyName, "P") {
        exeName := GetActiveWindowExe()
        
        ; Read the content of CustomPairs.txt into a variable
        FileRead, customExePairs, %CustomPairsFile%
        
        ; Split the customExePairs into an array of pairs based on semicolon delimiter
        customPairs := StrSplit(customExePairs, ";")
        
        ; Iterate through the array and mute the target executable if the display executable matches
        Loop, % customPairs.Length() {
            pair := customPairs[A_Index]
            parts := StrSplit(pair, "|")
            displayExe := parts[1]
            targetExe := parts[2]
            
            if (exeName = displayExe) {
                ; Check if the executable is not in the exclusion list
                if (!IsExcluded(exeName, ExcludedAppsFile)) {
                    ; Use the "Switch" command with svcl.exe to mute the specified target executable
                    RunWait, %ScriptDir%\svcl.exe /Switch "%targetExe%", , Hide
                    return ; Exit the loop after muting one target executable
                }
            }
        }
        
        ; If no custom match was found, mute/unmute the active window's .exe
        if (exeName && !IsExcluded(exeName, ExcludedAppsFile)) {
            RunWait, %ScriptDir%\svcl.exe /Switch "%exeName%", , Hide
        }
    }
return

; Function to check if an executable is in the exclusion list
IsExcluded(exeName, exclusionFile) {
    ; Read the exclusion list from the specified file
    FileRead, excludedApps, %exclusionFile%
    
    ; Split the exclusion list into an array of excluded executables
    excludedList := StrSplit(excludedApps, ";")
    
    ; Iterate through the list and check if exeName is in the exclusion list
    Loop, % excludedList.Length() {
        excludedPair := excludedList[A_Index]
        parts := StrSplit(excludedPair, "|")
        excludedDisplayExe := parts[1]
        excludedTargetExe := parts[2]
        
        if (exeName = excludedDisplayExe) {
            return true
        }
    }
    
    return false
}

; Check if the hotkey is being pressed
if GetKeyState(HotkeyName, "P") {
    ; Call the RunMute label to handle muting when the hotkey is pressed
    GoSub, RunMute
}
