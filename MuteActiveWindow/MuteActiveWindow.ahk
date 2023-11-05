#Persistent
#SingleInstance Force
SetTitleMatchMode, 2

; Get the directory of the AutoHotkey script
ScriptDir := A_ScriptDir

; Specify the directory for configuration files
ConfigDir := ScriptDir . "\Config"

global ScriptVersion := "8.0.0"

; Define a variable to control debugging messages
EnableDebug := true ; Set this to false to disable debugging messages

; Add custom menu items to the tray menu
AddCustomMenus() ; Add custom menu options on script startup

; Set the custom tray icon if it exists
SetCustomIcon()

; Check for auto-updates with AutoUpdateCheck.txt file
global BetaUpdateEnabled
CheckBetaUpdates := ConfigDir . "\EnableBetaUpdates.txt"
FileReadLine, BetaUpdateEnabled, %CheckBetaUpdates%, 1

; Check for beta aut-updates with EnableBetaUpdates.txt file.
CheckForUpdatesFile := ConfigDir . "\AutoUpdateCheck.txt"
FileReadLine, AutoUpdateEnabled, %CheckForUpdatesFile%, 1

if (AutoUpdateEnabled = "1") {
    ; Run auto-update check if enabled
    CheckForUpdates()
}

; Check the muting method.
CheckMutingMethod := ConfigDir . "\SelectMutingMethod.txt"
if (FileExist(CheckMutingMethod)) {
    FileReadLine, MutingMethodSelected, %CheckMutingMethod%, 1

    if (MutingMethodSelected = "1") {
        if (FileExist(ScriptDir . "\maw-muter.exe"))
            mutingmethod := "maw-muter"
        else
            MsgBox, maw-muter.exe not found in the script directory.
    } else {
        if (FileExist(ScriptDir . "\svcl.exe"))
            mutingmethod := "svcl"
        else
            MsgBox, svcl.exe not found in the script directory.
    }
} else {
    MsgBox, File not found: %CheckMutingMethod%
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
        HotkeyName := "RunMute"
        Hotkey, %Hotkey%, %HotkeyName% ; Call RunMute when the hotkey is pressed
    }
}

RunMute:
    ; Check if the hotkey is being pressed
    if (A_ThisHotkey = Hotkey) {
        ; Get the process name (EXE) of the active window
        WinGet, processName, ProcessName, A

        ; Check if the active window's process is ApplicationFrameHost.exe
        if (processName = "ApplicationFrameHost.exe") {
            WindowUWP := WinExist("A")
            ControlGetFocus, FocusedControl, ahk_id %WindowUWP%
            ControlGet, Hwnd, Hwnd,, %FocusedControl%, ahk_id %WindowUWP%
            WinGet, uwpprocess, processname, ahk_id %Hwnd%
            WinGet, Pid, Pid, ahk_id %Hwnd%
            if (!IsExcluded(uwpprocess, ExcludedAppsFile)) {
                if (mutingmethod = "svcl") {
                    ; Run the svcl.exe command to mute/unmute the active window's .exe
                    RunWait, %ScriptDir%\svcl.exe /Switch "%uwpprocess%" /Unmute "DefaultCaptureDevice", , Hide
                } else if (mutingmethod = "maw-muter") {
                    ; Run the maw-muter.exe command to mute the active window's .exe
                    RunWait, %ScriptDir%\maw-muter.exe mute "%uwpprocess%", , Hide
                }
            }
        } else {
            ; Get the .exe name of the active window
            exeName := GetActiveWindowExe()

            ; Check if the title or exe is excluded, and skip muting if it is
            if (!IsExcluded(exeName, ExcludedAppsFile)) {
                if (mutingmethod = "svcl") {
                    ; Run the svcl.exe command to mute/unmute the active window's .exe
                    RunWait, %ScriptDir%\svcl.exe /Switch "%exeName%" /Unmute "DefaultCaptureDevice", , Hide
                } else if (mutingmethod = "maw-muter") {
                    ; Run the maw-muter.exe command to mute the active window's .exe
                    RunWait, %ScriptDir%\maw-muter.exe mute "%exeName%", , Hide
                }
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
    Menu, Tray, Add, Check for updates, CheckForUpdatesFromMenu
    Menu, Tray, Add, Open config folder, OpenConfigFolder
    Menu, Tray, Add, Version, DisplayVersion
}

; Function to display the version information
DisplayVersion() {
    MsgBox, MuteActiveWindow`nVersion v%ScriptVersion%
}

OpenConfigFolder() {
    Try Run, explorer.exe "%A_ScriptDir%\Config"
}

CheckForUpdatesFromMenu() {
    CheckForUpdates(true) ; Pass 'true' to indicate that it's called from the menu
}

CheckForUpdates(isFromMenu := false) {
    ; Define the URL of your raw VERSION text file on GitHub
    GitHubStableVersionURL := "https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/VERSION"
    GitHubBetaVersionURL := "https://raw.githubusercontent.com/tfurci/MuteActiveWindow/beta/VERSION"

    ; Define the URL of your raw CHANGELOG text file on GitHub
    GitHubStableChangelogURL := "https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/CHANGELOG"
    GitHubBetaChangelogURL := "https://raw.githubusercontent.com/tfurci/MuteActiveWindow/beta/CHANGELOG"

    ; Determine the URL to use based on BetaUpdateEnabled flag
    if (BetaUpdateEnabled = 1) {
        GitHubVersionURL := GitHubBetaVersionURL
        GitHubChangelogURL := GitHubBetaChangelogURL
    } else {
        GitHubVersionURL := GitHubStableVersionURL
        GitHubChangelogURL := GitHubStableChangelogURL
    }

    ; Define script directories
    UpdateScriptBat := A_ScriptDir . "\Scripts\BatUpdater.bat"

    ; Make an HTTP request to the GitHub VERSION file
    oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    oHTTP.Open("GET", GitHubVersionURL, false)
    oHTTP.SetRequestHeader("Cache-Control", "no-cache")  ; Prevent caching
    Try {
        oHTTP.Send()
    } Catch {
        ; No internet connectivity, display a message and exit
        MsgBox, No internet connection. Please check your internet connection.
        return
    }
    ; Check if the request was successful
    if (oHTTP.Status = 200) {
        ; Get the content of the VERSION file
        LatestVersion := oHTTP.ResponseText

        ; Trim any trailing whitespace or characters from the version strings
        StringTrimRight, LatestVersion, LatestVersion, 0
        StringTrimRight, ScriptVersion, ScriptVersion, 0

        ; Make an HTTP request to the GitHub CHANGELOG file
        oHTTP.Open("GET", GitHubChangelogURL, false)
        oHTTP.SetRequestHeader("Cache-Control", "no-cache")  ; Prevent caching
        oHTTP.Send()

        ; Check if the request for CHANGELOG was successful
        if (oHTTP.Status = 200) {
            ; Get the content of the CHANGELOG file
            Changelog := oHTTP.ResponseText
        } else {
            ; Handle the case where fetching the CHANGELOG fails
            Changelog := "Failed to retrieve changelog. Check your internet connection."
        }

        ; Uncomment to see comparing of versions
        ; MsgBox, LatestVersion: %LatestVersion%`nScriptVersion: %ScriptVersion%

        ; Compare the full version strings
        if (ScriptVersion != LatestVersion) {
            ; Versions are different, prompt the user
            LatestMajor := SubStr(LatestVersion, 1, InStr(LatestVersion, ".") - 1)
            LocalMajor := SubStr(ScriptVersion, 1, InStr(ScriptVersion, ".") - 1)

            if (LocalMajor != LatestMajor) {
                ; Prompt the user to download the update from GitHub
                MsgBox, 4, Update Available, A new version v%LatestVersion% (Current version: v%ScriptVersion%) is available on GitHub.`n`nAs this is a major version update, you need to download it from GitHub's releases.`n`nChangelog:`n%Changelog%`n`nWould you like to download it?
                IfMsgBox Yes
                {
                    Run, https://github.com/tfurci/MuteActiveWindow/releases
                }
            } else {
                ; Prompt the user to run the local UpdateScript.bat
                MsgBox, 4, Update Available, A new version v%LatestVersion% (Current version: v%ScriptVersion%) is available.`n`nAs this is not a major update, you can update it using the script, and it will only take a second.`n`nChangelog:`n%Changelog%`n`nWould you like to run the update script?
                IfMsgBox Yes
                {
                    ; Run the local UpdateScript.bat
                    Run, %UpdateScriptBat%
                }
            }
        } else if (isFromMenu) {
            ; Display a message if called from the menu and versions are the same
            MsgBox, Your script is already up-to-date.`n`nLatest available version:  v%LatestVersion%`nYour current version:  v%ScriptVersion%`n`nChangelog:`n%Changelog%
        }
    }
    else {
        ; Display a message if the update check fails
        MsgBox, Update check failed. Please check your internet connection.
    }
}

^!P::
    WindowUWP := WinExist("A")
    ControlGetFocus, FocusedControl, ahk_id %WindowUWP%
    ControlGet, Hwnd, Hwnd,, %FocusedControl%, ahk_id %WindowUWP%
    WinGet, uwpprocess, processname, ahk_id %Hwnd%
    
    ; Prompt the user with a message box with "Yes" and "No" buttons
    MsgBox, 4, Add Exe to excluded apps., Add EXE to Config/ExcludedApps.txt?`n%uwpprocess%
    
    ; Check if the user clicked "Yes"
    IfMsgBox Yes
    {   
        FileAppend, `n%uwpprocess%, %ConfigDir%\ExcludedApps.txt
        
        MsgBox, Added %uwpprocess% to Config/ExcludedApps.txt
    }
    
return