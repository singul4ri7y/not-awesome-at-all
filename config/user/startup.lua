return {
	'picom -b --experimental-backends --dbus --config ' .. config_dir .. 'config/picom.conf',
	'redshift-gtk -l 24.892222:91.888938 -t 6000:4500',
	'nm-applet --indicator',
	'blueman-applet',
	'ibus-daemon --xim',
	'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1',
	-- 'xfce4-power-manager',
	'copyq --start-server',
	--'conky -c ~/.config/conky/Graffias/Graffias.conf'
	--'xidlehook'
}