local helpers = require('utils.helpers')
local switch  = require('widget.style.switch')

local blur_action_name = wibox.widget {
	markup = helpers.colorize_text('Blur', beautiful.color_white),
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local amode_action_name = wibox.widget {
	markup = helpers.colorize_text('Airplane mode', beautiful.color_white),
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local vsync_aciton_name = wibox.widget {
	markup = helpers.colorize_text('V-Sync', beautiful.color_white),
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local blur_switch  = switch()
local amode_switch = switch()
local vsync_switch = switch()

blur_switch:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		blur_switch:toggle()

		
	end)
))

amode_switch:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		amode_switch:toggle()

		
	end)
))

vsync_switch:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		vsync_switch:toggle()


	end)
))

awesome.connect_signal('widget::misc', function()
	
end)

return wibox.widget {
	{
		{
			{
				blur_action_name,
				nil,
				blur_switch,

				layout = wibox.layout.align.horizontal
			},

			top     = dpi(12),
			widget  = wibox.container.margin
		},

		{
			{
				amode_action_name,
				nil,
				amode_switch,

				layout = wibox.layout.align.horizontal
			},

			top     = dpi(16),
			widget  = wibox.container.margin
		},

		{
			{
				vsync_aciton_name,
				nil,
				vsync_switch,

				layout = wibox.layout.align.horizontal
			},

			margins = { top = dpi(16), bottom = dpi(12) },
			widget  = wibox.container.margin
		},

		layout = wibox.layout.fixed.vertical
	},

	margins = { left = dpi(24), right = dpi(24) },
	widget = wibox.container.margin
}