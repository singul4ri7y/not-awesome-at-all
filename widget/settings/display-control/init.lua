local make_box       = require('widget.style.make-box')
local brightness_control = require('widget.settings.display-control.brightness-control')
local display_options    = require('widget.settings.display-control.display-options')

local control_title = wibox.widget {
	text   = 'Display Control',
	font   = 'Cantarell Regular 13',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

return make_box(control_title, {
	brightness_control,
	display_options,

	layout = wibox.layout.fixed.vertical
})