@echo off
setlocal enabledelayedexpansion

:: Specify the URL of the raw script on GitHub
set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/MuteActiveWindow.ahk"

:: Specify the root directory where the script is currently located
set "scriptDirectory=%~dp0"

:: Specify the "Scripts" directory relative to the script directory
set "scriptsDirectory=%scriptDirectory%.."

:: Specify the full path to the local script file
set "localFilePath=%scriptsDirectory%\MuteActiveWindow.ahk"

:: Ensure that the local directory exists
md "%scriptsDirectory%" 2>nul

:: Download the script from GitHub
curl -k -o "%localFilePath%.temp" "%githubRawURL%"

:: Compare the content of the downloaded file with the local file
fc "%localFilePath%.temp" "%localFilePath%" > nul

if errorlevel 1 (
    echo.
    echo Script downloaded and updated.
    move /y "%localFilePath%.temp" "%localFilePath%" > nul
    echo.

    :: Run the updated script with AutoHotkey
    start "" /b "AutoHotkey.exe" "%localFilePath%"

) else (
    echo.
    echo Script is already on the latest version.
    del "%localFilePath%.temp"
    echo.
)

pause