#!/bin/bash

case $1 in
    fb)
        brave-browser --app=https://www.facebook.com
        ;;
    yt)
        brave-browser --app=https://www.youtube.com
        ;;
    ai)
        brave-browser --app=https://chat.openai.com
        ;;
    wapp)
        brave-browser --app=https://web.whatsapp.com
        ;;
    github)
        brave-browser --app=https://github.com
        ;;
esac