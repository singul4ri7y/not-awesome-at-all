ruled.client.connect_signal('request::rules', function()
	-- All clients will match this rule.

	ruled.client.append_rule {
		id         = 'global',

		rule       = {},

		properties = {
			focus     = awful.client.focus.filter,
			raise     = true,
			screen    = awful.screen.preferred,
			placement = awful.placement.centered
		},

		-- Set clients as slave.

		callback = awful.client.setslave
	}

	-- Floating.

	ruled.client.append_rule {
		id       = 'floating',

		rule_any = {
			instance    = {
				'file_progress',
				'Popup',
				'nm-connection-editor',
			},

			class = {
				'scrcpy',
				'Mugshot',
				'Pulseeffects'
			},

			role    = {
				'AlarmWindow',
				'ConfigManager',
				'pop-up'
			}
		},

		properties = {
			titlebars_enabled = false,
			skip_decoration   = true,
			ontop             = true,
			floating          = true,
			focus             = awful.client.focus.filter,
			raise             = true,
			keys              = client_keys,
			buttons           = client_buttons,
			placement         = awful.placement.centered
		}
	}
end)