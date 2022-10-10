local id = require('config.user.id')

return {
	terminal = 'alacritty',
	browser  = 'brave --enable-features=VaapiVideoEncoder --process-per-site',
	editor   = 'alacritty --title NeoVIm -e nvim',
	game     = 'lutris',
	sandbox  = 'virt-manager',
	dev      = 'code',
	media    = 'vlc --started-from-file',
	sysmon   = 'alacritty --title "System Monitor" -e htop',
	sshot    = 'flameshot launcher',
	files    = 'thunar',
	rofi     = 'rofi -dpi ' .. screen.primary.dpi .. ' -show drun -theme ' .. config_dir .. 'config/rofi.rasi',
	network  = 'nm-connection-editor',
	lock     = 'i3lock-fancy --font "Cantarell" --text "Authentication required for user \'' .. id.username .. '\'"',
	quake    = 'alacritty --title QuakeTerminal',
	social   = 'discord'
}