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

-- Note: this command doesn't work, maybe because of the { or $... So we parse the full output in lua
-- local request_command = "pactl list sinks | grep 'Volume:' | awk 'NR==1{print $5}'"
local request_command = "pactl list sinks"

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

local update_graphic = function(widget, stdout, _, _, exitcode)
    local volume = stdout:match("%s(%d+)%%")
    widget.value = tonumber(volume) / 100
end

volumebar:connect_signal("button::press", function(_,_,_,button)
    -- scroll up
    -- if (button == 4)     then awful.spawn("amixer set Master 2dB+", false)
    if (button == 4)     then spawn.easy_async("pactl set-sink-volume alsa_output.pci-0000_2f_00.4.analog-stereo +3%", function() end)
    -- scroll down
    -- elseif (button == 5) then awful.spawn("amixer set Master 2dB-", false)
    elseif (button == 5) then spawn.easy_async("pactl set-sink-volume alsa_output.pci-0000_2f_00.4.analog-stereo -3%", function() end)
    -- left click
    elseif (button == 1) then spawn.easy_async("mpc toggle", function() end)
    -- right click
    elseif (button == 3) then spawn.easy_async("mpc stop", function() end)
    end

    spawn.easy_async(request_command, function(stdout, stderr, exitreason, exitcode)
        update_graphic(volumebar, stdout, stderr, exitreason, exitcode)
    end)
end)

watch(request_command, 5, update_graphic, volumebar)

return volumebar
