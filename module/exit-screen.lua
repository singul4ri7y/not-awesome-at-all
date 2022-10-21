local id               = require('config.user.id')
local clickable_widget = require('widget.style.clickable-widget')
local icons            = require('theme.icons')

local date_and_time = wibox.widget {
	{
		format = '%I:%M',
		font   = 'Cantarell Bold 20',
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textclock
	},

	{
		format = '%A, %B %d, %Y',
		font   = 'Cantarell Medium 12',
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textclock
	},

	layout = wibox.layout.fixed.vertical
}

local profile_image = wibox.widget {
	{
		image      = id.profile,
		resize     = true,
		clip_shape = gears.shape.circle,
		widget     = wibox.widget.imagebox
	},

	forced_width  = dpi(75),
	forced_height = dpi(75),
	border_width  = dpi(1),
	shape         = gears.shape.circle,
	border_color  = beautiful.fg_normal .. '88',
	widget        = wibox.container.background
}

local fullname = wibox.widget {
	markup = id.fullname,
	font   = 'Cantarell Medium 16',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local username = wibox.widget {
	markup = '@' .. id.username,
	font   = 'Cantarell Light 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local function build_power_button(name, icon, callback)
	local power_button_label = wibox.widget {
		markup = name,
		font   = 'Cantarell Regular 16',
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}

	local power_button = wibox.widget {
		{
			{
				{
					{
						image  = icon,
						resize = true,
						widget = wibox.widget.imagebox
					},

					margins = dpi(20),
					widget  = wibox.container.margin
				},
				
				widget = clickable_widget
			},

			bg            = beautiful.bg_dashboard,
			forced_width  = dpi(100),
			forced_height = dpi(100),
			shape         = gears.shape.rounded_rect,
			widget        = wibox.container.background
		},

		power_button_label,

		spacing = dpi(2),
		layout  = wibox.layout.fixed.vertical
	}

	power_button:buttons(gears.table.join(
		awful.button({}, 1, callback)
	))

	return power_button
end

local poweroff = build_power_button('Shut Down', icons.power, function()
	awful.spawn('systemctl poweroff', false)
end)

screen.connect_signal('request::desktop_decoration', function(scr)
	scr.exit_screen = wibox {
		screen  = scr,
		visible = false,
		ontop   = true,
		type    = 'splash',
		bg      = beautiful.bg_normal,
		fg      = beautiful.fg_normal,
		width   = scr.geometry.width / 2,
		height  = scr.geometry.height / 2,
		x       = scr.geometry.x + scr.geometry.width / 4,
		y       = scr.geometry.y + scr.geometry.height / 4
	}

	scr.exit_screen_backdrop = wibox {
		screen  = scr,
		visible = false,
		ontop   = true,
		type    = 'utility',
		bg      = beautiful.bg_backdrop,
		width   = scr.geometry.width,
		height  = scr.geometry.height,
		x       = scr.geometry.x,
		y       = scr.geometry.y
	}

	scr.exit_screen_backdrop:buttons(gears.table.join(
		awful.button({}, 1, function()
			screen.emit_signal('exit_screen::hide')
		end)
	))

	scr.exit_screen:setup {
		{
			{
				{
					profile_image,
				
					{
						nil,
				
						{
							fullname,
							username,
				
							layout  = wibox.layout.fixed.vertical,
							spacing = dpi(2)
						},
				
						layout = wibox.layout.align.vertical,
						expand = 'none'
					},
				
					layout  = wibox.layout.fixed.horizontal,
					spacing = dpi(15)
				},

				nil,
				date_and_time,

				layout = wibox.layout.align.horizontal
			},

			{
				nil,

				{
					poweroff,

					spacing = dpi(24),
					layout = wibox.layout.fixed.horizontal
				},

				nil,

				expand = 'none',
				layout = wibox.layout.align.horizontal
			},

			nil,

			layout = wibox.layout.align.vertical
		},

		margins = dpi(24),
		widget  = wibox.container.margin
	}
end)

local exit_screen_keygrabber = awful.keygrabber {
	auto_start          = false,
	stop_event          = 'release',
	keypressed_callback = function(_, mod, key, _) 
		-- No key combination is allowed. Exit screen
		-- will only respond to pure key press.

		for i, v in ipairs(mod) do
			return
		end

		if key == 'Escape' or key == 'q' or key == 'x' then
			screen.emit_signal('exit_screen::hide')
		end
	end
}

screen.connect_signal('exit_screen::show', function()
	-- Show exit screen in all the available screen/displays.

	for scr in screen do
		scr.exit_screen_backdrop.visible = true
		scr.exit_screen.visible          = true
	end

	-- Start the keygrabber.

	exit_screen_keygrabber:start()
end)

screen.connect_signal('exit_screen::hide', function()
	-- Hide the exit screen.

	for scr in screen do
		scr.exit_screen.visible          = false
		scr.exit_screen_backdrop.visible = false
	end

	-- Stop the keygrabber.

	exit_screen_keygrabber:stop()
end)