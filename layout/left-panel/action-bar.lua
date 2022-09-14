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
		--bg = beautiful.background .. '66',
		bg = '#003f6b',
		widget = wibox.container.background
	}

	open_dashboard_button:buttons(gears.table.join(
		awful.button({}, 1, nil, function()
			panel:toggle()
		end)
	))

	panel:connect_signal('opened', function()
		menu_icon.menu_btn:set_image(gears.surface(icons.close))
	end)

	panel:connect_signal('closed', function()
		menu_icon.menu_btn:set_image(gears.surface(icons.menu))
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
			clock,
			layout_box(scr),
			layout = wibox.layout.fixed.vertical
		}
	}
end