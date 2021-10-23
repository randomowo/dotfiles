#!/bin/bash

dwm_record() {
	VAR="/var/run/user/$UID/record_pid"
    printf "%s" "$SEP1"
    [[ -f "$VAR" ]] && printf "%s" "recording"
    printf "%s\n" "$SEP2"
}

dwm_record
