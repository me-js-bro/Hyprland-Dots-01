#!/bin/sh

# Check which waybar theme is set
THEMEIS=$(readlink -f ~/.config/waybar/style.css | cut -d '-' -f2)

# vs code settings
vs_code_settings=~/.config/Code/User/settings.json

#if the theme is not dark then we need to switch to it
if [ $THEMEIS != "light.css" ]; then
    SWITCHTO="-light"
fi

#change the background image and be cool about it ;)
swww img ~/.config/hypr/Wallpaper/dynamic/wallpaper$SWITCHTO.jpg --transition-fps 60 --transition-type random --transition-duration 2

#set the xfce theme
# xfconf-query -c xsettings -p /Net/ThemeName -s "theme$SWITCHTO"

#change gtk theme
gsettings set org.gnome.desktop.interface gtk-theme "theme$SWITCHTO"

#set the wofi theme
ln -sf ~/.config/wofi/style/style$SWITCHTO.css ~/.config/wofi/style.css

#set rofi theme
ln -sf ~/.config/rofi/themes/config$SWITCHTO.rasi ~/.config/rofi/config.rasi

#set the waybar theme
ln -sf ~/.config/waybar/style/style$SWITCHTO.css ~/.config/waybar/style.css

# change alacritty theme
ln -sf ~/.config/alacritty/themes/alacritty$SWITCHTO.toml ~/.config/alacritty/alacritty.toml

# change kitty theme
ln -sf ~/.config/kitty/themes/kitty$SWITCHTO.conf ~/.config/kitty/kitty.conf

# change vs code theme
if [ $THEMEIS != "light.css" ]; then
    sed -i 's/"workbench.colorTheme": "Theme Flat"/"workbench.colorTheme": "Atom One Light"/g' "$vs_code_settings"
else
    sed -i 's/"workbench.colorTheme": "Atom One Light"/"workbench.colorTheme": "Theme Flat"/g' "$vs_code_settings"
fi

#restart the waybar
killall -SIGUSR2 waybar
