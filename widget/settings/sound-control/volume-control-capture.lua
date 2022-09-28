local icons            = require('theme.icons')
local clickable_widget = require('widget.style.clickable-widget')
local helpers          = require('utils.helpers')
local id               = require('config.user.id')
local slider_widget    = require('widget.style.slider')
local make_slider      = require('utils.make-slider')

local icon = wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = 'none',

	nil,

	{
		image  = icons.microphone,
		resize = true,
		widget = wibox.widget.imagebox
	},

	nil
}

local action_level = wibox.widget {
	{
		icon,

		widget = clickable_widget
	},

	bg     = beautiful.transparent,
	shape  = gears.shape.circle,
	widget = wibox.container.background
}

local slider = wibox.widget {
	nil,
	slider_widget(),
	nil,

	expand        = 'none',
	forced_height = dpi(24),
	layout        = wibox.layout.align.vertical
}

local status = wibox.widget {
	widget       = wibox.widget.textbox,
	markup       = helpers.colorize_text('100%', '#f2f2f2EE'),
	align        = 'center',
	valign       = 'center',
	forced_width = dpi(40),
	font         = 'Cantarell Medium 11'
}

local volume_slider = slider.slider_widget

volume_slider:connect_signal('property::value', function()
	local volume_level = volume_slider:get_value()

	status:set_markup(helpers.colorize_text(tostring(volume_level) .. '%', '#F2F2F2EE'))
	
	awful.spawn('amixer -q -D pulse sset Capture ' .. volume_level .. '%', false)
end)

volume_slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if volume_slider.value > 100 then
			volume_slider.value = 100

			return
		end

		volume_slider.value = volume_slider.value + 5
	end),

	awful.button({}, 5, nil, function()
		if volume_slider.value < 0 then
			volume_slider.value = 0

			return
		end

		volume_slider.value = volume_slider.value - 5
	end)
))

action_level:buttons(awful.util.table.join(
	awful.button({}, 1, nil, function()
		local sli_value = volume_slider:get_value()
		local new_value = 0

		if sli_value >= 0 and sli_value < 25 then
			new_value = 25
		elseif sli_value >= 25 and sli_value < 50 then
			new_value = 50
		elseif sli_value >= 50 and sli_value < 75 then
			new_value = 75
		elseif sli_value >= 75 and sli_value < 100 then
			new_value = 100
		else
			new_value = 0
		end

		volume_slider:set_value(new_value)
	end)
))

-- The emit will come from the global keybind.

awesome.connect_signal('widget::sound', function()
	awful.spawn.easy_async_with_shell('amixer -D pulse sget Capture', function(stdout) 
		local volume = string.match(stdout, '(%d?%d?%d)%%')

		volume_slider:set_value(tonumber(volume))
	end)
end)

return make_slider(action_level, slider, status)