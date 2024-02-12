#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

hypr_dir="$HOME/.config/hypr"
hypr_configs="$hypr_dir/configs"
scripts="$hypr_dir/scripts"
rofi="$hypr_dir/rofi/themes"
swaylock="$hypr_dir/swaylock"
swaync="$hypr_dir/swaync"
waybar="$hypr_dir/waybar"
wlogout="$hypr_dir/wlogout"

menu(){
  printf "1. Edit Hyprland Configs\n"
  printf "2. Edit Scripts\n"
  printf "3. Edit Rofi Themes\n"
  printf "4. Edit Swaylock\n"
  printf "5. Edit Swaync\n"
  printf "6. Edit Waybar\n"
  printf "7. Edit Wlogout\n"
}

if dnf list installed code &>> /dev/null; then
    editor="code"
else
    notify-send "Opening with Neovim"

    editor="nvim"
fi

main() {
    choice=$(menu | rofi -dmenu -config ~/.config/hypr/rofi/themes/rofi-edit-dots.rasi | cut -d. -f1)
    case $choice in
        1)
            $editor $hypr_configs
            ;;
        2)
            $editor $scripts
            ;;
        3)
            $editor $rofi
            ;;
        4)
            $editor $swaylock
            ;;
        5)
            $editor $swaync
            ;;
        6)
            $editor $waybar
            ;;
        7)
            $editor $wlogout
            ;;
        *)
            ;;
    esac
}

main