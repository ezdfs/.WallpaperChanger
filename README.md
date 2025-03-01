# Wallpaper Changer for Ubuntu

## Overview

The **Wallpaper Changer** is a Bash script that automatically changes the wallpaper on Ubuntu at a specified interval. It supports both light and dark themes and allows users to configure the wallpaper directory and time interval.

## Features

- Automatically changes the wallpaper at a set interval
- Supports both light and dark themes
- Configurable wallpaper directory
- User-friendly menu for modifying settings
- Displays notifications if errors occur (e.g., missing wallpaper directory or empty folder)

## Installation

1. Clone or download the script to your preferred directory:
   ```bash
   git clone https://github.com/ezdfs/.WallpaperChanger.git
   cd ~/.WallpaperChanger
   ```
2. Make the scripts executable:
   ```bash
   chmod +x changer.sh config.sh
   ```
3. Run the configuration menu to set the wallpaper directory and interval(default directory: ~/Wallpapers; default time: 300s):
   ```bash
   ./config.sh
   ```

## Configuration

Settings are stored in the `var.sh` file:

```bash
WALLPAPER_DIR="Wallpapers"  # Directory containing wallpapers
TIME="300"  # Time interval in seconds
IMAGE_INDEX=0  # Current wallpaper index
```

To modify these settings manually, edit `var.sh` with a text editor.

Alternatively, use the interactive menu by running:

```bash
./config.sh
```

## Usage: add in startup application

- Name: Wallpaper Changer
- Command(find the directory where scripts are in your machine): ~/.WallpaperChanger/changer.sh
- Description(Optional): Wallpaper Changer

![image](https://github.com/user-attachments/assets/c48c0287-aa0f-4d8d-a972-951981976ec7)

![image](https://github.com/user-attachments/assets/6ef6bb25-46e3-4e47-b8d3-670782ccddad)


## Notifications

If an error occurs, the script will notify the user:

- **"Wallpaper directory does not exist. Exiting script."** – Ensure the specified directory exists.
- **"No images found in the wallpaper directory. Exiting script."** – Add images to the wallpaper directory.

## Requirements

- Ubuntu with GNOME desktop environment
- `gsettings` command-line tool for changing wallpapers
- Bash shell

## License

This project is licensed under the GNU Licenses.
