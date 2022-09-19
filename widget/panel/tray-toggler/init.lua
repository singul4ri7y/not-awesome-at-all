local icons = require('theme.icons')

local widget = wibox.widget {
	{
		id     = 'icon',
		image  = icons.left_arrow,
		widget = wibox.widget.imagebox,
		resize = true
	},

	layout = wibox.layout.align.horizontal
}

local widget_button = wibox.widget {
	{
		{
			widget,
			margins = dpi(6),
			widget = wibox.container.margin
		},

		shape  = gears.shape.circle,
		widget = require('widget.style.clickable-widget')
	},

	margins = dpi(10),
	left    = dpi(5),
	right   = dpi(15),
	widget  = wibox.container.margin
}

widget_button:buttons(gears.table.join(
	awful.button({}, 1, function()
		awesome.emit_signal('widget::systray:toggle')
	end)
))

-- Response to signal.

awesome.connect_signal('widget::systray:toggle', function()
	if screen.primary.systray then
		if not screen.primary.systray.visible then
			widget.icon:set_image(gears.surface.load_uncached(icons.left_arrow))
		else
			widget.icon:set_image(gears.surface.load_uncached(icons.right_arrow))
		end

		screen.primary.systray.visible = not screen.primary.systray.visible
	end
end)

-- Update icon on start-up.

if screen.primary.systray and screen.primary.systray.visible then
	widget.icon:set_image(icons.left_arrow)
end

local tray_toggler_tooltip = awful.tooltip {
	text       = 'Toggle system tray',
	mode       = 'outside',
	align      = 'bottom',
	delay_show = 0.5
}

tray_toggler_tooltip:add_to_object(widget_button)

-- Show only the tray button in the primary screen.

return awful.widget.only_on_screen(widget_button, 'primary')