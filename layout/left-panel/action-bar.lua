local icons            = require('theme.icons')
local tag_list         = require('widget.panel.tag-list')
local clickable_widget = require('widget.style.clickable-widget')
local search_apps      = require('widget.panel.search-apps')
local layout_box       = require('widget.panel.layout-box')
local clock            = require('widget.panel.clock')

return function(scr, panel, action_bar_width)
	local menu_icon = wibox.widget {
		{
			id = 'menu_btn',
			image = icons.menu,
			resize = true,
			widget = wibox.widget.imagebox
		},

		margins = dpi(10),
		widget = wibox.container.margin
	}
	
	local open_dashboard_button = wibox.widget {
		{
			menu_icon,

			widget = clickable_widget
		},

		bg     = '#003F6B',
		widget = wibox.container.background
	}

	local odb_tooltip = awful.tooltip {
		text       = 'Open dashboard',
		mode       = 'inside',
		align      = 'right',
		delay_show = 0.5
	}

	odb_tooltip:add_to_object(open_dashboard_button)

	local direction_icon = wibox.widget {
		{
			id     = 'expand_icon',
			image  = icons.right_arrow,
			resize = true,
			widget = wibox.widget.imagebox
		},

		margins = dpi(13),
		widget  = wibox.container.margin
	}

	local expand_dashboard_button = wibox.widget {
		{
			direction_icon,

			widget = clickable_widget
		},

		bg      = '#003F6B',
		visible = false,
		widget  = wibox.container.background
	}

	local edb_tooltip = awful.tooltip {
		text       = 'Expand dashboard',
		mode       = 'outside',
		align      = 'right',
		delay_show = 0.5
	}

	edb_tooltip:add_to_object(expand_dashboard_button)

	open_dashboard_button:buttons(gears.table.join(
		awful.button({}, 1, nil, function()
			panel:toggle()
		end)
	))

	expand_dashboard_button:buttons(gears.table.join(
		awful.button({}, 1, nil, function()
			panel:toggle_extended()
		end)
	))

	panel:connect_signal('opened', function()
		menu_icon.menu_btn:set_image(gears.surface(icons.close))

		odb_tooltip:set_text('Close dashboard')

		expand_dashboard_button.visible = true

		open_dashboard_button.bg = '#AA0000'
	end)

	panel:connect_signal('closed', function()
		menu_icon.menu_btn:set_image(gears.surface(icons.menu))

		odb_tooltip:set_text('Open dashboard')

		expand_dashboard_button.visible = false

		open_dashboard_button.bg = '#003F6B'
	end)

	panel:connect_signal('opened_extended', function()
		direction_icon.expand_icon:set_image(gears.surface(icons.left_arrow))

		edb_tooltip:set_text('Shrink dashboard')

		expand_dashboard_button.bg = '#AA0000'
	end)

	panel:connect_signal('closed_extended', function()
		direction_icon.expand_icon:set_image(gears.surface(icons.right_arrow))

		edb_tooltip:set_text('Expand dashbaord')

		expand_dashboard_button.bg = '#003F6B'
	end)

	return wibox.widget {
		id           = 'action_bar',
		layout       = wibox.layout.align.vertical,
		forced_width = action_bar_width,

		{
			open_dashboard_button,
			tag_list(scr),
			layout = wibox.layout.fixed.vertical,
		},

		nil,

		{
			expand_dashboard_button,
			clock,
			layout_box(scr),

			layout = wibox.layout.fixed.vertical
		}
	}
end