#!/usr/bin/zsh

pgrep -u $USER -x picom ||
	picom -b --dbus --config ~/.config/awesome/config/picom.conf