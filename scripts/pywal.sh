#!/bin/bash

# Define the path to the swww cache directory
cache_dir="$HOME/.cache/swww/"

# Get a list of monitor outputs
monitor_outputs=($(ls "$cache_dir"))

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Loop through monitor outputs
for output in "${monitor_outputs[@]}"; do
    # Construct the full path to the cache file
    cache_file="$cache_dir$output"

    # Check if the cache file exists for the current monitor output
    if [ -f "$cache_file" ]; then
        # Get the wallpaper path from the cache file
        wallpaper_path=$(cat "$cache_file")

        # Copy the wallpaper to the location Rofi can access
        if ln -sf "$wallpaper_path" "$HOME/.config/current_wallpaper"; then
            ln_success=true  # Set the flag to true upon successful execution
        fi

        break  # Exit the loop after processing the first found monitor output
    fi
done

# Check the flag before executing further commands
if [ "$ln_success" = true ]; then
    wal -i "$wallpaper_path"
fi

# Extract colors from colors.json
colors_file=~/.cache/wal/colors.json
if [ -f $colors_file ]; then
    background_color=$(jq -r '.special.background' "$colors_file")
    foreground_color=$(jq -r '.special.foreground' "$colors_file")
else
    echo "No file found named colors.json"
fi

kitty=~/.config/hypr/kitty/kitty.conf

# kitty colors
sed -i "s/background .*$/background $background_color/g" "$kitty"
sed -i "s/foreground .*$/foreground $foreground_color/g" "$kitty"
kitty @ --to=unix:/tmp/kitty.sock quit

# setting rofi theme
ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/hypr/rofi/themes/rofi-pywal.rasi

# ------------------------