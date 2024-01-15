#!/bin/sh

# Check which waybar theme is set
THEMEIS=$(readlink -f ~/.config/waybar/style.css | cut -d '-' -f2)
rofi=$(readlink -f ~/.config/rofi/config.rasi | cut -d '-' -f2)

#if the theme is not dark then we need to switch to it
if [ $THEMEIS != "light.css" ]; then
    SWITCHTO="-light"
fi

if [ $rofi != "light.rasi" ]; then
    switch_to="-light"
fi

#change the background image and be cool about it ;)
swww img ~/.config/hypr/Wallpaper/dynamic/wallpaper$SWITCHTO.jpg --transition-fps 60 --transition-type random --transition-duration 2

#set the xfce theme
# xfconf-query -c xsettings -p /Net/ThemeName -s "theme$SWITCHTO"

#change gtk theme
gsettings set org.gnome.desktop.interface gtk-theme "theme$SWITCHTO"
# gsettings set icon-theme ""

#set the wofi theme
ln -sf ~/.config/wofi/style/style$SWITCHTO.css ~/.config/wofi/style.css

#set rofi theme
ln -sf ~/.config/rofi/themes/config$switch_to.rasi ~/.config/rofi/config.rasi

#set the waybar theme
ln -sf ~/.config/waybar/style/style$SWITCHTO.css ~/.config/waybar/style.css

#restart the waybar
killall -SIGUSR2 waybar
