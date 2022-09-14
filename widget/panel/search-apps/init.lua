local clickable_widget = require('widget.style.clickable-widget')
local widget_icon_dir = config_dir .. 'widget/panel/search-apps/assets/'

return function()
	local widget = wibox.widget {
		{
			id     = 'icon',
			image  = widget_icon_dir .. 'app-launcher.svg',
			widget = wibox.widget.imagebox,
			resize = true
		},

		layout = wibox.layout.align.horizontal
	}

	local widget_button = wibox.widget {
		{
			widget,
			margins = dpi(10),
			--color = '#003f6b',
			widget  = wibox.container.margin
		},

		widget = clickable_widget
	}

	widget_button:buttons(gears.table.join(
		awful.button({}, 1, nil, function()
			if screen.primary.left_panel.opened then
				screen.primary.left_panel:toggle()
			end
			
			awful.spawn('rofi -show drun', false)
		end)
	))

	return widget_button
end