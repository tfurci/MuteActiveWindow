@echo off
setlocal enabledelayedexpansion

:: Specify the URL of the raw script on GitHub
set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/Config/CustomPointers.txt"

:: Specify the root directory where the script is currently located
set "scriptDirectory=%~dp0"

:: Specify the "Config" directory relative to the script directory
set "configDirectory=%scriptDirectory%..\Config"

:: Specify the full path to the local script file
set "localFilePath=%configDirectory%\CustomPointers.txt"

:: Ensure that the local directory exists (Config folder)
md "%configDirectory%" 2>nul

:: Prompt the user to confirm updating custom pairs
choice /C 12 /M "Do you want to update custom pairs? (1 for Yes, 2 for No)"
if errorlevel 2 (
    echo Not updating custom pairs.
    goto :skip_update
)

:: Download the script from GitHub
curl -k -o "%localFilePath%.temp" "%githubRawURL%"

:: Compare the content of the downloaded file with the local file
fc "%localFilePath%.temp" "%localFilePath%" > nul

if errorlevel 1 (
    echo.
    echo CustomPointers downloaded and updated.
    move /y "%localFilePath%.temp" "%localFilePath%" > nul
    echo.
) else (
    echo.
    echo CustomPointers are already on the latest version.
    del "%localFilePath%.temp"
    echo.
)

:skip_update
pause