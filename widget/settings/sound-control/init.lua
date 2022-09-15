local make_control   = require('widget.style.make-control')
local volume_control = require('widget.settings.sound-control.volume-control')

local control_title = wibox.widget {
	text   = 'Sound Control',
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

return make_control(control_title, volume_control)