@echo off
setlocal enabledelayedexpansion

:: Get the directory where this batch script is located
set "scriptDir=%~dp0"

:: Set the GitHub raw URL
set "githubRawURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/Scripts/UpdateMAW.bat"

:: Change the working directory to the script's directory
cd /d "%scriptDir%"

:: Fetch the raw text of the updated script from GitHub
curl -k -o UpdatedMAW.bat %githubRawURL%

:: Restore the original working directory
cd /d "%~dp0"

:: Check if the download was successful
if not exist UpdatedMAW.bat (
    echo Failed to download updated script from GitHub.
    pause
)

:: Compare the old and new script files
fc /b UpdateMAW.bat UpdatedMAW.bat > nul

:: Check if the files are the same (exit code 0) or different (exit code 1)
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
In this modified script:

set "scriptDir=%~dp0" obtains the directory where the batch script is located.

cd /d "%scriptDir%" changes the working directory to the script's directory before running curl.

cd /d "%~dp0" restores the original working directory to where the script was executed.

With these changes, the UpdatedMAW.bat will be downloaded and replaced in the same directory as the batch script.





