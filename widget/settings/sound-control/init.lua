local make_box               = require('widget.style.make-box')
local volume_control_master  = require('widget.settings.sound-control.volume-control-master')
local volume_control_capture = require('widget.settings.sound-control.volume-control-capture')
local sound_options          = require('widget.settings.sound-control.sound-options')

local control_title = wibox.widget {
	text   = 'Sound Control',
	font   = 'Cantarell Regular 13',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

return make_box(control_title, {
	volume_control_master,
	volume_control_capture,
	sound_options,

	layout = wibox.layout.fixed.vertical
})