local make_box     = require('utils.make-box')
local blur_slider  = require('widget.settings.misc-control.blur-slider')
local misc_options = require('widget.settings.misc-control.misc-options')

local control_title = wibox.widget {
	text   = 'Miscellaneous',
	font   = 'Cantarell Regular 13',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

return make_box(control_title, {
	blur_slider,
	misc_options,

	layout = wibox.layout.fixed.vertical
})