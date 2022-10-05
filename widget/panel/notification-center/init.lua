local dont_disturb = require('widget.panel.notification-center.dont-disturb')
local clear_all    = require('widget.panel.notification-center.clear-all')
local notifbox_layout = require('widget.panel.notification-center.build').notifbox_layout

local notif_center = function(scr)
	local notif_header = wibox.widget {
		text   = 'Notification Center',
		screen = scr,
		font   = 'Cantarell Bold 16',
		align  = 'left',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local line_separator = wibox.widget {
		orientation   = 'horizontal',
		forced_height = dpi(1),
		span_ratio    = 2.0,
		color         = beautiful.groups_title_bg,
		widget        = wibox.widget.separator
	}

	return wibox.widget {
		{
			notif_header,
			nil,
			
			{
				dont_disturb,
				clear_all,
				
				layout  = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
			},
			
			layout = wibox.layout.align.horizontal,
		},

		line_separator,
		notifbox_layout,
		line_separator,

		spacing = dpi(10),
		layout  = wibox.layout.fixed.vertical
	}
end

return notif_center