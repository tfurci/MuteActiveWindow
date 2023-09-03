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
- [Customize Hotkey](#customize-hotkey)
- [Adding Exclusions](#adding-exclusions)
- [Running the Script at Startup](#running-the-script-at-startup)
  - [Automatic Startup](#automatic-startup)
  - [Manual Startup](#manual-startup)
- [Updating](#updating-your-script-and-pairs)
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

## Customize Hotkey

Change the hotkey by editing the "Hotkey.txt" file (located in the same Config directory) and replacing its contents with your desired hotkey (e.g., "F10").

## Adding Exclusions

You can configure the script to exclude specific applications from being muted. Exclusions are useful if you want to prevent certain apps from being affected by the script. Here's how you can add exclusions:

1. Open the `ExcludedApps.txt` file located in the "Config" folder.

2. Add the names of the applications you want to exclude, all on the same line, separated by a semicolon `;`, in the following format:

app1.exe;app2.exe

Replace `app1.exe` and `app2.exe` with the actual names of the executable files you want to exclude.

3. Save the `ExcludedApps.txt` file.

4. Restart the script (or press the hotkey if it's already running) for the changes to take effect.

Now, the specified applications will be excluded from the script's muting behavior.

**Example:**

Suppose you want to exclude Spotify (`Spotify.exe`) and Brave (`Brave.exe`) from being muted. Your `ExcludedApps.txt` file would look like this:

Spotify.exe;Brave.exe

This will ensure that the script doesn't mute Spotify and Brave when the hotkey is pressed.

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

## License

This project is licensed under the [GNU General Public License version 3 (GPL-3.0)](LICENSE).

## Acknowledgments

- [AutoHotkey](https://www.autohotkey.com/)
- [svcl](https://www.nirsoft.net/utils/sound_volume_command_line.html)
