#!/usr/bin/env bash

# Path to the notification sound
SOUND_FILE="$HOME/.config/hypr/sounds/notification-3.wav"

# Play notification sound function
play_sound() {
    paplay "$SOUND_FILE"
}

# Listen for notifications on the D-Bus
dbus-monitor "interface='org.freedesktop.Notifications'" | while read -r line; do
    if echo "$line" | grep -q "method call"; then
        play_sound
    fi
done
