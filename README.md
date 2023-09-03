# MuteActiveWindow

**MuteActiveWindow** is an AutoHotkey script that allows you to mute the currently active window using a custom hotkey. **F1 by default!**

---

This script was originally based on [kristoffer-tvera/mute-current-application](https://github.com/kristoffer-tvera/mute-current-application) but was rewritten because the previous version didn't work for me with the majority of UWP and some other apps.

## Table of Contents

- [Prerequisites](#prerequisites)
  - [Required Tools](#required-tools)
  - [Additional File (Included in .rar release)](#additional-file-included-in-rar-release)
- [Installation](#installation)
- [Usage](#usage)
- [Running the Script at Startup](#running-the-script-at-startup)
  - [Automatic Startup](#automatic-startup)
  - [Manual Startup](#manual-startup)
- [Updating](#updating-your-script-and-pairs)
- [Customization](#customization)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Prerequisites

Before using this script, make sure you have the required tools and files in place.

### Required Tools

- [AutoHotkey](https://www.autohotkey.com/): If not already installed, download and install AutoHotkey to run the script.

### Additional File (Included in .rar release)

- Download the `svcl.exe` tool from [here](https://www.nirsoft.net/utils/sound_volume_command_line.html) or [direct link](https://www.nirsoft.net/utils/svcl-x64.zip) and place it in the same directory as the AutoHotkey script (`MuteActiveWindow.ahk`).

## Installation

Follow these steps to set up the script:

1. Clone or download this repository to your computer.

2. If there is no svcl in directory place the `svcl.exe` tool in the same directory as the AutoHotkey script (`MuteActiveWindow.ahk`).

## Usage

To mute the active window, use the predefined hotkey (you can customize it in the script). When you press the hotkey, the active window's audio will be muted.

## Running the Script at Startup

You can choose to run the script at startup either automatically or manually.

### Automatic Startup

1. Run `AutoEnableStartup.bat` located in the script directory. This batch file will automatically move the required files to the Startup folder for you.

Now, the script will run automatically each time you start Windows without the need for manual intervention.

### Manual Startup

1. Press `Win + R` to open the Run dialog.

2. Type `shell:startup` and press Enter. This will open the Startup folder for the current user.

3. Create a shortcut to the `MuteActiveWindow.ahk` script in this folder. You can do this by right-clicking the script file and selecting "Create shortcut," then move the shortcut to the Startup folder.

Now, the script will run automatically each time you start Windows.

## Updating Your Script and Pairs

To update your MuteActiveWindow script or custom executable pairs, use the following batch files located in the script folder:

- `UpdateScript.bat`: Updates the main script.
- `UpdatePairs.bat`: Updates the custom executable pairs.

## Customization

You can customize the script, including the hotkey, by editing the AutoHotkey script file (`MuteActiveWindow.ahk`). To change the hotkey, locate the following line in the script:

[Line 18:](https://github.com/tfurci/MuteActiveWindow/blob/46dbec4f9d1ec6ccf8ee64366a5e2a258730c1fb/MuteActiveWindow.ahk#L18)
- F1::

Replace `F1` with your desired hotkey. You can refer to AutoHotkey's [documentation on hotkeys](https://www.autohotkey.com/docs/Hotkeys.htm) for more information on specifying hotkeys.

## License

This project is licensed under the [GNU General Public License version 3 (GPL-3.0)](LICENSE).

## Acknowledgments

- [AutoHotkey](https://www.autohotkey.com/)
- [svcl](https://www.nirsoft.net/utils/sound_volume_command_line.html)
