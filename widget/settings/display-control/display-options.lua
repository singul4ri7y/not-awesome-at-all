local helpers = require('layout.helpers')
local switch  = require('widget.style.switch')

-- Tell caffeine module to start working.

awesome.emit_signal('caffeine::init')

local caffeine_action_name = wibox.widget {
	markup = helpers.colorize_text('Caffeine', beautiful.color_white),
	font   = 'Cantarell Regular 12',
	align  = 'left',
	valign = 'center',
	widget = wibox.widget.textbox
}

local caffeine_switch = switch()

caffeine_switch:buttons(gears.table.join(
	awful.button({}, 1, nil, function()
		awesome.emit_signal('caffeine::toggle', caffeine_switch)
	end)
))

awesome.connect_signal('widget::display', function()
	awesome.emit_signal('caffeine::update', caffeine_switch)
end)

return wibox.widget {
	{
		caffeine_action_name,
		nil,
		caffeine_switch,

		layout = wibox.layout.align.horizontal
	},

	margins = { left = dpi(24), right = dpi(24), top = dpi(12), bottom = dpi(12) },
	widget = wibox.container.margin
}