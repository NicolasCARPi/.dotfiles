-- pacman.lua | show number of available updates
-- by NicolasCARPi

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local naughty = require("naughty")

local pacman = wibox.widget.textbox()

-- for some reason the | head -n 1 is not working so we need to split the stdout
function pacman:split(input_str, sep)
    if sep == nil then
        sep = "\n"
    end
    local t={}
    local i=0
    for str in string.gmatch(input_str, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- display current song
function pacman:show_number()
    watch("/home/ktr/.bin/panel_pacman.sh", 3,
        function(widget, stdout, stderr, exitreason, exitcode)
            widget:set_text(stdout)
        end,
        pacman
    )
end

function pacman:show_packages()
    local cmd = "pacman -Qu"
    local f = assert(io.popen(cmd))
    local out = assert(f:read('*a'))
    naughty.notify {
        icon = "/home/ktr/.config/awesome/pacman.png",
        text = out,
        title = "Packages to update",
        timeout = 15, hover_timeout = 0.5,
        width = 210,
    }
end

-- init
pacman:show_number()

pacman:connect_signal("mouse::enter", function() pacman:show_packages() end)

return pacman

