@echo off
setlocal enabledelayedexpansion

:: Specify the URL of the raw script on GitHub
set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/MuteActiveWindow.ahk"

:: Specify the new local directory where the script should be saved
set "localDirectory=%~dp0..\"

:: Specify the full path to the local script file
set "localFilePath=%localDirectory%MuteActiveWindow.ahk"

:: Ensure that the local directory exists
md "%localDirectory%" 2>nul

:: Download the script from GitHub
curl -k -o "%localFilePath%.temp" "%githubRawURL%"

:: Compare the content of the downloaded file with the local file
fc "%localFilePath%.temp" "%localFilePath%" > nul

if errorlevel 1 (
    echo.
    echo Script downloaded and updated.
    move /y "%localFilePath%.temp" "%localFilePath%" > nul
    echo.
) else (
    echo.
    echo Script is already on the latest version.
    del "%localFilePath%.temp"
    echo.
)

pause
