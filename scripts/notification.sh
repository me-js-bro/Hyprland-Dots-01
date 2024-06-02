#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <notification message> <sound file>"
  exit 1
fi

# Notification message
MESSAGE=$1

# Sound file path
SOUND_FILE=$2

# Send notification
notify-send "$MESSAGE"

# Play sound
paplay "$SOUND_FILE"
