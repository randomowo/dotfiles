#!/bin/bash

# a dwm_bar function to read the cpu temp
# Korolev Denis <randomowo@ya.ru>
# GNU GPLv3

dwm_cputemp() {
	TEMP=$(sensors | grep "Package id 0" | grep -oE "[0-9]{2,3}" | xargs | cut -d" " -f1)
	TEMPICON=""	
	printf "%s" "$SEP1"
	if (( $TEMP <= 30 )); then
		TEMPICON=""
	elif (( $TEMP > 30 )) && (( $TEMP <= 50 )); then
		TEMPICON=""
	elif (( $TEMP > 50 )) && (( $TEMP <= 65 )); then
		TEMPICON=""
	elif (( $TEMP > 65 )) && (( $TEMP <= 85 )); then
		TEMPICON=""
	else 
		TEMPICON=""
	fi
	printf "%s %s℃" "$TEMPICON" "$TEMP"
	printf "%s\n" "$SEP2"
}

dwm_cputemp
