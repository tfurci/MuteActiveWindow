@echo off
setlocal enabledelayedexpansion

:: Specify the URL of the raw script on GitHub (Main Script)
set "githubMainScriptURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/MuteActiveWindow.ahk"

:: Specify the URL of the raw CustomPointers.txt file on GitHub
set "githubCustomPointersURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/Config/CustomPointers.txt"

:: Specify the root directory where the scripts are currently located
set "scriptDirectory=%~dp0"

:: Specify the "Scripts" directory relative to the script directory
set "scriptsDirectory=%scriptDirectory%.."

:: Specify the "Config" directory relative to the script directory
set "configDirectory=%scriptDirectory%..\Config"

:: Specify the full path to the local main script file
set "localMainScriptPath=%scriptsDirectory%\MuteActiveWindow.ahk"

:: Specify the full path to the local CustomPointers.txt file
set "localCustomPointersPath=%configDirectory%\CustomPointers.txt"

:: Ensure that the local directories exist (Scripts and Config folders)
md "%scriptsDirectory%" 2>nul
md "%configDirectory%" 2>nul

:: Prompt the user to confirm CustomPointers.txt update
choice /C 12 /M "Do you want to update CustomPointers.txt? (1 for Yes, 2 for No)"
if errorlevel 2 (
    echo Not updating CustomPointers.txt.
    goto :continue
)

:: Download and update the CustomPointers.txt file from GitHub
curl -k -o "%localCustomPointersPath%.temp" "%githubCustomPointersURL%"

:: Compare the content of the downloaded CustomPointers.txt file with the local file
fc "%localCustomPointersPath%.temp" "%localCustomPointersPath%" > nul

if errorlevel 1 (
    echo.
    echo CustomPointers downloaded and updated.
    move /y "%localCustomPointersPath%.temp" "%localCustomPointersPath%" > nul
    echo.
) else (
    echo.
    echo CustomPointers are already on the latest version.
    del "%localCustomPointersPath%.temp"
    echo.
)

:continue
:: Start AutoHotkey
start "" /b "AutoHotkey.exe" "%localMainScriptPath%"

pause