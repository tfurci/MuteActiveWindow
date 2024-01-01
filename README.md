<div align="center">
  <img src="./maw.png" alt="MAW Logo" width="150">
</div>


# MuteActiveWindow

**MuteActiveWindow** is an AutoHotkey script that allows you to mute the currently active window using a custom hotkey. **F1 by default!**

---

This script was inspired by [kristoffer-tvera/mute-current-application](https://github.com/kristoffer-tvera/mute-current-application) but was rewritten for svcl because the previous version didn't work for me with the majority of UWP and some other apps.

## Table of Contents

- [Prerequisites](#prerequisites)
  - [Required Tools](#required-tools)
- [Installation](#installation)
- [Usage](#usage)
- [Customize Hotkey](#customize-hotkey)
- [Adding Exclusions](#adding-exclusions)
- [Running the Script at Startup](#running-the-script-at-startup)
  - [Automatic Startup](#automatic-startup)
  - [Manual Startup](#manual-startup)
- [Updating](#updating-your-script-and-pairs)
  - [Automatic Update](#automatic-updates)
  - [Manual Update](#manual-updates)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Prerequisites

Before using this script, make sure you have the required tools and files in place.

### Required Tools

- [AutoHotkey](https://www.autohotkey.com/)(v1.x): If not already installed, download and install AutoHotkey to run the script.

## Installation

Follow these steps to set up the script:

1. Clone or download this repository to your computer.

2. Install AutoHotkey

3. Start `MuteActiveWindow.ahk`

4. if you downloaded `NO-EXE` version also download muting method of your choice: [MAW-MUTER](https://github.com/tfurci/maw-muter/releases)(default) or [SVCL](https://www.nirsoft.net/utils/sound_volume_command_line.html)

## Usage

To mute the active window, use the predefined hotkey (you can customize it in the script). When you press the hotkey, the active window's audio will be muted.

## Customize Hotkey

Change the hotkey by editing the `Hotkey.txt` file (located in the `/Config/Hotkey.txt` directory) and replacing its contents with your desired hotkey (e.g., `F10`).

## Adding Exclusions

You can configure the script to exclude specific applications from being muted. Exclusions are useful if you want to prevent certain apps from being affected by the script. Here's how you can add exclusions:

1. Open the `ExcludedApps.txt` file located in the "Config" folder.

2. Add the exe's of the applications you want to exclude, each on a separate line, in the following format:
   You can the app's exe with CTRL+ALT+P hotkey (on MAW v7.1.0+)

   - For executable files and UWP apps (e.g., Brave.exe, WinStore.App.exe):
     ```
     Brave.exe
     Spotify.exe
     ```

4. Save the `ExcludedApps.txt` file.

5. Reload the script (or press the hotkey if it's already running) for the changes to take effect.

Now, the specified applications will be excluded from the script's muting behavior.

## Running the Script at Startup

### Automatic Startup

1. Run `AutoEnableStartup.bat` located in the script directory. This batch file will automatically move the required files to the Startup folder for you.

Now, the script will run automatically each time you start Windows without the need for manual intervention.

### Manual Startup

1. Press `Win + R` to open the Run dialog.

2. Type `shell:startup` and press Enter. This will open the Startup folder for the current user.

3. Create a shortcut to the `MuteActiveWindow.ahk` script in this folder. You can do this by right-clicking the script file and selecting "Create shortcut," then move the shortcut to the Startup folder.

Now, the script will run automatically each time you start Windows.

## Updating Your Script and Pairs
### Automatic Updates
The script will now automatically check for updates on startup, unless you've explicitly disabled this feature in the `Config/AutoUpdateCheck.txt` file.

You can check for updates using the taskbar right click menu even with Auto-Updates disabled.

### Manual Updates
1. Visit the [MuteActiveWindow GitHub repository](https://github.com/tfurci/MuteActiveWindow).
2. Navigate to the "Releases" section.
3. Download the latest version of the script.

## License

This project is licensed under the [GNU General Public License version 3 (GPL-3.0)](LICENSE).

## Acknowledgments

- [AutoHotkey](https://www.autohotkey.com/)
- [svcl](https://www.nirsoft.net/utils/sound_volume_command_line.html)
