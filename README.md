<div align="center">
  <img src="./maw.png" alt="MAW Logo" width="150">
</div>


# MuteActiveWindow

**MuteActiveWindow** is an AutoHotkey script that allows you to mute the currently active window using a custom hotkey. **`F1` by default!**

---

This script was inspired by [kristoffer-tvera/mute-current-application](https://github.com/kristoffer-tvera/mute-current-application) but was rewritten for svcl and later custom open source solution MAW-MUTER because the previous version didn't work for me with the majority of UWP and some other apps, but I have published a fix that also fixes compatibility with UWP apps for kristoffer's script so feel free to use any of scripts.


## Table of Contents

- [Installation](#installation)
- [Customize Hotkey](#customize-hotkey)
- [Adding Exclusions](#adding-exclusions)
- [Running the Script at Startup](#running-the-script-at-startup)
  - [Automatic Startup](#automatic-startup-recommended)
  - [Manual Startup](#manual-startup)
- [Updating](#updating-your-script)
  - [Enable auto-updates](#enable-auto-updates)
  - [Manually check for updates](#manually-check-for-updates)
  - [Enable beta updates](#enable-beta-updates)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Installation

Follow these steps to set up the script:

1. Download [MuteActiveWindow](https://github.com/tfurci/MuteActiveWindow/releases) and extract it

2. Install `AutoHotkey V1` from [here](https://www.autohotkey.com/download/ahk-install.exe)

3. Start `MuteActiveWindow.ahk`

4. if you downloaded `NO-EXE` version also download muting method of your choice: 
  - [MAW-MUTER.ahk](https://github.com/tfurci/maw-muter/blob/main/maw-muter_AHK/maw-muter.ahk) (recommended and fastest)
  - [MAW-MUTER.exe](https://github.com/tfurci/maw-muter/releases)
  - [SVCL](https://www.nirsoft.net/utils/sound_volume_command_line.html)

## Customize Hotkey

Change the hotkey by editing the `Hotkey.txt` file (located in the `/Config/Hotkey.txt` directory) and replacing its contents with your desired hotkey (e.g., `F10`).

## Adding Exclusions

You can configure the script to exclude specific applications from being muted. Exclusions are useful if you want to prevent certain apps from being affected by the script. Here's how you can add exclusions:

1. Have app that you want to mute opened and focused.

2. Then press `ALTGR + ALT + P` and click YES when prompt opens.

## Running the Script at Startup

### Automatic Startup (Recommended)

1. Run `AutoEnableStartup.bat` located in the script directory. This batch file will automatically move the required files to the Startup folder for you.

Now, the script will run automatically each time you start Windows without the need for manual intervention.

### Manual Startup

1. Press `Win + R` to open the Run dialog.

2. Type `shell:startup` and press Enter. This will open the Startup folder for the current user.

3. Create a shortcut to the `MuteActiveWindow.ahk` script in this folder. You can do this by right-clicking the script file and selecting `"Create shortcut"` and then moving the shortcut to the Startup folder.

Now, the script will run automatically each time you start Windows.

## Updating Your Script
### Enable auto-updates

The script will automatically check for updates on startup by default.

If you wish to disable this behaviour then:
1. Open `Config/AutoUpdateCheck.txt`.
2. Change first line from `1` to `0`.
3. Reload the script to apply changes.

### Manually check for updates

1. Right click on MuteActiveWindow icon in taskbar
2. When menu displays click on `Check for updates`

### Enable beta updates
1. Open `Config/EnableBetaUpdates.txt`.
2. Change first line from `0` to `1`
3. Reload the script and if beta update is available prompt to update will be displayed.

## License

This project is licensed under the [GNU General Public License version 3 (GPL-3.0)](LICENSE).

## Acknowledgments

- [AutoHotkey](https://www.autohotkey.com/)
- [MAW-MUTER](https://github.com/tfurci/maw-muter/)
- [svcl](https://www.nirsoft.net/utils/sound_volume_command_line.html)
