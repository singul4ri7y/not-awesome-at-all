local empty_notifbox = wibox.widget {
	layout  = wibox.layout.fixed.vertical,
	spacing = dpi(5),

	{
		nil,

		{
			image         = config_dir .. 'widget/panel/notification-center/assets/empty-notification.svg',
			resize        = true,
			forced_height = dpi(35),
			forced_width  = dpi(35),
			widget        = wibox.widget.imagebox
		},

		nil,

		expand = 'none',
		layout = wibox.layout.align.horizontal
	},

	{
		text   = 'Hawdy, no notifications now!',
		font   = 'Cantarell Bold 14',
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	},

	{
		text   = 'Come back later.',
		font   = 'Cantarell Regular 10',
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}
}

local separator_for_empty_msg =  wibox.widget {
	orientation = 'vertical',
	opacity     = 0.0,
	widget      = wibox.widget.separator
}

-- Make empty_notifbox center.

local centered_empty_notifbox = wibox.widget {
	separator_for_empty_msg,
	empty_notifbox,
	separator_for_empty_msg,

	expand = 'none',
	layout = wibox.layout.align.vertical
}

return centered_empty_notifbox