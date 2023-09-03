# MuteActiveWindow

**MuteActiveWindow** is an AutoHotkey script that allows you to mute the currently active window using a custom hotkey.

## Prerequisites

Before using this script, make sure you have the required tools and files in place.

### Required Tools

- [AutoHotkey](https://www.autohotkey.com/): If not already installed, download and install AutoHotkey to run the script.

### Additional File

- Download the `svcl.exe` tool from [here](https://www.nirsoft.net/utils/sound_volume_command_line.html) and place it in the same directory as the AutoHotkey script (`MuteActiveWindow.ahk`).

## Installation

Follow these steps to set up the script:

1. Clone or download this repository to your computer.

2. Place the `svcl.exe` tool in the same directory as the AutoHotkey script (`MuteActiveWindow.ahk`).

## Usage

To mute the active window, use the predefined hotkey (you can customize it in the script). When you press the hotkey, the active window's audio will be muted.

## Running the Script at Startup

You can choose to run the script at startup either automatically or manually.

### Automatic Startup

1. Press `Win + R` to open the Run dialog.

2. Type `shell:startup` and press Enter. This will open the Startup folder for the current user.

3. Create a shortcut to the `MuteActiveWindow.ahk` script in this folder. You can do this by right-clicking the script file and selecting "Create shortcut," then move the shortcut to the Startup folder.

Now, the script will run automatically each time you start Windows.

### Manual Startup

To manually start the script when needed, simply double-click the `MuteActiveWindow.ahk` script file.

## Customization

You can customize the script by editing the AutoHotkey script file (`MuteActiveWindow.ahk`). You can change the hotkey, adjust settings, or modify the behavior as needed.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

- [AutoHotkey](https://www.autohotkey.com/)
- [svcl](https://www.nirsoft.net/utils/sound_volume_command_line.html)
