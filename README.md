# MuteActiveWindow

**MuteActiveWindow** is an AutoHotkey script that allows you to mute the currently active window using a custom hotkey.

## Table of Contents

- [Prerequisites](#prerequisites)
  - [Required Tools](#required-tools)
  - [Additional File (Included in .rar release)](#additional-file-included-in-rar-release)
- [Installation](#installation)
- [Usage](#usage)
- [Running the Script at Startup](#running-the-script-at-startup)
  - [Automatic Startup](#automatic-startup)
  - [Manual Startup](#manual-startup)
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


## Customization

You can customize the script, including the hotkey, by editing the AutoHotkey script file (`MuteActiveWindow.ahk`). To change the hotkey, locate the following line in the script:

Line 18:
- F1::

Replace `F1` with your desired hotkey. You can refer to AutoHotkey's [documentation on hotkeys](https://www.autohotkey.com/docs/Hotkeys.htm) for more information on specifying hotkeys.

## License

This project is licensed under the [GNU General Public License version 3 (GPL-3.0)](LICENSE).

## Acknowledgments

- [AutoHotkey](https://www.autohotkey.com/)
- [svcl](https://www.nirsoft.net/utils/sound_volume_command_line.html)
