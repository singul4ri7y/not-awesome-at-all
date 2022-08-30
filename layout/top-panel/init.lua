local super = require('config.keys').super

return function(s) 
    -- Create a promptbox for each screen.

    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.

    s.mylayoutbox = wibox.widget {
		screen  = s,
		buttons = {
			awful.button({ }, 1, function() awful.layout.inc( 1) end),
			awful.button({ }, 3, function() awful.layout.inc(-1) end),
			awful.button({ }, 4, function() awful.layout.inc(-1) end),
			awful.button({ }, 5, function() awful.layout.inc( 1) end),
		},
		{
			awful.widget.layoutbox,
			margins = dpi(3),
			widget = wibox.container.margin
		},

		widget = require('widget.style.clickable-widget')
    }

    -- Create a taglist widget.

    s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({ }, 1, function(t) t:view_only() end),
			awful.button({ super }, 1, function(t)
											if client.focus then
												client.focus:move_to_tag(t)
											end
										end),
			awful.button({ }, 3, awful.tag.viewtoggle),
			awful.button({ super }, 3, function(t)
											if client.focus then
												client.focus:toggle_tag(t)
											end
										end),
			awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
			awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
		}
    }

    -- Create a tasklist widget.

    s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button({ }, 1, function(c)
				c:activate { context = "tasklist", action = "toggle_minimization" }
			end),
			awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
			awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
			awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
		}
    }

    -- Create the wibox.

    s.mywibox = awful.wibar {
		position = "top",
		screen   = s,
		widget   = {
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				s.mytaglist
			},

			s.mytasklist, -- Middle widget

			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				awful.widget.keyboardlayout(),
				wibox.widget.systray(),
				wibox.widget.textclock(),
				s.mylayoutbox
			}
		}
    }
end