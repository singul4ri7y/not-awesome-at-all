local make_box      = require('utils.make-box')
local icons         = require('theme.icons')
local slider_widget = require('widget.style.slider')

local default_album = config_dir .. 'layout/left-panel/dashboard-extended/media-player/assets/default-album.png'

local playerctl = 'playerctl --player=playerctld '

local position, length

local player_title = wibox.widget {
	text   = 'Media Control',
	font   = 'Cantarell Regular 13',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local album_art = wibox.widget {
	image         = gears.surface.load_uncached(default_album),
	resize        = true,
	clip_shape    = gears.shape.rounded_rect,
	forced_width  = dpi(100),
	forced_height = dpi(100),
	widget        = wibox.widget.imagebox
}

local media_name = wibox.widget {
	widget        = wibox.container.scroll.horizontal,
	max_size      = 150,
	step_function = wibox.container.scroll.step_functions.linear_back_and_forth,
	speed         = 30,

	{
		id     = 'markup',
		markup = 'No media playing',
		font   = 'Cantarell Bold 12',
		align  = 'center',
		valign = 'center',
		widget = wibox.widget.textbox
	}
}

local artist_name = wibox.widget {
	{
		widget = wibox.widget.textbox,
		font   = 'Cantarell Regular 11',
		align  = 'center',
		valign = 'center',
		markup = 'By '
	},

	{
		widget        = wibox.container.scroll.horizontal,
		max_size      = 150,
		step_function = wibox.container.scroll.step_functions.linear_back_and_forth,
		speed         = 100,

		{
			id     = 'markup',
			markup = 'Unknown artist',
			font   = 'Cantarell Regular 11',
			align  = 'center',
			valign = 'center',
			widget = wibox.widget.textbox
		}
	},

	layout  = wibox.layout.fixed.horizontal,
}

local media_slider = wibox.widget.slider(slider_widget())

local update_function_media_slider_change = false

media_slider:connect_signal('property::value', function()
	if not update_function_media_slider_change then
		awful.spawn(playerctl .. 'position '.. (media_slider.value * length) / 100, false)
	end
end)

media_slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if media_slider.value > 100 then
			media_slider.value = 100

			return
		end

		media_slider.value = media_slider.value + 5
	end),

	awful.button({}, 5, nil, function()
		if media_slider.value < 0 then
			media_slider.value = 0

			return
		end

		media_slider.value = media_slider.value - 5
	end)
))

local passed_time = wibox.widget {
	widget = wibox.widget.textbox,
	markup = 'N/A',
	font   = 'Cantarell Regular 12',
	align  = 'center',
	valign = 'center'
}

local total_time = wibox.widget {
	widget = wibox.widget.textbox,
	markup = 'N/A',
	font   = 'Cantarell Regular 12',
	align  = 'center',
	valign = 'center'
}

-- Media states: playing (true), paused (false), no-media (nil)

local playing = nil

local prev_icon = wibox.widget {
	widget = wibox.widget.textbox,
	markup = '玲',
	align  = 'center',
	valign = 'center',
	font   = default_font .. 'Regular 25'
}

local prev_icon_tooltip = awful.tooltip {
	text       = 'Previous media (Unavailable)',
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

prev_icon_tooltip:add_to_object(prev_icon)

prev_icon:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		if playing ~= nil then
			awful.spawn(playerctl .. 'previous', false)
		end
	end)
))

local playpause_icon = wibox.widget {
	widget = wibox.widget.textbox,
	markup = '契',
	align  = 'center',
	valign = 'center',
	font   = default_font .. 'Regular 35'
}

local playpause_icon_tooltip = awful.tooltip {
	text       = 'Play (Media cannot be played)',
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

playpause_icon_tooltip:add_to_object(playpause_icon)

local function update_playpause_button()
	if playing == true then
		playpause_icon:set_markup('')

		playpause_icon_tooltip:set_text('Pause')
	elseif playing == false or playing == nil then
		playpause_icon:set_markup('契')

		local text = 'Play'

		if playing == nil then
			text = text .. ' (Media cannot be played)'
		end

		playpause_icon_tooltip:set_text(text)
	end
end

playpause_icon:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		awful.spawn(playerctl .. 'play-pause', false)

		if playing ~= nil then
			if playing then
				playing = false
			else playing = true end

			update_playpause_button()
		end
	
	end)
))

local next_icon = wibox.widget {
	widget = wibox.widget.textbox,
	markup = '怜',
	align  = 'center',
	valign = 'center',
	font   = default_font .. 'Regular 25'
}

next_icon_tooltip = awful.tooltip {
	text       = 'Next (Unavailable)',
	mode       = 'inside',
	align      = 'right',
	delay_show = 0.5
}

next_icon_tooltip:add_to_object(next_icon)

next_icon:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		if playing ~= nil then
			awful.spawn(playerctl .. 'next', false)
		end
	end)
))

local volume = wibox.widget {
	{
		{
			widget = wibox.widget.imagebox,
			image  = icons.volume,
			resize = true
		},

		widget  = wibox.container.margin,
		margins = { top = dpi(3), bottom = dpi(3) }
	},

	{
		id 					= 'slider_widget',
		bar_shape           = gears.shape.rounded_rect,
		bar_height          = dpi(2),
		value               = 100,
		forced_width        = dpi(50),
		bar_color           = '#FFFFFF20',
		bar_active_color	= '#F2F2F2EE',
		handle_color        = '#FFFFFF',
		handle_shape        = gears.shape.circle,
		handle_width        = dpi(10),
		handle_border_color = '#00000012',
		handle_border_width = dpi(1),
		maximum				= 100,
		widget              = wibox.widget.slider,
	},

	spacing = dpi(8),
	layout  = wibox.layout.fixed.horizontal
}

local update_function_volume_slider_change = false
local volume_slider                        = volume.slider_widget

volume_slider:connect_signal('property::value', function()
	if not update_function_volume_slider_change then
		awful.spawn(playerctl .. 'volume ' .. volume_slider.value / 100)
	end
end)

local updatecmd = playerctl .. "metadata --format '<1>{{xesam:title}}<2>{{xesam:artist}}<3>{{mpris:length}}<4>{{position}}<5>{{volume}}<6>{{album}}<7>'"

local function update_function(stdout)
	local data = stdout:match('<1>(.*)<2>')

	if data ~= '' then
		media_name.markup:set_markup(data)
	else 
		media_name.markup:set_markup('Anonymous media')
	end

	data = stdout:match('<2>(.*)<3>')

	local widget = artist_name:get_children_by_id('markup')[1]

	if data ~= '' then
		widget:set_markup(data)
	else
		widget:set_markup('Unknown artist')
	end

	length = tonumber(stdout:match('<3>(.*)<4>')) / 1000000

	local min = math.floor(length / 60)
	local sec = math.floor(length % 60)

	total_time:set_markup(string.format('%02d:%02d', min, sec))

	position = stdout:match('<4>(.*)<5>') / 1000000

	min = math.floor(position / 60)
	sec = math.floor(position % 60)

	passed_time:set_markup(string.format('%02d:%02d', min, sec))

	-- To avoid calling 'property::value' to set the value again (for media_slider).

	update_function_media_slider_change = true

	media_slider.value = (position / length) * 100

	update_function_media_slider_change = false

	data = tonumber(stdout:match('<5>(.*)<6>'))

	-- To avoid calling 'property::value' to set the value again (for volume_slider)

	update_function_volume_slider_change = true

	volume_slider.value = data * 100

	update_function_volume_slider_change = false

	data = stdout:match('<6>(.*)<7>')

	if data ~= '' then
		album_art:set_image(gears.surface.load_uncached(data))
	else
		album_art:set_image(gears.surface.load_uncached(default_album))
	end

	prev_icon_tooltip:set_text('Previous')
	next_icon_tooltip:set_text('Next')
end

local function default_update()
	media_name.markup:set_markup('No media playing')

	artist_name:get_children_by_id('markup')[1]:set_markup('Unknown artist')

	passed_time:set_markup('N/A')
	total_time :set_markup('N/A')

	update_function_media_slider_change = true

	media_slider.value = 0

	update_function_media_slider_change = false

	update_function_volume_slider_change = true

	volume_slider.value = 100

	update_function_volume_slider_change = false

	album_art:set_image(gears.surface.load_uncached(default_album))

	prev_icon_tooltip:set_text('Previous (Unavailable)')
	next_icon_tooltip:set_text('Next (Unavailable)')
end

-- If the media widget details are already set to,
-- default, then avoid calling default_update() again.

local blanked = false

local function caller()
	local file = io.popen(playerctl .. 'status')

	assert(file)

	local status = file:read('*a'):gsub('\n$', '')

	if status == 'Playing' or status == 'Paused' then
		if status == 'Playing' then playing = true
		else playing = false end

		update_playpause_button()

		blanked = false
		
		awful.spawn.easy_async(updatecmd, update_function)
	else
		if not blanked then
			playing = nil

			update_playpause_button()

			default_update()

			blanked = true
		end
	end

	file:close()
end

local update_timer = gears.timer {
	timeout   = 1,
	autostart = false,
	callback  = caller
}

awesome.connect_signal('widget::mediaplayer:open', function()
	caller()

	update_timer:start()

	collectgarbage('collect')
end)

awesome.connect_signal('widget::mediaplayer:close', function() 
	update_timer:stop() 

	collectgarbage('collect')
end)

local media_player = wibox.widget {
	{
		{
			album_art,

			{
				{
					media_name,
					artist_name,

					layout = wibox.layout.fixed.vertical
				},

				widget = wibox.container.margin,
				top    = dpi(30)
			},

			spacing = dpi(24),
			layout  = wibox.layout.fixed.horizontal,
		},

		{
			{
				passed_time,
		
				{
					media_slider,

					widget  = wibox.container.margin,
					margins = { left = dpi(24), right = dpi(24) }
				},
			
				total_time,
		
				forced_height = dpi(24),
				layout        = wibox.layout.align.horizontal
			},

			widget  = wibox.container.margin,
			margins = { top = dpi(18), bottom = dpi(18) }
		},

		{
			{
				prev_icon,
				playpause_icon,
				next_icon,

				layout  = wibox.layout.fixed.horizontal,
				spacing = dpi(5)
			},

			nil,
			volume,

			forced_height = dpi(30),
			layout        = wibox.layout.align.horizontal
		},

		layout = wibox.layout.fixed.vertical
	},

	widget  = wibox.container.margin,
	margins = { top = dpi(12), bottom = dpi(12), left = dpi(24), right = dpi(24) }
}

return make_box(player_title, media_player)