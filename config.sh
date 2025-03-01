#!/bin/bash

# Script directory
DIR=$(dirname "$(realpath "$0")")

# Vars directory
VARS="$DIR/var.sh"

# Load vars
source "$VARS"

# Colors
GREEN="\033[0;32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

# Messages
SUCESSFULLY_MESSAGE="${GREEN}Successfully updated!${RESET}"
WARNING_MESSAGE="${YELLOW}Changes will take effect on the next image change or after restarting your laptop.${RESET}"
EMPTY_MESSAGE="${RED}Input cannot be empty!${RESET}"
FAILED_MESSAGE="${RED}Update failed!${RESET}"
INVALID_TIME_MESSAGE="${RED}Time must be a valid positive integer!${RESET}"

# Show menu
show() {
    clear
    echo -e "${YELLOW}Wallpaper Changer${RESET}"
    echo ""
    echo -e "1) Change the wallpaper directory (current: $WALLPAPER_DIR)"
    echo -e "2) Change the time interval (current: $TIME)"
    echo -e "e) Exit"
}

# Update the variable
update() {
    # Name of variable
    local var_name="$1"

    # Prompt to set a new value
    local prompt_message="$2"
    echo -n "$prompt_message"

    # New value for var
    read new_value

    # Verify if new_value is empty
    if [ -z "$new_value" ]; then
        echo -e "$EMPTY_MESSAGE"
        return
    fi

    # Special validation for TIME variable
    if [ "$var_name" == "TIME" ]; then
        if [[ "$new_value" =~ ^[0-9]+$ ]]; then
            if [ "$new_value" -gt 0 ]; then
                # Update the variable in the file
                sed -i "s/^$var_name=.*/$var_name=\"$new_value\"/" "$VARS"
                echo -e "$WARNING_MESSAGE"
                echo -e "$SUCESSFULLY_MESSAGE"
            else
                echo -e "$INVALID_TIME_MESSAGE"
            fi
        else
            echo -e "$INVALID_TIME_MESSAGE"
        fi
    else
        # Update the variable in the file
        sed -i "s/^$var_name=.*/$var_name=\"$new_value\"/" "$VARS"
        echo -e "$WARNING_MESSAGE"
        echo -e "$SUCESSFULLY_MESSAGE"
    fi
}

# Main function
while true; do
    # Show menu
    show

    # Read choice
    read -r choice

    # Handle the user's choice
    case "$choice" in
        1)
            update "WALLPAPER_DIR" "New wallpaper directory (current: $WALLPAPER_DIR): "
            ;;
        2)
            update "TIME" "New time interval in seconds (current: $TIME): "
            ;;
        e)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${RED}$choice is not a valid choice.${RESET}"
            echo ""
            ;;
    esac

    # Pause to view result
    echo -n "Press enter to continue..."
    read -r
done