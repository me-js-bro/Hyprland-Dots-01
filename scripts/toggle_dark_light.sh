#!/bin/bash

mode_file="$HOME/.mode"
wallpaper_dir_dark="$HOME/.config/hypr/Dynamic-Wallpapers/dark"
wallpaper_dir_light="$HOME/.config/hypr/Dynamic-Wallpapers/light"
vs_code_settings="$HOME/.config/Code/User/settings.json"
scriptsDir="$HOME/.config/hypr/scripts"

# Create the mode file if it doesn't exist
touch "$mode_file"

# Transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Read the current mode
current_mode=$(cat "$mode_file")

set_random_wallpaper_swww() {
    wallpaper_files=("$1"/*)
    random_wallpaper="${wallpaper_files[RANDOM % ${#wallpaper_files[@]}]}"
    swww query || swww init && swww img ${random_wallpaper} $SWWW_PARAMS
}

if [ "$current_mode" == "dark" ]; then
    # Switch to light mode

    # rofi themes will be set by pywal

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme-light"

    # set vs code theme
    sed -i 's/"workbench.colorTheme": "Theme Flat"/"workbench.colorTheme": "Atom One Light"/g' "$vs_code_settings"

    # switch wallpaper
    set_random_wallpaper_swww "$wallpaper_dir_light"
    echo "light" > "$mode_file"
else
    # Switch to dark mode

    # rofi themes will be set by pywal

    # gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "theme"

    # set vs code theme
    sed -i 's/"workbench.colorTheme": "Atom One Light"/"workbench.colorTheme": "Theme Flat"/g' "$vs_code_settings"

    # set wallpaper
    set_random_wallpaper_swww "$wallpaper_dir_dark"
    echo "dark" > "$mode_file"
fi

sleep 0.5
${scriptsDir}/pywal.sh
sleep 0.2
${scriptsDir}/Refresh.sh
