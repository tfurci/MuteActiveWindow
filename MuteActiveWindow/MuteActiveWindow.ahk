#Persistent
SetTitleMatchMode, 2

; Get the directory of the AutoHotkey script
ScriptDir := A_ScriptDir

; Specify the directory for configuration files
ConfigDir := ScriptDir . "\Config"

global ScriptVersion := "5.1.0"


; Define a variable to control debugging messages
EnableDebug := true ; Set this to false to disable debugging messages

; Add custom menu items to the tray menu
AddCustomMenus() ; Add custom menu options on script startup

; Set the custom tray icon if it exists
SetCustomIcon()

; Check for auto-updates with AutoUpdateCheck.txt file
CheckForUpdatesFile := ConfigDir . "\AutoUpdateCheck.txt"
FileReadLine, AutoUpdateEnabled, %CheckForUpdatesFile%, 1

if (AutoUpdateEnabled = "1") {
    ; Run auto-update check if enabled
    CheckForUpdates()
}

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

SetCustomIcon() {
    ; Define the path to your custom icon file
    CustomIconPath := A_ScriptDir . "\Config\MAW.ico"

    ; Check if the custom icon file exists
    if (FileExist(CustomIconPath)) {
        Menu, Tray, Icon, %CustomIconPath%
    }
}

; Enter the main script loop
return

; Function to add custom menu items to the tray menu
AddCustomMenus() {
    Menu, Tray, Add, , ; This empty item adds a separator
    Menu, Tray, Add, Update Script, CheckForUpdatesFromMenu
    Menu, Tray, Add, Version, DisplayVersion
}

; Function to display the version information
DisplayVersion() {
    MsgBox, MuteActiveWindow`nVersion v%ScriptVersion%
}

CheckForUpdatesFromMenu() {
    CheckForUpdates(true) ; Pass 'true' to indicate that it's called from the menu
}

CheckForUpdates(isFromMenu := false) {
    ; Define the URL of your raw VERSION text file on GitHub
    GitHubVersionURL := "https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/VERSION"
    
    ; Define script directories
    UpdateScriptBat := A_ScriptDir . "\Scripts\UpdateScript.bat"

    ; Make an HTTP request to the GitHub VERSION file
    oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    oHTTP.Open("GET", GitHubVersionURL, false)
    oHTTP.Send()

    ; Check if the request was successful
    if (oHTTP.Status = 200) {
        ; Get the content of the VERSION file
        LatestVersion := oHTTP.ResponseText

        ; Trim any trailing whitespace or characters from the version strings
        StringTrimRight, LatestVersion, LatestVersion, 1
        StringTrimRight, ScriptVersion, ScriptVersion, 0

        ; Uncomment to see comparing of versions
        ; MsgBox, LatestVersion: %LatestVersion%`nScriptVersion: %ScriptVersion%

        ; Compare the full version strings
        if (ScriptVersion != LatestVersion) {
            ; Versions are different, prompt the user
            LatestMajor := SubStr(LatestVersion, 1, InStr(LatestVersion, ".") - 1)
            LocalMajor := SubStr(ScriptVersion, 1, InStr(ScriptVersion, ".") - 1)

            if (LocalMajor != LatestMajor) {
                ; Prompt the user to download the update from GitHub
                MsgBox, 4, Update Available, A new version v%LatestVersion% (Current version: v%ScriptVersion%) is available on GitHub.`n`nAs this is a major version update, you need to download it from GitHub's releases.`n`nWould you like to download it?
                IfMsgBox Yes
                {
                    Run, https://github.com/tfurci/MuteActiveWindow
                }
            } else {
                ; Prompt the user to run the local UpdateScript.bat
                MsgBox, 4, Update Available, A new version v%LatestVersion% (Current version: v%ScriptVersion%) is available.`n`nAs this is not a major update, you can update it using the script, and it will only take a second.`n`nWould you like to run the update script?
                IfMsgBox Yes
				{
                    ; Run the local UpdateScript.bat
                    Run, %UpdateScriptBat%
                }
            }
        } else if (isFromMenu) {
            ; Display a message if called from the menu and versions are the same
            MsgBox, Already on the latest update.
        }
    }
    else {
        ; Display a message if the update check fails
        MsgBox, Update check failed. Please check your internet connection.
    }
}
