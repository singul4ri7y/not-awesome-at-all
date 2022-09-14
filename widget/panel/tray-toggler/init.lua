local widget_icon_dir = config_dir .. 'widget/panel/tray-toggler/assets/'

local widget = wibox.widget {
	{
		id     = 'icon',
		image  = widget_icon_dir .. 'left-arrow.svg',
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
			widget.icon:set_image(gears.surface.load_uncached(widget_icon_dir .. 'left-arrow.svg'))
		else
			widget.icon:set_image(gears.surface.load_uncached(widget_icon_dir .. 'right-arrow.svg'))
		end

		screen.primary.systray.visible = not screen.primary.systray.visible
	end
end)

-- Update icon on start-up.

if screen.primary.systray and screen.primary.systray.visible then
	widget.icon:set_image(widget_icon_dir .. 'left-arrow.svg')
end

-- Show only the tray button in the primary screen.

return awful.widget.only_on_screen(widget_button, 'primary')