local empty_notifbox    = require('widget.panel.notification-center.build.empty-notifbox')
local notifbox_scroller = require('widget.panel.notification-center.build.notifbox-scroller')
local notifbox_builder  = require('widget.panel.notification-center.build.notifbox-builder')

_G.notif_core = {}

notif_core.remove_notifbox_empty = true

notif_core.notifbox_layout = wibox.widget {
	empty_notifbox,

	layout  = wibox.layout.fixed.vertical,
	spacing = dpi(7)
}

notifbox_scroller(notif_core.notifbox_layout)

notif_core.reset_notifbox_layout = function()
	notif_core.notifbox_layout:reset()
	notif_core.notifbox_layout:insert(1, empty_notifbox)

	notif_core.remove_notifbox_empty = true
end

local function notifbox_add(n, notif_icon, notifbox_color)	
	if #notif_core.notifbox_layout.children == 1 and notif_core.remove_notifbox_empty then
		notif_core.notifbox_layout:reset(notif_core.notifbox_layout)

		notif_core.remove_notifbox_empty = false
	end
	
	notif_core.notifbox_layout:insert(1, notifbox_builder(n, notif_icon, n.title, n.message, n.app_name, notifbox_color))
end

local function notifbox_add_expired(n, notif_icon, notifbox_color)
	n:connect_signal('destroyed', function(self, reason)
		if reason == 1 then
			notifbox_add(n, notif_icon, notifbox_color)
		end
	end)
end

naughty.connect_signal('request::display', function(n)
		local notifbox_color = beautiful.groups_bg

		if n.urgency == 'critical' then
			notifbox_color = n.bg .. '66'
		end

		local notif_icon = n.icon or n.app_icon

		if not notif_icon then
			notif_icon = config_dir .. 'widget/panel/notification-center/assets/new-notif.svg'
		end

		notifbox_add_expired(n, notif_icon, notifbox_color)
	end
)

return notif_core