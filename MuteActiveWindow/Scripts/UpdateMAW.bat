@echo off
setlocal enabledelayedexpansion

:: Specify the URL of the raw script on GitHub (Main Script)
set "githubMainScriptURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/MuteActiveWindow.ahk"

:: Specify the root directory where the script is currently located
set "scriptDirectory=%~dp0"

:: Specify the "Scripts" directory relative to the script directory
set "scriptsDirectory=%scriptDirectory%.."

:: Specify the full path to the local main script file
set "localMainScriptPath=%scriptsDirectory%\MuteActiveWindow.ahk"

:: Ensure that the local "Scripts" directory exists
md "%scriptsDirectory%" 2>nul

:: Download and update the main script from GitHub
curl -k -o "%localMainScriptPath%.temp" "%githubMainScriptURL%"

:: Compare the content of the downloaded main script file with the local file
fc "%localMainScriptPath%.temp" "%localMainScriptPath%" > nul

if errorlevel 1 (
    echo.
    echo Main script downloaded and updated.
    move /y "%localMainScriptPath%.temp" "%localMainScriptPath%" > nul
    echo.
) else (
    echo.
    echo Main script is already on the latest version.
    del "%localMainScriptPath%.temp"
    echo.
)

:: Start AutoHotkey
start "" /b "AutoHotkey.exe" "%localMainScriptPath%"

pause
