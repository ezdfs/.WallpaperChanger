#!/bin/bash

# App name
APP="Wallpaper Changer"

# Messages of notification
NOT_FOUND_FOLDER="Wallpaper directory does not exist. Exiting script."
EMPTY_FOLDER="No images found in the wallpaper directory. Exiting script."

# Infinite loop to periodically change the wallpaper
while true; do
    # Script directory
    DIR=$(dirname "$(realpath "$0")")

    # Configuration file containing variables such as time, image index, etc.
    CONFIG="$DIR/var.sh"

    # Load directories and other configuration variables
    source "$CONFIG"

    # Check if the wallpaper directory exists before proceeding
    if [ ! -d "$HOME/$WALLPAPER_DIR" ]; then
        notify-send "$APP" "$NOT_FOUND_FOLDER"
        exit 1
    fi

    # Get all wallpaper files in the directory as an array
    WALLPAPERS=("$HOME/$WALLPAPER_DIR"/*)

    # Total number of images in the folder
    NUMBER_OF_IMAGES="${#WALLPAPERS[@]}"

    # Ensure there are images in the folder
    if [ "$NUMBER_OF_IMAGES" -eq 0 ]; then
	    notify-send "$APP" "$EMPTY_FOLDER"
        exit 1
    fi

    # Current wallpaper
    WALLPAPER="${WALLPAPERS[$IMAGE_INDEX]}"

    # Set the wallpaper for the dark theme using gsettings
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"

    # Set the wallpaper for the light theme using gsettings
    gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"

    # Increment the IMAGE_INDEX (move to the next image), but don't exceed the total number of images.
    IMAGE_INDEX=$(( (IMAGE_INDEX + 1) % NUMBER_OF_IMAGES ))

    # Update the IMAGE_INDEX in the configuration file
    sed -i "s/^IMAGE_INDEX=[0-9]\+/IMAGE_INDEX=$IMAGE_INDEX/" "$CONFIG"

    # Wait for the time defined in the configuration before running again
    sleep "$TIME"
done
