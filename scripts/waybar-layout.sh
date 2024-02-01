#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_layouts="$HOME/.config/hypr/waybar/configs"
waybar_config="$HOME/.config/hypr/waybar/config"
waybar_styles="$HOME/.config/hypr/waybar/style"
waybar_style="$HOME/.config/hypr/waybar/style.css"
script_dir="$HOME/.config/hypr/scripts"
rofi_config="$HOME/.config/hypr/rofi/themes/wbar.rasi"

# Function to display menu options
menu() {
    options=()
    while IFS= read -r file; do
        options+=("$(basename "$file")")
    done < <(find "$waybar_layouts" -maxdepth 1 -type f -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Apply selected configuration
apply_config() {
    ln -sf "$waybar_layouts/$1" "$waybar_config"
    ln -sf "$waybar_styles/$1.css" "$waybar_style"
    restart_waybar_if_needed
}

# Restart Waybar
restart_waybar_if_needed() {
    if pgrep -x "waybar" >/dev/null; then
        killall waybar
        sleep 0.1  # Delay for Waybar to completely terminate
    fi
    "$script_dir/Refresh.sh"
}

# Main function
main() {
    choice=$(menu | rofi -dmenu -config "$rofi_config")

    if [[ -z "$choice" ]]; then
        echo "No option selected. Exiting."
        exit 0
    fi

    case $choice in
        # "no panel")
        #     pgrep -x "waybar" && pkill waybar || true
        #     ;;
        *)
            apply_config "$choice" "$choice"
            ;;
    esac
}

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main