local helpers = require('utils.helpers')
local switch  = require('widget.style.switch')

local output_action_name = wibox.widget {
	markup = helpers.colorize_text('Audio Output', beautiful.color_white),
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local input_action_name = wibox.widget {
	markup = helpers.colorize_text('Audio Input', beautiful.color_white),
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local output_switch = switch()
local input_switch  = switch()

output_switch:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		output_switch:toggle()

		awful.spawn('amixer -q -D pulse sset Master toggle', false)
	end)
))

input_switch:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		input_switch:toggle()

		awful.spawn('amixer -q -D pulse sset Capture toggle', false)
	end)
))

awesome.connect_signal('widget::sound', function()
	awful.spawn.easy_async_with_shell('amixer -D pulse sget Master | awk \'/Left:/ { print $6 }\'', function(stdout)
		if stdout:match('%[on%]') == '[on]' then
			output_switch:on()
		else output_switch:off() end
	end)

	awful.spawn.easy_async_with_shell('amixer -D pulse sget Capture | awk \'/Left:/ { print $6 }\'', function(stdout)
		if stdout:match('%[on%]') == '[on]' then
			input_switch:on()
		else input_switch:off() end
	end)
end)

return wibox.widget {
	{
		{
				{
				output_action_name,
				nil,
				output_switch,

				layout = wibox.layout.align.horizontal
			},

			margins = { top = dpi(12) },
			widget  = wibox.container.margin
		},

		{
			{
				input_action_name,
				nil,
				input_switch,

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