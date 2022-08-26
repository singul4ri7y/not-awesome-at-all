local hotkeys_popup = require('awful.hotkeys_popup')
local apps          = require('config.user.apps')

local super         = require('config.keys').super
local shift         = 'Shift'
local ctrl          = 'Control'

-- Custom quitter function.

local function awesome_quit(code) 
	-- Kill all the lingering apps e.g. 'vs-code'.

	awful.spawn.with_shell('killall -q -w code')

	awesome.quit(code)
end

-- AwesomeWM related keybindings.

awful.keyboard.append_global_keybindings {
	awful.key({ super }, 'F1', hotkeys_popup.show_help,
	          { description = 'Show cheatsheet (this window)', group = 'AwesomeWM' }),

	awful.key({ super, shift }, 'r', awesome.restart,
	          { description = 'Reload AwesomeWM', group = 'AwesomeWM' }),

	awful.key({ super, shift }, 'q', awesome_quit,
	          { description = 'Quit AwesomeWM', group = 'AwesomeWM' }),
}

-- Launchers.

awful.keyboard.append_global_keybindings {
	awful.key({ super }, 'Return', function() awful.spawn(apps.terminal) end,
	          { description = 'Open terminal (Alacritty)', group = 'Launcher' }),

	awful.key({ super }, 'b', function() awful.spawn(apps.browser) end,
	          { description = 'Open browser (Brave)', group = 'Launcher' }),

	awful.key({ super }, 'c', function() awful.spawn(apps.dev) end,
	          { description = 'Open IDE (VS Code)', group = 'Launcher' }),

	awful.key({ super }, 'e', function() awful.spawn(apps.files) end,
	          { description = 'Open file manager (Thunar)', group = 'Launcher' }),

	awful.key({ super }, 'v', function() awful.spawn(apps.media) end,
	          { description = 'Open media player (VLC)', group = 'Launcher' }),

	awful.key({ super }, 'r', function() awful.spawn('rofi -show combi') end,
	          { description = 'Run command (Rofi combi)', group = 'Launcher'}),

	awful.key({ super }, 'l', function() awful.spawn(apps.lock) end,
	          { description = 'Lock your screen (i3lock-fancy)', group = 'Launcher'}),

	awful.key({ super }, 'g', function() awful.spawn(apps.game) end,
	          { description = 'Open game laucher (Lutris)', group = 'Launcher'})
}

-- Control related keybindings.

awful.keyboard.append_global_keybindings {
	awful.key({}, 'XF86AudioMute', function() awful.spawn.with_shell('amixer -D pulse set Master toggle') end,
              { description = '(un)mute audio', group = 'Control' }),
}

-- Tags related keybindings.

awful.keyboard.append_global_keybindings {
	awful.key({ super }, 'Up',   awful.tag.viewprev,
	          { description = 'View previous', group = 'Tag/Workspace' }),

	awful.key({ super }, 'Down',  awful.tag.viewnext,
	          { description = 'View next', group = 'Tag/Workspace' }),

	awful.key({ super }, 'Escape', awful.tag.history.restore,
	          { description = 'Go back', group = 'Tag/Workspace' }),
}

-- Focus related keybindings.

awful.keyboard.append_global_keybindings {
	awful.key({ super }, 'j', function()
		awful.client.focus.byidx(1)
	end, { description = 'Focus next client', group = 'Client' }),

	awful.key({ super }, 'k', function()
		awful.client.focus.byidx(-1)
	end, { description = 'Focus previous client', group = 'Client' }),

	awful.key({ super }, 'Tab', function()
		awful.client.focus.history.previous()

		if client.focus then
			client.focus:raise()
		end
	end, { description = 'Go back', group = 'Client' }),

	awful.key({ super, shift }, 'j', function() awful.screen.focus_relative(1) end,
	          { description = 'Focus next screen', group = 'Screen' }),

	awful.key({ super, shift }, 'k', function() awful.screen.focus_relative(-1) end,
	          { description = 'Focus previous screen', group = 'Screen' }),

	awful.key({ super, shift }, 'n', function()
		local c = awful.client.restore()

		-- Focus restored client.

		if c then
			c:activate { raise = true, context = 'key.unminimize' }
		end
	end, { description = 'Restore minimized', group = 'Client' }),
}

-- Layout related keybindings.

awful.keyboard.append_global_keybindings {
	awful.key({ super, ctrl }, 'j', function() awful.client.swap.byidx(  1) end,
	          {description = 'Swap with next client', group = 'Client'}),

	awful.key({ super, ctrl }, 'k', function() awful.client.swap.byidx(-1) end,
	          { description = 'Swap with previous client', group = 'Client' }),

	awful.key({ super }, 'u', awful.client.urgent.jumpto,
	          { description = 'Jump to urgent client', group = 'Client' }),

	awful.key({ super }, 'o', function() awful.tag.incmwfact(0.05) end,
	          { description = 'Increase master width factor', group = 'Layout' }),

	awful.key({ super }, 'i', function() awful.tag.incmwfact(-0.05) end,
	          { description = 'Decrease master width factor', group = 'Layout' }),

	awful.key({ super, shift }, 'h', function() awful.tag.incnmaster(1, nil, true) end,
	          { description = 'Increase the number of master clients', group = 'Layout' }),

	awful.key({ super, shift }, 'l', function() awful.tag.incnmaster(-1, nil, true) end,
	          { description = 'Decrease the number of master clients', group = 'Layout' }),

	awful.key({ super, ctrl }, 'h', function() awful.tag.incncol(1, nil, true) end,
	          { description = 'Increase the number of columns', group = 'Layout' }),

	awful.key({ super, ctrl }, 'l', function() awful.tag.incncol(-1, nil, true) end,
	          { description = 'Decrease the number of columns', group = 'Layout' }),

	awful.key({ super }, 'space', function() awful.layout.inc(1) end,
	          { description = 'Select next layout', group = 'Layout' }),

	awful.key({ super, shift }, 'space', function() awful.layout.inc(-1) end,
	          { description = 'select previous', group = 'Layout' }),
}

-- Special tag related keybindings.

awful.keyboard.append_global_keybindings({
	awful.key {
		modifiers   = { super },
		keygroup    = 'numrow',
		description = 'Only view tag',
		group       = 'Tag/Workspace',
		on_press    = function(index)
			local screen = awful.screen.focused()
			local tag    = screen.tags[index]

			if tag then
				tag:view_only()
			end
		end,
	},

	awful.key {
		modifiers   = { super, ctrl },
		keygroup    = 'numrow',
		description = 'Toggle tag',
		group       = 'Tag/Workspace',
		on_press    = function(index)
			local screen = awful.screen.focused()
			local tag    = screen.tags[index]

			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	},

	awful.key {
		modifiers = { super, shift },
		keygroup    = 'numrow',
		description = 'Move focused client to tag',
		group       = 'Tag/Workspace',
		on_press    = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]

				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	},

	awful.key {
		modifiers   = { super, ctrl, shift },
		keygroup    = 'numrow',
		description = 'Toggle focused client on tag',
		group       = 'Tag/Workspace',
		on_press    = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]

				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	},

	awful.key {
		modifiers   = { super },
		keygroup    = 'numpad',
		description = 'Select layout directly',
		group       = 'Layout',
		on_press    = function(index)
			local t = awful.screen.focused().selected_tag
			
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}
})