local make_box = require('utils.make-box')
local icons    = require('theme.icons')
local cpu      = require('widget.status.cpu')
local ram      = require('widget.status.ram')
local temp     = require('widget.status.temp')
local drive      = require('widget.status.drive')

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

	forced_width  = dpi(165),
	forced_height = dpi(165),
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

	forced_width  = dpi(165),
	forced_height = dpi(165),
	widget        = wibox.container.margin,
	margins       = dpi(24)
}

local temp_title = wibox.widget {
	text   = 'Temp',
	font   = 'Cantarell Regular 13',
	align  = 'center',
	valign = 'center',
	widget = wibox.widget.textbox
}

local temp_icon = wibox.widget {
	{
		image  = icons.thermometer,
		resize = true,
		widget = wibox.widget.imagebox
	},

	widget = wibox.container.margin,
	margins = dpi(30)
}

local temp_widget = wibox.widget {
	{
		temp_icon,
		temp,
		
		layout = wibox.layout.stack,
	},

	forced_width  = dpi(165),
	forced_height = dpi(165),
	widget        = wibox.container.margin,
	margins       = dpi(24)
}

local drive_title = wibox.widget {
	text   = 'Drive (/)',
	font   = 'Cantarell Regular 13',
	align  = 'center',
	valign = 'center',
	widget = wibox.widget.textbox
}

local drive_icon = wibox.widget {
	{
		image  = icons.harddisk,
		resize = true,
		widget = wibox.widget.imagebox
	},

	widget = wibox.container.margin,
	margins = dpi(30)
}

local drive_widget = wibox.widget {
	{
		drive_icon,
		drive,
		
		layout = wibox.layout.stack,
	},

	forced_width  = dpi(165),
	forced_height = dpi(165),
	widget        = wibox.container.margin,
	margins       = dpi(24)
}

return wibox.widget {
	{
		make_box(cpu_title, cpu_widget, cpu.tooltip),
		make_box(ram_title, ram_widget, ram.tooltip),

		layout  = wibox.layout.fixed.horizontal,
		spacing = dpi(20)
	},

	{
		make_box(temp_title, temp_widget, temp.tooltip),
		make_box(drive_title, drive_widget, drive.tooltip),

		layout  = wibox.layout.fixed.horizontal,
		spacing = dpi(20)
	},

	layout  = wibox.layout.fixed.vertical,
	spacing = dpi(20)
}