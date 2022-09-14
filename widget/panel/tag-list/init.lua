local clickable_widget = require('widget.style.clickable-widget')
local super            = require('config.keys').super

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),

	awful.button({ super }, 1, function(t)
		if _G.client.focus then
			_G.client.focus:move_to_tag(t)

			t:view_only()
		end
	end),

	awful.button({}, 3, awful.tag.viewtoggle),

	awful.button({ super }, 3, function(t)
		if _G.client.focus then
			_G.client.focus:toggle_tag(t)
		end
	end),

	awful.button({}, 4, function(t)
		awful.tag.viewprev(t.screen)
	end),

	awful.button({}, 5, function(t)
		awful.tag.viewnext(t.screen)
	end)
)

return function(scr) 
	return awful.widget.taglist {
		screen          = scr,
		filter          = awful.widget.taglist.filter.all,
		layout          = wibox.layout.fixed.vertical,
		buttons         = taglist_buttons,
		widget_template = {
			id            = 'background_role',
			forced_height = dpi(45),
			widget        = wibox.container.background,

			{
				{
					widget     = wibox.layout.fixed.horizontal,
					fill_space = true,

					{
						id      = 'icon_margin_role',
						margins = dpi(10),
						widget  = wibox.container.margin,

						{
							id = 'icon_role',
							resize = true,
							widget = wibox.widget.imagebox
						},
					}
				},

				widget = clickable_widget,
			}
		}
	}
end