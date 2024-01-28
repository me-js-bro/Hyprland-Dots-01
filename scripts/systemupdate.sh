#!/usr/bin/env bash

# source variables
ScrDir=`dirname $(realpath $0)`
source $ScrDir/globalcontrol.sh

# Check for updates
get_aurhlpr
aur=`${aurhlpr} -Qua | wc -l`

# Check for flatpak updates
if pkg_installed flatpak ; then
    fpk=`flatpak remote-ls --updates | wc -l`
    fpk_disp="\n󰏓 Flatpak $fpk"
    fpk_exup="; flatpak update"
else
    fpk=0
    fpk_disp=""
fi

if [ -f /etc/arch-release ]; then
    ofc=`checkupdates | wc -l`

    # Calculate total available updates
    upd=$(( ofc + aur + fpk ))

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official $ofc\n󱓾 AUR $aur$fpk_disp\"}"
    fi

    update_packages() {
        kitty --title systemupdate sh -c "${aurhlpr} -Syu $fpk_exup"
        dunstify "Packages updated successfully!"
}

elif [ -f /etc/fedora-release ]; then
    ofc=`dnf check-update | grep | wc -l`

    # Calculate total available updates
    upd=$(( ofc ))

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official $ofc\"}"
    fi

    update_packages() {
        kitty --title systemupdate sh -c "sudo dnf update -y"
        dunstify "Packages updated successfully!"
}

fi


# Trigger upgrade
if [ "$1" == "up" ] ; then
    update_packages
fi

