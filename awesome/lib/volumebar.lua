-------------------------------------------------
-- Volume Bar Widget for Awesome Window Manager
-- Shows the current volume level
-- More details can be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volumebar-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-- modified by NicolasCARPi
-------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")

local request_command = "amixer get Master"

local bar_color = beautiful.fg_normal
local mute_color = "#ff0000"
local background_color = "#3a3a3a"

local volumebar = wibox.widget {
    max_value = 1,
    forced_width = 50,
    paddings = 0,
    border_width = 0.5,
    color = bar_color,
    background_color = background_color,
    shape = gears.shape.bar,
    clip = true,
    margins       = {
        top = 9,
        bottom = 9,
    },
    widget = wibox.widget.progressbar
}

local update_graphic = function(widget, stdout, _, _, _)
    local mute = string.match(stdout, "%[(o%D%D?)%]")
    local volume = string.match(stdout, "(%d?%d?%d)%%")
    volume = tonumber(string.format("% 3d", volume))

    widget.value = volume / 100;
    --if mute == "off" then
    --    widget.color = mute_color
    --    widget.value = volume / 100;
    --else
    --    widget.color = bar_color
    --    widget.value = volume / 100;
    --end
end

volumebar:connect_signal("button::press", function(_,_,_,button)
    -- scroll up
    -- if (button == 4)     then awful.spawn("amixer set Master 2dB+", false)
    if (button == 4)     then awful.spawn("pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo +5%", false)
    -- scroll down
    -- elseif (button == 5) then awful.spawn("amixer set Master 2dB-", false)
    elseif (button == 5) then awful.spawn("pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo -5%", false)
    -- left click
    elseif (button == 1) then awful.spawn("mpc toggle", false)
    -- right click
    elseif (button == 3) then awful.spawn("mpc stop", false)
    end

    spawn.easy_async(request_command, function(stdout, stderr, exitreason, exitcode)
        update_graphic(volumebar, stdout, stderr, exitreason, exitcode)
    end)
end)

watch(request_command, 1, update_graphic, volumebar)

return volumebar
