return {
	'redshift-gtk -l 24.892222:91.888938 -t 6000:4500',
	'nm-applet --indicator',
	'blueman-applet',
	'ibus-daemon --xim',
	'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1',
	'pamac-tray',
	'flameshot',
	config_dir .. 'config/user/assets/screen-idle.sh',
	-- 'copyq --start-server',
	--'conky -c ~/.config/conky/Graffias/Graffias.conf'
}