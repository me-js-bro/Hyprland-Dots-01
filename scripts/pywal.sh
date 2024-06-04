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
        if ln -sf "$wallpaper_path" "$HOME/.config/hypr/Wallpaper/current_wallpaper"; then
            ln_success=true  # Set the flag to true upon successful execution
        fi

        break  # Exit the loop after processing the first found monitor output
    fi
done

# Check the flag before executing further commands
if [ "$ln_success" = true ]; then
    wal -i "$wallpaper_path"
fi

# Function to convert hex color code to rgba
hex_to_rgba() {
    hex=$1
    r=$(printf '%s' ${hex:1:2})
    g=$(printf '%s' ${hex:3:2})
    b=$(printf '%s' ${hex:5:2})
    a=$(printf '%s' ${hex:7:2})

    # rgba="rgba($r$g$b$a)"
    rgba="rgba($r$g$b$a"FF")"
    echo $rgba
}

# Extract colors from colors.json
colors_file=~/.cache/wal/colors.json
if [ -f $colors_file ]; then
    background_color=$(jq -r '.special.background' "$colors_file")
    foreground_color=$(jq -r '.special.foreground' "$colors_file")
    other_color=$(jq -r '.colors.color5' "$colors_file")

  # Usage example
    hex_color="$foreground_color"
    hex_color_other="$other_color"
    rgba_color=$(hex_to_rgba $hex_color)
    rgba_color_other=$(hex_to_rgba $hex_color_other)

    # Set Hyprland active border color based on foreground color
    hyprland_config=~/.config/hypr/configs/settings.conf
    sed -i "s/col.active_border .*$/col.active_border = $rgba_color/g" "$hyprland_config"
    sed -i "s/col.inactive_border .*$/col.inactive_border = $rgba_color_other/g" "$hyprland_config"

    # Reload Hyprland configuration (optional)
    hyprctl reload
else
    echo "No file found named colors.json"
fi


# Extract colors from colors.json
kitty_colors=~/.cache/wal/colors-kitty.conf
kitty=~/.config/hypr/kitty/kitty.conf
# Define a function to extract a specific color
extract_color() {
  color_keyword="$1"
  grep "^${color_keyword}" $kitty_colors | awk '{print $2}'
}

# Extract background and foreground colors
kitty_background_color=$(extract_color "background")
kitty_foreground_color=$(extract_color "foreground")

# kitty colors
sed -i "s/background .*$/background $kitty_background_color/g" "$kitty"
sed -i "s/foreground .*$/foreground $kitty_foreground_color/g" "$kitty"
kitty @ --to=unix:/tmp/kitty.sock quit

# setting rofi theme
ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/hypr/rofi/themes/rofi-pywal.rasi
ln -sf ~/.cache/wal/colors-rofi-light.rasi ~/.config/hypr/rofi/themes/rofi-pywal-light.rasi

# setting waybar colors
ln -sf ~/.cache/wal/colors-waybar.css ~/.config/hypr/waybar/style/theme.css

# setting waybar colors for wlogout
ln -sf ~/.cache/wal/colors-waybar.css ~/.config/hypr/wlogout/colors.css

# setting waybar colors for swaync
ln -sf ~/.cache/wal/colors-waybar.css ~/.config/hypr/swaync/colors.css

# Extract colors from colors.json
colors_file=~/.cache/wal/colors.json
if [ -f $colors_file ]; then
    background_color=$(jq -r '.special.background' "$colors_file")
    foreground_color=$(jq -r '.special.foreground' "$colors_file")

    # Update VS Code settings
    vscode_settings_file="$HOME/.config/Code/User/settings.json"
    cat <<EOF >"$vscode_settings_file"
{
    "editor.mouseWheelZoom": true,
    "files.autoSave": "afterDelay",
    "workbench.startupEditor": "none",
    "editor.fontSize": 20,
    "editor.fontFamily": "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace",
    "editor.fontLigatures": true,
    "workbench.colorCustomizations": {
        "editor.background": "$background_color",
        "sideBar.background": "$background_color",
        "sideBar.border": "$background_color",
        "sideBar.foreground": "$foreground_color",
        "editorGroupHeader.tabsBackground": "#191b274b",
        "activityBar.background": "$background_color",
        "activityBar.border": "$background_color",
        "activityBar.foreground": "$foreground_color",
        "tab.activeBackground": "#13151f",
        "tab.activeForeground": "#ffffff",
        "tab.activeBorder": "$background_color",
        "tab.border": "$background_color",
        "tab.inactiveBackground": "$background_color",
        "tab.inactiveForeground": "$foreground_color",
        "terminal.foreground": "$foreground_color",
        "terminal.background": "$background_color"
    },
    "window.menuBarVisibility": "toggle",
    "workbench.statusBar.visible": false,
    "breadcrumbs.enabled": false,
    "editor.smoothScrolling": true,
    "editor.scrollbar.vertical": "hidden",
    "editor.mouseWheelScrollSensitivity": 2,
    "editor.wordWrap": "on",
    "editor.cursorBlinking": "expand",
    "terminal.integrated.fontSize": 18,
    "workbench.colorTheme": "Theme Darker",
    "workbench.iconTheme": "material-icon-theme",
    "explorer.confirmDelete": false,
    "editor.minimap.enabled": true,
    "git.enableSmartCommit": true
}
EOF
fi

# firefox colors changine, (test)
# Extract colors from colors.json
colors_file=~/.cache/wal/colors.json
if [ -f $colors_file ]; then
    background_color=$(jq -r '.special.background' "$colors_file")
    foreground_color=$(jq -r '.special.foreground' "$colors_file")

    # Function to get the Firefox profile directory
get_firefox_profile_dir() {
    local profile_dir
    profile_dir=$(find "$HOME/.mozilla/firefox/" -maxdepth 1 -type d -name '*.default-release' -print -quit)
    echo "$profile_dir"
}

# Get the Firefox profile directory
firefox_profile_dir=$(get_firefox_profile_dir)

if [ -z "$firefox_profile_dir" ]; then
    echo "Firefox profile directory not found. Exiting script."
    exit 1
fi
    firefox_chrome_dir="$firefox_profile_dir/chrome"

    # Create the chrome directory if it doesn't exist
    mkdir -p "$firefox_chrome_dir"

    # Create or append to the userChrome.css file
    firefox_css_file="$firefox_chrome_dir/userChrome.css"
    touch $firefox_css_file
    cat <<EOF >"$firefox_css_file"
/* userChrome.css */
:root {
    --background-color: $background_color !important;
    --foreground-color: $foreground_color !important;
    --toolbar-bgcolor: $background_color !important;
    --toolbar-color: $foreground_color !important;
}

#nav-bar { background-color: var(--toolbar-bgcolor) !important; color: var(--toolbar-color) !important; }
#navigator-toolbox { background-color: var(--background-color) !important; color: var(--foreground-color) !important; }

/* Set home page background color */
#home-button { background-color: var(--toolbar-bgcolor) !important; }

/* Set background color for the entire browser window */
@-moz-document url-prefix("chrome://browser/content/browser.xhtml") {
    #browser {
        background-color: var(--background-color) !important;
    }
}
EOF

    # Restart Firefox to apply changes
    # pkill firefox
fi

# ------------------------