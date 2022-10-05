local clickable_widget = require('widget.style.clickable-widget')

return function(scr) 
	local layout_box = wibox.widget {
		{
			awful.widget.layoutbox(scr),

			margins = dpi(15),
			widget  = wibox.container.margin
		},

		widget = clickable_widget
	}

	layout_box:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),        -- Left mouse button.
		awful.button({}, 4, function() awful.layout.inc(1) end),        -- Scroll up.
		awful.button({}, 3, function() awful.layout.inc(-1) end),       -- Right mouse button.
		awful.button({}, 5, function() awful.layout.inc(-1) end)        -- Scroll down.
	))

	return layout_box
end