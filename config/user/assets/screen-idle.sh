#!/usr/bin/zsh

# Run xidlehook.

pgrep -u $USER -x xidlehook || xidlehook --not-when-fullscreen --detect-sleep --not-when-audio \
	--timer 120 \
		'brightnessctl -q set 30%' \
		'brightnessctl -q set 60%' \
	--timer 180 \
		"brightnessctl -q set 60%; (pgrep -u $USER -x i3lock || i3lock-fancy --font \"Cantarell\" --text \"Authentication required for user '$USER'\") > /dev/null" \
		'' \
	--timer 1500 \
		'systemctl suspend' \
		''