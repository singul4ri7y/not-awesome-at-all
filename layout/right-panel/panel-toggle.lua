local icons            = require('theme.icons')
local clickable_widget = require('widget.style.clickable-widget')

return function(scr)
	local widget = wibox.widget {
		{
			{
				id     = 'icon',
				image  = gears.surface(icons.notification),
				resize = true,
				widget = wibox.widget.imagebox
			},

			margins = dpi(13),
			widget  = wibox.container.margin
		},

		widget = clickable_widget
	}

	widget:buttons(gears.table.join(
		awful.button({}, 1, nil, function()
			scr:emit_signal('panel:right::toggle', widget)
		end)
	))

	widget.tooltip = awful.tooltip {
		text       = 'Open notification center',
		mode       = 'inside',
		align      = 'bottom',
		delay_show = 0.5
	}

	widget.tooltip:add_to_object(widget)
	
	scr:connect_signal('widget:right_panel_toggle::opened', function()
		widget.tooltip:set_text('Close notification center')

		widget:get_children_by_id('icon')[1]:set_image(gears.surface(icons.close))
	end)
	
	scr:connect_signal('widget:right_panel_toggle::closed', function()
		widget.tooltip:set_text('Open notification center')

		widget:get_children_by_id('icon')[1]:set_image(gears.surface(icons.notification))
	end)

	return widget
end