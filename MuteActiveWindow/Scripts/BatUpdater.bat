@echo off
setlocal enabledelayedexpansion

:: Set the GitHub raw URL
set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/Scripts/UpdateMAW.bat"

REM Fetch the raw text of the updated script from GitHub
curl -k -o UpdatedMAW.bat %githubRawURL%

REM Check if the download was successful
if not exist UpdatedMAW.bat (
    echo Failed to download updated script from GitHub.
    pause
)

REM Compare the old and new script files
fc /b UpdateMAW.bat UpdatedMAW.bat > nul

REM Check if the files are the same (exit code 0) or different (exit code 1)
if errorlevel 1 (
    echo Script is different. Updating...
    move /y UpdatedMAW.bat UpdateMAW.bat
    echo Script updated successfully. Running updated script...
    call UpdateMAW.bat
    exit /b 0
) else (
    echo Script is already up to date.
    del UpdatedMAW.bat
    pause
    exit /b 0
)