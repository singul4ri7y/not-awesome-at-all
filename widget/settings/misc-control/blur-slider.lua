local icons            = require('theme.icons')
local clickable_widget = require('widget.style.clickable-widget')
local helpers          = require('layout.helpers')

local icon = wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = 'none',

	nil,

	{
		image  = icons.effects,
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

	{
		id 					= 'blur_slider',
		bar_shape           = gears.shape.rounded_rect,
		bar_height          = dpi(2),
		bar_color           = '#FFFFFF20',
		bar_active_color	= '#F2F2F2EE',
		forced_width        = dpi(181),
		handle_color        = '#FFFFFF',
		handle_shape        = gears.shape.circle,
		handle_width        = dpi(15),
		handle_border_color = '#00000012',
		handle_border_width = dpi(1),
		maximum				= 100,
		value               = 40,
		widget              = wibox.widget.slider,
	},

	nil,

	expand        = 'none',
	forced_height = dpi(24),
	layout        = wibox.layout.align.vertical
}

local status = wibox.widget {
	widget       = wibox.widget.textbox,
	markup       = helpers.colorize_text('40%', '#f2f2f2EE'),
	align        = 'center',
	valign       = 'center',
	forced_width = dpi(48),
	font         = 'Cantarell Medium 11'
}

local blur_slider = slider.blur_slider

blur_slider:connect_signal('property::value', function()
	local blur_level = blur_slider:get_value()

	if blur_level < 5 then
		blur_level = 5
	end

	blur_slider:set_value(blur_level)

	status:set_markup(helpers.colorize_text(tostring(blur_level) .. '%', '#F2F2F2EE'))


end)

blur_slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if blur_slider:get_value() > 100 then
			blur_slider:set_value(100)

			return
		end

		blur_slider:set_value(blur_slider:get_value() + 5)
	end),

	awful.button({}, 5, nil, function()
		if blur_slider:get_value() < 0 then
			blur_slider:set_value(0)

			return
		end

		blur_slider:set_value(blur_slider:get_value() - 5)
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

awesome.connect_signal('widget::misc', function()
	
end)

return wibox.widget {
	{
		{
			action_level,

			margins = { top = dpi(12), bottom = dpi(12) },
			widget  = wibox.container.margin
		},

		slider,
		status,

		spacing = dpi(24),
		layout  = wibox.layout.fixed.horizontal
	},

	widget        = wibox.container.margin,
	forced_height = dpi(48),
	margins       = { left = dpi(24), right = dpi(24) }
}