#!/bin/sh

# Check which waybar theme is set
rofi=$(readlink -f ~/.config/rofi/config.rasi | cut -d '-' -f2)
alacritty=$(readlink -f ~/.config/alacritty/alacritty.toml | cut -d '-' -f2)

# waybar
waybar_style=$(readlink -f ~/.config/waybar/style.css | cut -d '-' -f2)

# vs code settings
vs_code_settings=~/.config/Code/User/settings.json

#if the theme is not dark then we need to switch to it
if [ $rofi != "light.rasi" ]; then
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

# change alacritty theme
ln -sf ~/.config/alacritty/themes/alacritty$SWITCHTO.toml ~/.config/alacritty/alacritty.toml

# change vs code theme
if [ $rofi != "light.rasi" ]; then
    sed -i 's/"Theme Flat"/"Atom One Light"/g' "$vs_code_settings"
else
    sed -i 's/"Atom One Light"/"Theme Flat"/g' "$vs_code_settings"
fi

#restart the waybar
killall -SIGUSR2 waybar
