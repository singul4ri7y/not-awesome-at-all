local clickable_widget = require('widget.style.clickable-widget')

local widget_dir      = config_dir .. 'widget/panel/notification-center/dont-disturb/'
local widget_icon_dir = config_dir .. 'widget/panel/notification-center/assets/'

_G.dont_disturb = false

local dont_disturb_imagebox = wibox.widget {
	{
		id            = 'icon',
		image         = widget_icon_dir .. 'dont-disturb-mode.svg',
		resize        = true,
		forced_height = dpi(20),
		forced_width  = dpi(20),
		widget        = wibox.widget.imagebox,
	},

	layout = wibox.layout.fixed.horizontal
}

local function update_icon()
	local dd_icon = dont_disturb_imagebox.icon

	if dont_disturb then
		dd_icon:set_image(widget_icon_dir .. 'dont-disturb-mode.svg')
	else
		dd_icon:set_image(widget_icon_dir .. 'notify-mode.svg')
	end
end

-- Get the dnd status.

local file = io.open(widget_dir .. 'disturb_status', 'r')

assert(file)

local data = file:read('*a')

if data:find('true') then
	dont_disturb = true
elseif data:find('false') then
	dont_disturb = false
else
	dont_disturb = false

	awful.spawn('echo "false" > ' .. widget_dir .. 'dont_disturb')
end

file:close()

update_icon()

local toggle_disturb = function()
	dont_disturb = not dont_disturb

	awful.spawn.with_shell('echo "' .. tostring(dont_disturb) .. '" > ' .. widget_dir .. 'disturb_status')

	update_icon()
end

local dont_disturb_button = wibox.widget {
	{
		dont_disturb_imagebox,

		margins = dpi(7),
		widget  = wibox.container.margin
	},

	widget = clickable_widget
}

dont_disturb_button:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		toggle_disturb()
	end)
))

local dont_disturb_wrapped = wibox.widget {
	nil,

	{
		dont_disturb_button,

		bg     = beautiful.groups_bg, 
		shape  = gears.shape.circle,
		widget = wibox.container.background
	},

	nil,

	expand = 'none',
	layout = wibox.layout.align.vertical
}

-- Create a notification sound.

naughty.connect_signal('request::display', function(n)
	if not dont_disturb then
		awful.spawn('canberra-gtk-play -V -10.0 -i message', false)
	end
end)

return dont_disturb_wrapped