#!/bin/bash

mode_file="$HOME/.mode"
scriptsDir="$HOME/.config/hypr/scripts"

# Read the current mode
current_mode=$(cat "$mode_file")

if [ ! -f "$mode_file" ]; then
    ${scriptsDir}/toggle_dark_light.sh
else
    ${scriptsDir}/Wallpaper.sh
fi