#!/bin/bash

mode_file="$HOME/.mode"
scriptsDir="$HOME/.config/hypr/scripts"
wallpaper_dir="$HOME/.config/hypr/Wallpaper"
wallpaper="$wallpaper_dir/current_wallpaper"

# Transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# swww query || swww init && swww img ${wallpaper} $SWWW_PARAMS

if [ ! -f "$mode_file" ]; then
    ${scriptsDir}/toggle_dark_light.sh
elif [ -f "$wallpaper_dir/current_wallpaper" ]; then
    swww query || swww init && swww img ${wallpaper} $SWWW_PARAMS
else
    ${scriptsDir}/Wallpaper.sh
fi

sleep 0.5
${scriptsDir}/pywal.sh
sleep 0.2
${scriptsDir}/Refresh.sh