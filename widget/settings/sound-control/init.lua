local make_control           = require('widget.style.make-control')
local volume_control_master  = require('widget.settings.sound-control.volume-control-master')
local volume_control_capture = require('widget.settings.sound-control.volume-control-capture')

local control_title = wibox.widget {
	text   = 'Sound Control',
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

return make_control(control_title, {
	volume_control_master,
	volume_control_capture,

	layout = wibox.layout.fixed.vertical
})