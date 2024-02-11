#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_layouts="$HOME/.config/hypr/waybar/configs"
waybar_config="$HOME/.config/hypr/waybar/config"
waybar_styles="$HOME/.config/hypr/waybar/style"
waybar_style="$HOME/.config/hypr/waybar/style.css"
script_dir="$HOME/.config/hypr/scripts"
rofi_config="$HOME/.config/hypr/rofi/themes/rofi-waybar.rasi"
environment_config="$HOME/.config/hypr/configs/environment.conf"

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
    layout_file="$waybar_layouts/$1"
    style_file="$waybar_styles/$1.css"

    ln -sf "$layout_file" "$waybar_config"
    ln -sf "$style_file" "$waybar_style"

    # Check if style is "(bot)-style-3" and CSS file is "(bot)-style-3.css"
    # if [[ "$1" == "(bot)-style-3" && "$style_file" == "$HOME/.config/hypr/waybar/style/(bot)-style-3.css" ]]; then
    #     sed -i 's/#blurls=waybar/blurls=waybar/g' "$environment_config"
    # else
    #     sed -i 's/blurls=waybar/#blurls=waybar/g' "$environment_config"
    # fi

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

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main

"${script_dir}/Refresh.sh"
