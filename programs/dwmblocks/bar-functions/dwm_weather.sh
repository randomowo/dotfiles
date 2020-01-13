#!/bin/sh

# A dwm_bar function to print the weather from wttr.in
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: curl

# Change the value of LOCATION to match your city
dwm_weather() {
    LOCATION=spb

    printf "%s" "$SEP1"
    printf "%s" "$(curl -s wttr.in/$LOCATION?format=3)"
    printf "%s\n" "$SEP2"
}

dwm_weather
