#!/bin/bash

case $1 in
    fb)
        chromium --app=https://www.facebook.com
        ;;
    yt)
        chromium --app=https://www.youtube.com
        ;;
    ai)
        chromium --app=https://chat.openai.com
        ;;
    wapp)
        chromium --app=https://web.whatsapp.com
        ;;
    github)
        chromium --app=https://github.com
        ;;
esac