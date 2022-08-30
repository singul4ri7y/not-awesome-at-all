local clickable_widget = require('widget.style.clickable-widget')
local icons = require('theme.icons')

local add_button = wibox.widget {
	{
		{
			{
				{
					image = icons.plus,
					resize = true,
					widget = wibox.widget.imagebox
				},

				margins = dpi(6),
				widget = wibox.container.margin
			},

			widget = clickable_widget
		},

		bg     = beautiful.transparent,
		shape  = gears.shape.circle,
		widget = wibox.container.background
	},

	margins = dpi(6),
	widget  = wibox.container.margin
}

add_button:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		awful.spawn(awful.screen.focused().selected_tag.default_app, {
			tag = mouse.screen.selected_tag
		})
	end)
))

return add_button