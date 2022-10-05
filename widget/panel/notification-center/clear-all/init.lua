local clickable_widget = require('widget.style.clickable-widget')

local clear_all_imagebox = wibox.widget {
	{
		image         = config_dir .. 'widget/panel/notification-center/assets/clear-all.svg',
		resize        = true,
		forced_height = dpi(20),
		forced_width  = dpi(20),
		widget        = wibox.widget.imagebox,
	},

	layout = wibox.layout.fixed.horizontal
}

local clear_all_button = wibox.widget {
	{
		clear_all_imagebox,
		margins = dpi(7),
		widget = wibox.container.margin
	},

	widget = clickable_widget
}

clear_all_button:buttons(gears.table.join(
		awful.button({}, 1, nil, function()
			_G.notif_core.reset_notifbox_layout()
		end)
))

local clear_all_button_wrapped = wibox.widget {
	nil,

	{
		clear_all_button,
		
		bg     = beautiful.groups_bg, 
		shape  = gears.shape.circle,
		widget = wibox.container.background
	},

	nil,

	expand = 'none',
	layout = wibox.layout.align.vertical
}

return clear_all_button_wrapped