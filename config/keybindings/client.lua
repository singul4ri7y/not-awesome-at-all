local super = require('config.keys').super

client.connect_signal('request::default_mousebindings', function()
	awful.mouse.append_client_mousebindings {
		awful.button({}, 1, function(c)
			c:activate { context = 'mouse_click' }
		end),

		awful.button({ super }, 1, function(c)
			c:activate { context = 'mouse_click', action = 'mouse_move'  }
		end),

		awful.button({ super }, 3, function(c)
			c:activate { context = 'mouse_click', action = 'mouse_resize' }
		end),
	}
end)

client.connect_signal('request::default_keybindings', function()
	awful.keyboard.append_client_keybindings {
		awful.key({ super }, 'f', function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = 'Toggle fullscreen', group = 'Client (non-global)' }),

		awful.key({ super }, 'q', function(c) c:kill() end,
		          { description = 'Close', group = 'Client (non-global)' }),

		awful.key({ super, ctrl }, 'space',  awful.client.floating.toggle,
				{ description = 'Toggle floating', group = 'Client (non-global)' }),

		awful.key({ super, shift }, 'Return', function(c) c:swap(awful.client.getmaster()) end,
		          { description = 'Move to master', group = 'Client (non-global)' }),

		awful.key({ super }, 'o', function(c) c:move_to_screen()               end,
		          { description = 'Move to screen', group = 'Client (non-global)' }),

		awful.key({ super }, 't', function(c) c.ontop = not c.ontop            end,
		          { description = 'Toggle keep on top', group = 'Client (non-global)' }),

		awful.key({ super }, 'n', function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.

			c.minimized = true
		end, { description = 'Minimize', group = 'Client (non-global)' }),

		awful.key({ super }, 'm', function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = '(un)maximize', group = 'Client (non-global)' })
	}
end)