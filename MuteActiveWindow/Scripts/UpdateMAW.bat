@echo off
setlocal enabledelayedexpansion

set "betaFlag=%~1"
if /i "%betaFlag%"=="-beta" (
    set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/beta/MuteActiveWindow/MuteActiveWindow.ahk"
) else (
    set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/MuteActiveWindow.ahk"
)

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

:: Set the path to the previous folder
set "previousFolder=..\"

:: Set the name of the AutoHotkey script
set "scriptName=MuteActiveWindow.ahk"

:: Combine the path and script name to create the full path to the script
set "scriptPath=%previousFolder%%scriptName%"

:: Check if the script file exists
if exist "%scriptPath%" (
    echo Running %scriptName%...
    start "" /b "%scriptPath%"
) else (
    echo The script %scriptName% does not exist in the previous folder. Or is not name MuteActiveWindow.ahk
    pause
)

pause