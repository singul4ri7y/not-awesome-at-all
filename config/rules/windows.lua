-- Rules specific to window types.

ruled.client.connect_signal('request::rules', function()
	ruled.client.append_rule {
		id = 'utility',

		rule_any = {
			type = { 'utility' }
		},

		properties = {
			floating          = true,
			skip_decoration   = true,
			titlebars_enabled = false,
			border_width      = beautiful.no_gap,
			placement         = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	}
end)