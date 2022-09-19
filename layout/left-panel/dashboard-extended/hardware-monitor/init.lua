local make_box = require('widget.style.make-box')
local icons    = require('theme.icons')
local cpu      = require('widget.status.cpu')
local ram      = require('widget.status.ram')
local temp     = require('widget.status.temp')

local cpu_title = wibox.widget {
	text   = 'CPU',
	font   = 'Cantarell Regular 13',
	align  = 'center',
	valign = 'center',
	widget = wibox.widget.textbox
}

local cpu_icon = wibox.widget {
	{
		image  = icons.chart,    -- icons.cpu
		resize = true,
		widget = wibox.widget.imagebox
	},

	widget = wibox.container.margin,
	margins = dpi(40)
}

local cpu_widget = wibox.widget {
	{
		cpu_icon,
		cpu,
		
		layout = wibox.layout.stack,
	},

	forced_width  = dpi(169),
	forced_height = dpi(169),
	widget        = wibox.container.margin,
	margins       = dpi(24)
}

local ram_title = wibox.widget {
	text   = 'RAM',
	font   = 'Cantarell Regular 13',
	align  = 'center',
	valign = 'center',
	widget = wibox.widget.textbox
}

local ram_icon = wibox.widget {
	{
		image  = icons.memory,
		resize = true,
		widget = wibox.widget.imagebox
	},

	widget = wibox.container.margin,
	margins = dpi(30)
}

local ram_widget = wibox.widget {
	{
		ram_icon,
		ram,
		
		layout = wibox.layout.stack,
	},

	forced_width  = dpi(169),
	forced_height = dpi(169),
	widget        = wibox.container.margin,
	margins       = dpi(24)
}

return wibox.widget {
	make_box(cpu_title, cpu_widget),
	make_box(ram_title, ram_widget),

	layout = wibox.layout.fixed.horizontal,
	spacing = dpi(20)
}