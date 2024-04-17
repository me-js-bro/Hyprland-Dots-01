#!/usr/bin/env bash

# for arch linux
if [ -f /etc/arch-release ]; then
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
    ofc=`checkupdates | wc -l`

    # Calculate total available updates
    upd=$(( ofc + aur + fpk ))

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
       # notify-send "\" Packages are up to date\""
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official $ofc\n󱓾 AUR $aur$fpk_disp\"}"
        notify-send "\"󱓽 Updates Available: $upd\""
    fi

    update_packages() {
        kitty --title systemupdate sh -c "${aurhlpr} -Syu $fpk_exup"

        sleep 3

        if [ $upd -eq 0 ] ; then
            notify-send "Packages updated successfully"
        else
            notify-send "Couldnot update your packages."
        fi
}

# for fedora
elif [ -f /etc/fedora-release ]; then

    # Calculate total available updates fedora
    upd=$(dnf check-update -q | wc -l)

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
       # notify-send "\" Packages are up to date\""
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Updates Available: $upd\"}"
        notify-send "\"󱓽 Updates Available: $upd\""
    fi

    sleep 1

    update_packages() {
        kitty --title systemupdate sh -c "sudo dnf update -y"

        sleep 2

        if ((upd == 0)); then
            notify-send "Packages updated successfully"
        elif ((upd >= 1)); then
            notify-send "Some packages were skipped..."
        else
            notify-send "Could not update your packages."
        fi
}

# opensuse ( not sure if it works or not )
elif [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "opensuse-tumbleweed" ]]; then
        # Use zypper list-updates to get the list of available updates
        updates=$(zypper lu)

        # Count the number of available updates
        ofc=$(echo "$updates" | grep -c "v |")

        # Calculate total available updates
        upd=$(( ofc ))

        # Show tooltip
        if [ $upd -eq 0 ] ; then
            echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
        else
            echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Updates $ofc\n\"}"
        fi

        update_packages() {
                kitty --title systemupdate sh -c "sudo zypper up"
                
                if [ $upd -eq 0 ] ; then
                    dunstify "Packages updated successfully!"
                else
                    dunstify "Couldnot update your packages."
                fi
        }
    fi

fi


# Trigger upgrade
if [ "$1" == "up" ] ; then
    update_packages
fi

