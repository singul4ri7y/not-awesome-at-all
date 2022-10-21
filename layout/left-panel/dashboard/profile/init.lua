local id = require('config.user.id')

-- The profile picture.

local profile_image = wibox.widget {
	{
		image      = id.profile,
		clip_shape = gears.shape.circle,
		widget     = wibox.widget.imagebox
	},

	widget        = wibox.container.background,
	border_width  = dpi(1),
	forced_width  = dpi(75),
	forced_height = dpi(75),
	shape         = gears.shape.circle,
	border_color  = beautiful.fg_normal .. '88'
}

-- User fullname widget.

local fullname = wibox.widget {
	widget = wibox.widget.textbox,
	markup = id.fullname,
	font   = default_font .. 'Medium 13',
	align  = 'left',
	valign = 'center'
}

-- Username.

local username = wibox.widget {
	widget = wibox.widget.textbox,
	markup = '@' .. id.username,
	font   = default_font .. 'Light 11',
	align  = 'left',
	valign = 'center'
}

return wibox.widget {
	profile_image,

	{
		nil,

		{
			fullname,
			username,

			layout  = wibox.layout.fixed.vertical,
			spacing = dpi(2)
		},

		layout = wibox.layout.align.vertical,
		expand = 'none'
	},

	layout  = wibox.layout.fixed.horizontal,
	spacing = dpi(15)
}