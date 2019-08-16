#!/bin/sh

TOKEN="39949ee51a8a839a494a7baac9fef8b977f260b3"

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)

if [[ "$notifications" -gt 0 ]]; then
    echo " $notifications"
else
    echo " 0"
fi
