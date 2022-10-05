local notifbox_ui   = require('widget.panel.notification-center.build.notifbox-ui-elements')

local function return_date_time(format)
	return os.date(format)
end

local function parse_to_seconds(time)
	local hour_in_sec = tonumber(string.sub(time, 1, 2)) * 3600
	local min_in_sec  = tonumber(string.sub(time, 4, 5)) * 60
	local get_sec     = tonumber(string.sub(time, 7, 8))

	return (hour_in_sec + min_in_sec + get_sec)
end

return function(notif, icon, title, message, app, bgcolor)

	local time_of_pop     = return_date_time('%H:%M:%S')
	local exact_time      = return_date_time('%I:%M %p')
	local exact_date_time = return_date_time('%b %d, %I:%M %p')  

	local notifbox_timepop =  wibox.widget {
		id      = 'time_pop',
		markup  = nil,
		font    = 'Cantarell Regular 10',
		align   = 'left',
		valign  = 'center',
		visible = true,
		widget  = wibox.widget.textbox
	}

	local notifbox_dismiss = notifbox_ui.notifbox_dismiss()

	local time_of_popup = gears.timer {
		timeout   = 60,
		call_now  = true,
		autostart = true,
		callback  = function()
			local time_difference = nil

			time_difference = parse_to_seconds(return_date_time('%H:%M:%S')) - parse_to_seconds(time_of_pop)
			time_difference = tonumber(time_difference)

			if time_difference < 60 then
				notifbox_timepop:set_markup('Just now')
			elseif time_difference >= 60 and time_difference < 3600 then
				local time_in_minutes = math.floor(time_difference / 60)

				notifbox_timepop:set_markup(time_in_minutes .. 'm ago')
			elseif time_difference >= 3600 and time_difference < 86400 then
				notifbox_timepop:set_markup(exact_time)
			elseif time_difference >= 86400 then
				notifbox_timepop:set_markup(exact_date_time)

				return false
			end

			collectgarbage('collect')
		end
	}

	local notifbox_template =  wibox.widget {
		id     = 'notifbox_template',
		expand = 'none',

		{
			{
				layout = wibox.layout.fixed.vertical,
				spacing = dpi(5),

				{
					expand = 'none',
					layout = wibox.layout.align.horizontal,

					{
						notifbox_ui.notifbox_icon(icon),
						notifbox_ui.notifbox_appname(app),

						layout  = wibox.layout.fixed.horizontal,
						spacing = dpi(5)
					},

					nil,

					{
						notifbox_timepop,
						notifbox_dismiss,

						layout = wibox.layout.fixed.horizontal
					}
				},

				{
					{
						notifbox_ui.notifbox_title(title),
						notifbox_ui.notifbox_message(message),
						layout = wibox.layout.fixed.vertical
					},

					notifbox_ui.notifbox_actions(notif),

					layout  = wibox.layout.fixed.vertical,
					spacing = dpi(5)
				},

			},

			margins = dpi(10),
			widget  = wibox.container.margin
		},

		bg     = bgcolor,
		shape  = function(cr, width, height)
			gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, beautiful.groups_radius)
		end,
		widget = wibox.container.background,
	}

	-- Put the generated template to a container.

	local notifbox = wibox.widget {
		notifbox_template,

		shape  = function(cr, width, height)
			gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, beautiful.groups_radius)
		end,
		widget = wibox.container.background
	}

	-- Delete notification box.

	local function notifbox_delete()
		notif_core.notifbox_layout:remove_widgets(notifbox, true)
	end

	-- Delete notifbox on LMB.

	notifbox:buttons(awful.util.table.join(
		awful.button({}, 1, nil, function()
			if #notif_core.notifbox_layout.children == 1 then
				notif_core.reset_notifbox_layout()
			else
				notifbox_delete()
			end
		end)
	))

	-- Add hover, and mouse leave events.

	notifbox_template:connect_signal('mouse::enter', function() 
		notifbox.bg              = beautiful.groups_bg
		notifbox_timepop.visible = false
		notifbox_dismiss.visible = true
	end)

	notifbox_template:connect_signal('mouse::leave', function() 
		notifbox.bg              = beautiful.tranparent
		notifbox_timepop.visible = true
		notifbox_dismiss.visible = false
	end)
	
	return notifbox
end