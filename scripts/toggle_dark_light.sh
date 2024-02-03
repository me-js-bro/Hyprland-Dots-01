#!/bin/bash

mode_file="$HOME/.mode"
wallpaper_dir_dark="$HOME/.config/hypr/Wallpaper/Dynamic/dark"
wallpaper_dir_light="$HOME/.config/hypr/Wallpaper/Dynamic/light"
script_dir="$HOME/.config/hypr/scripts"

# Create the mode file if it doesn't exist
touch "$mode_file"

# Read the current mode
current_mode=$(cat "$mode_file")

set_random_wallpaper_swww() {
    wallpaper_files=("$1"/*)
    random_wallpaper="${wallpaper_files[RANDOM % ${#wallpaper_files[@]}]}"
    swww img "$random_wallpaper" --transition-fps 60 --transition-type random --transition-duration 2
}

if [ "$current_mode" == "dark" ]; then
    # Switch to light mode

    # rofi themes will be set by pywal

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme-light"

    # switch wallpaper
    set_random_wallpaper_swww "$wallpaper_dir_light"
    echo "light" > "$mode_file"
else
    # Switch to dark mode

    # rofi themes will be set by pywal

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme"

    # set wallpaper
    set_random_wallpaper_swww "$wallpaper_dir_dark"
    echo "dark" > "$mode_file"
fi

"$script_dir/pywal.sh"