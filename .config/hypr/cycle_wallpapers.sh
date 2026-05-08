#!/bin/bash
WALLPAPER_DIR="/home/azsesa/custom_wallpapers/photos"
WALLPAPERS=($WALLPAPER_DIR/*)
while true; do
    for wallpaper in "${WALLPAPERS[@]}"; do
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$wallpaper"
        hyprctl hyprpaper wallpaper ",$wallpaper"
        sleep 60  # Change the duration (in seconds) as needed
    done
done
