local make_control       = require('widget.style.make-control')
local brightness_control = require('widget.settings.display-control.brightness-control')

local control_title = wibox.widget {
	text   = 'Display Control',
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

return make_control(control_title, brightness_control)