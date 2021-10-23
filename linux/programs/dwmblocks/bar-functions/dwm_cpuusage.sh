#!/bin/bash

# a dwm_bar function to read the cpu usage
# Korolev Denis <randomowo@ya.ru>
# GNU GPLv3

dwm_cpuusage() {
	USAGE=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1}')
	
	printf "%s" "$SEP1"
	printf " %s%%" "$USAGE"
	printf "%s\n" "$SEP2"
}

dwm_cpuusage
