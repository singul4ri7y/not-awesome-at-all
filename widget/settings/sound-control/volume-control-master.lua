local icons            = require('theme.icons')
local clickable_widget = require('widget.style.clickable-widget')
local helpers          = require('layout.helpers')
local id               = require('config.user.id')

local icon = wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = 'none',

	nil,

	{
		image  = icons.volume,
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
		id 					= 'volume_slider',
		bar_shape           = gears.shape.rounded_rect,
		bar_height          = dpi(2),
		bar_color           = '#FFFFFF20',
		bar_active_color	= '#F2F2F2EE',
		forced_width        = dpi(188),
		handle_color        = '#FFFFFF',
		handle_shape        = gears.shape.circle,
		handle_width        = dpi(15),
		handle_border_color = '#00000012',
		handle_border_width = dpi(1),
		maximum				= 100,
		widget              = wibox.widget.slider,
	},

	nil,

	expand        = 'none',
	forced_height = dpi(24),
	layout        = wibox.layout.align.vertical
}

local volume_status = wibox.widget {
	widget       = wibox.widget.textbox,
	markup       = helpers.colorize_text('100%', '#f2f2f2EE'),
	align        = 'center',
	valign       = 'center',
	forced_width = dpi(48),
	font         = 'Cantarell Medium 11'
}

local volume_slider = slider.volume_slider

volume_slider:connect_signal('property::value', function()
	local volume_level = volume_slider:get_value()

	volume_status:set_markup(helpers.colorize_text(tostring(volume_level) .. '%', '#F2F2F2EE'))
	
	awful.spawn('amixer -q -D pulse sset Master ' .. volume_level .. '%', false)
end)

volume_slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if volume_slider:get_value() > 100 then
			volume_slider:set_value(100)

			return
		end

		volume_slider:set_value(volume_slider:get_value() + 5)
	end),

	awful.button({}, 5, nil, function()
		if volume_slider:get_value() < 0 then
			volume_slider:set_value(0)

			return
		end

		volume_slider:set_value(volume_slider:get_value() - 5)
	end)
))

local update_slider = function()
	awful.spawn.easy_async_with_shell('amixer -D pulse sget Master', function(stdout) 
		local volume = string.match(stdout, '(%d?%d?%d)%%')

		volume_slider:set_value(tonumber(volume))
	end)
end

local action_jump = function()
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
end

action_level:buttons(awful.util.table.join(
	awful.button({}, 1, nil, function()
		action_jump()
	end)
))

-- The emit will come from the global keybind.

awesome.connect_signal('widget::sound', function()
	update_slider()
end)

return wibox.widget {
	{
		{
			action_level,

			margins = { top = dpi(12), bottom = dpi(12) },
			widget  = wibox.container.margin
		},

		slider,
		volume_status,

		spacing = dpi(24),
		layout  = wibox.layout.fixed.horizontal
	},

	widget        = wibox.container.margin,
	forced_height = dpi(48),
	margins       = { left = dpi(24), right = dpi(24) }
}