local icons            = require('theme.icons')
local clickable_widget = require('widget.style.clickable-widget')
local helpers          = require('utils.helpers')
local slider_widget    = require('widget.style.slider')
local make_slider      = require('utils.make-slider')

local icon = wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = 'none',

	nil,

	{
		image  = icons.brightness,
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

local brightness_slider = slider.slider_widget

brightness_slider:connect_signal('property::value', function()
	local brightness_level = brightness_slider:get_value()

	if brightness_level < 5 then
		brightness_level = 5
	end

	brightness_slider:set_value(brightness_level)

	status:set_markup(helpers.colorize_text(tostring(brightness_level) .. '%', '#F2F2F2EE'))
	
	awful.spawn('brightnessctl -q set ' .. brightness_level .. '%', false)
end)

brightness_slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if brightness_slider:get_value() > 100 then
			brightness_slider:set_value(100)

			return
		end

		brightness_slider:set_value(brightness_slider:get_value() + 5)
	end),

	awful.button({}, 5, nil, function()
		if brightness_slider:get_value() < 0 then
			brightness_slider:set_value(0)

			return
		end

		brightness_slider:set_value(brightness_slider:get_value() - 5)
	end)
))

local action_jump = function()
	local sli_value = brightness_slider:get_value()
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

	brightness_slider:set_value(new_value)
end

action_level:buttons(awful.util.table.join(
	awful.button({}, 1, nil, function()
		action_jump()
	end)
))

-- The emit will come from the global keybind.

awesome.connect_signal('widget::display', function()
	awful.spawn.easy_async_with_shell('brightnessctl | grep -i  "current" | awk \'{ print $4 }\' | tr -d "(%)"', function(stdout)
		local brightness = string.match(stdout, '(%d+)')

		brightness_slider:set_value(tonumber(brightness))
	end)
end)

return make_slider(action_level, slider, status)