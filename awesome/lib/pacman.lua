-- pacman.lua | show number of available updates
-- by NicolasCARPi

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local naughty = require("naughty")
local beautiful = require("beautiful")

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
    watch(confdir .. "/lib/pacman.sh", 3,
        function(widget, stdout, stderr, exitreason, exitcode)
            widget:set_text(stdout .. " | ")
        end,
        pacman
    )
end

function pacman:show_packages()
    local cmd = "pacman -Quq"
    local f = assert(io.popen(cmd))
    local out = assert(f:read('*a'))
    naughty.notify {
        icon = confdir .. "/lib/pacman.png",
        text = out,
        title = "Packages to update",
        timeout = 15, hover_timeout = 0.5,
        width = 210,
    }
end

local w = wibox {
    height = 100,
    width = 200,
    ontop = true,
    screen = mouse.screen,
    expand = true,
    bg = beautiful.bg_normal,
    max_widget_size = 500
}
w:setup {
    border_width = 0,
    colors = {
        '#5ea19d',
        '#55918e',
        '#4b817e',
    },
    display_labels = false,
    forced_width = 25,
    id = 'pie',
    widget = wibox.widget.textbox
}

function pacman:get_pkg_list()
    local cmd = "pacman -Quq"
    local f = assert(io.popen(cmd))
    return assert(f:read('*a'))
end


function pacman:show_pkg_list()
    awful.placement.top_right(w, { margins = {top = 25, right = 10}})
    w.pie:set_text(pacman:get_pkg_list())
    w.visible = not w.visible
end

-- init
pacman:show_number()

pacman:connect_signal("mouse::enter", function() pacman:show_packages() end)
pacman:connect_signal("button::press", function(_, _, _, button)
    -- left click
    if (button == 1) then
        -- launch update command in new tmux pane
        awful.util.spawn(terminal .. " -e tmux new-window 'echo \"Launching full system update\" && sudo pacman -Syu'")
    end
end)

return pacman
