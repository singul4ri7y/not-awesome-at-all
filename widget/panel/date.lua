local date = wibox.widget.textclock('<span font= "' .. default_font .. 'Bold 9' .. '">%a %b %d, %Y (%p)</span>')

-- Attach a calendar to the textclock.
-- Credit goes to 'kylekewly'.

local calendar = awful.widget.calendar_popup.month {
    screen       = scr,
    start_sunday = true,
    week_numbers = true
}

-- Now attach the calendar to the date widget.

calendar:attach(date)

return wibox.container.margin(date, dpi(5), dpi(5), dpi(12), dpi(12))