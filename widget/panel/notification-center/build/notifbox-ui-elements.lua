local clickable_widget = require('widget.style.clickable-widget')
local icons            = require('theme.icons')

local ui_noti_builder = {}

-- Notification icon container.

function ui_noti_builder.notifbox_icon(icon)
	local noti_icon = wibox.widget {
		{
			id            = 'icon',
			image         = icon,
			resize        = true,
			forced_height = dpi(25),
			forced_width  = dpi(25),
			widget        = wibox.widget.imagebox
		},

		layout = wibox.layout.fixed.horizontal
	}

	return noti_icon
end

-- Notification title container.

function ui_noti_builder.notifbox_title(title)
	return wibox.widget {
		markup = title or 'Anonymous title',
		font   = 'Cantarell Bold 12',
		align  = 'left',
		valign = 'center',
		widget = wibox.widget.textbox
	}
end

-- Notification message container.

function ui_noti_builder.notifbox_message(msg)
	return wibox.widget {
		markup = msg,
		font   = 'Cantarell Regular 11',
		align  = 'left',
		valign = 'center',
		widget = wibox.widget.textbox
	}
end

-- Notification app name container.

function ui_noti_builder.notifbox_appname(app)
	return wibox.widget {
		markup  = app,
		font   = 'Cantarell Bold 12',
		align  = 'left',
		valign = 'top',
		widget = wibox.widget.textbox
	}
end

-- Notification actions container.

function ui_noti_builder.notifbox_actions(n)
	actions_template = wibox.widget {
		notification = n,
		base_layout  = wibox.widget {
			spacing  = dpi(0),
			layout   = wibox.layout.flex.horizontal
		},

		widget_template = {
			{
				{
					{
						{
							id     = 'text_role',
							font   = 'Cantarell Regular 10',
							widget = wibox.widget.textbox
						},

						widget = wibox.container.place
					},

					widget = clickable_widget
				},

				bg                 = beautiful.groups_bg,
				shape              = gears.shape.rounded_rect,
				forced_height      = 30,
				widget             = wibox.container.background
			},

			margins = dpi(4),
			widget  = wibox.container.margin
		},

		style  = { underline_normal = false, underline_selected = true },
		widget = naughty.list.actions,
	}

	return actions_template
end


-- Notification dismiss button.

ui_noti_builder.notifbox_dismiss = function()
	local dismiss_imagebox = wibox.widget {
		{
			id            = 'dismiss_icon',
			image         = icons.close,
			resize        = true,
			forced_height = dpi(5),
			widget        = wibox.widget.imagebox
		},

		layout = wibox.layout.fixed.horizontal
	}

	local dismiss_button = wibox.widget {
		{
			dismiss_imagebox,

			margins = dpi(5),
			widget  = wibox.container.margin
		},

		widget = clickable_widget
	}

	local notifbox_dismiss = wibox.widget {
		dismiss_button,

		id      = 'dismiss',
		visible = false,
		bg      = beautiful.groups_title_bg,
		shape   = gears.shape.circle,
		widget  = wibox.container.background
	}

	return notifbox_dismiss
end

return ui_noti_builder