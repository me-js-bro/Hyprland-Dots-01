#!/usr/bin/env bash

# for arch linux
if [ -f /etc/arch-release ]; then

# Path to the sound file
SOUND_FILE="$HOME/.config/hypr/sounds/update.wav"

# Function to send notification and play sound
notify_with_sound() {
    notify-send "$1"
    paplay "$SOUND_FILE"
}

    # Check for updates
    aurhlpr=$(command -v yay || command -v paru)
    aur=$(${aurhlpr} -Qua | wc -l)

    # Check for flatpak updates
    if pkg_installed flatpak ; then
        fpk=$(flatpak remote-ls --updates | wc -l)
        fpk_disp="\n󰏓 Flatpak $fpk"
        fpk_exup="; flatpak update"
    else
        fpk=0
        fpk_disp=""
    fi
    ofc=$(checkupdates | wc -l)

    # Calculate total available updates
    upd=$(( ofc + aur + fpk ))

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
        # notify_with_sound "  Packages are up to date"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official $ofc\n󱓾 AUR $aur$fpk_disp\"}"
        notify_with_sound "󱓽 Updates Available: $upd"
    fi

    update_packages() {
        kitty --title systemupdate sh -c "${aurhlpr} -Syu $fpk_exup"

        sleep 3

        if [ $upd -eq 0 ] ; then
            notify_with_sound "Packages updated successfully"
        else
            notify_with_sound "Could not update your packages."
        fi
    }

# for fedora
elif [ -f /etc/fedora-release ]; then

# Path to the sound file
SOUND_FILE="$HOME/.config/hypr/sounds/update.wav"

# Function to send notification and play sound
notify_with_sound() {
    notify-send "$1"
    paplay "$SOUND_FILE"
}

    # Calculate total available updates fedora
    upd=$(dnf check-update -q | wc -l)

    # Show tooltip
    if [ $upd -eq 0 ] ; then
        echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
        # notify_with_sound "  Packages are up to date"
    else
        echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Updates Available: $upd\"}"
        notify_with_sound "󱓽 Updates Available: $upd"
    fi

    sleep 1

    update_packages() {
        kitty --title systemupdate sh -c "sudo dnf update -y"

        sleep 2

        if ((upd == 0)); then
            notify_with_sound "Packages updated successfully"
        elif ((upd > 0)); then
            notify_with_sound "Some packages were skipped..."
        else
            notify_with_sound "Could not update your packages."
        fi
    }

# opensuse ( not sure if it works or not )
elif [ -f /etc/os-release ]; then

# Path to the sound file
SOUND_FILE="$HOME/.config/hypr/sounds/update.wav"

# Function to send notification and play sound
notify_with_sound() {
    notify-send "$1"
    paplay "$SOUND_FILE"
}

    source /etc/os-release
    if [[ $ID == "opensuse-tumbleweed" ]]; then

        # Count the number of available updates
        ofc=$(zypper lu --best-effort | grep -c 'v |')

        # Calculate total available updates
        upd=$(( ofc ))

        # Show tooltip
        if [ $upd -eq 0 ] ; then
            echo "{\"text\":\"$upd\", \"tooltip\":\"  Packages are up to date\"}"
            # notify_with_sound "  Packages are up to date"
        else
            echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Updates Available: $upd\"}"
            notify_with_sound "󱓽 Updates Available: $upd"
        fi

        update_packages() {
            kitty --title systemupdate sh -c "sudo zypper up"

            sleep 2
                
            if ((upd == 0)); then
                notify_with_sound "Packages updated successfully"
            elif ((upd > 0)); then
                notify_with_sound "Some packages were skipped..."
            else
                notify_with_sound "Could not update your packages."
            fi
        }
    fi
fi

# Trigger upgrade
if [ "$1" == "up" ] ; then
    update_packages
fi
