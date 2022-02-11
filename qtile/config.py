# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.hook import subscribe 

import os

#
# AUTOSTART
#
@subscribe.startup_once
def autostart():
    os.system("picom &")
    os.system("lxsession &")
    os.system("dunst &")


@subscribe.startup
def wallpaper():
    os.system("nitrogen --restore &")


mod = "mod4"
terminal = "st"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    # 
    # MY KEYBINDGS
    #

    # launcher
    Key([mod, "shift"], "n", lazy.spawn("qutebrowser"), desc="Launch web browser"),
    Key([mod, "shift"], "t", lazy.spawn("thunderbird"), desc="Launch Thunderbird"),
    Key([mod, "shift"], "p", lazy.spawn("gnome-screenshot -i"), desc="Launch screenshot tool"),
    Key([mod, "shift"], "m", lazy.spawn(f"{terminal} -e cmus"), desc = "Launch music player"),
    Key([mod, "shift"], "v", lazy.spawn(f"{terminal} -e vim"), desc = "Launch Vim"),
    Key([mod, "shift"], "f", lazy.spawn("pcmanfm"), desc = "Launch file manager"),
    Key([mod], "a", lazy.spawn("rofi -show drun"), desc="Apps menu"),
    Key([mod], "d", lazy.spawn("dmenu_run"), desc="Apps menu but suckless"),
    
    # volume and music
    Key(["mod1", "control"], "k", lazy.spawn("pamixer -i 1"), desc="Volume up"),
    Key(["mod1", "control"], "j", lazy.spawn("pamixer -d 1"), desc="Volume down"),
    Key(["mod1", "control"], "m", lazy.spawn("pamixer -t"), desc="Mute"),
    Key(["mod1", "control"], "p", lazy.spawn("cmus-remote -u"), desc="Play/pause"),
    Key(["mod1", "control"], "Right", lazy.spawn("cmus-remote -n"), desc="Next song"),
    Key(["mod1", "control"], "Left", lazy.spawn("cmus-remote -r"), desc="Previous song"),

    # screen and system
    Key(["mod1", "control"], "l", lazy.spawn("clearine"), desc="Logout script"),
    Key([mod], "u", lazy.spawn(f"{terminal} -e yay -Syu"), desc="Upgrade system"),
    Key([mod], "F11", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "control"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layout_theme = {"border_width": 4,
                "margin": 10,
                "border_focus": "4084D6",
                "border_normal": "44475A"
                }

layouts = [
    layout.Columns(**layout_theme, border_on_single=True),
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.Tile(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(**layout_theme),
    layout.Floating(**layout_theme),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='UbuntuMono Nerd Font',
    fontsize=19,
    padding=6,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            widgets=[
                widget.Image(
                    filename="~/.icons/qtile/menu.png",
                    mouse_callbacks={"Button1": lazy.spawn("rofi -show drun")}
                    ),
                widget.CurrentLayoutIcon(),
                widget.GroupBox(
                    this_current_screen_border="4084D6",
                    highlight_method="block"
                    ),
                widget.Prompt(),
                widget.TaskList(
                    margin=0,
                    padding_y=3,
                    icon_size=16,
                    max_title_width=200,
                    highlight_method="block",
                    rounded=False,
                    border="4084D6"
                    ),
                widget.Systray(),
                widget.Cmus(max_chars=60),
                widget.TextBox("|"),
                widget.Image(
                    filename="~/.icons/qtile/volume.png",
                    mouse_callbacks={"Button1": lazy.spawn("pavucontrol")}
                    ),
                widget.PulseVolume(get_volume_command="pamixer --get-volume-human"),
                widget.TextBox("|"),
                widget.Image(
                    filename="~/.icons/qtile/wifi.png"
                    ),
                widget.Wlan(format="{percent:2.0%}"),
                widget.TextBox("|"),
                widget.CheckUpdates(
                    distro="Arch_checkupdates",
                    colour_have_updates="00FF00",
                    display_format="updates: {updates}",
                    no_update_string="up to date",
                    update_interval=600,
                    execute=f"{terminal} -e sudo pacman -Syu"
                    ),
                widget.TextBox("|"),
                widget.BatteryIcon(update_interval=10),
                widget.Battery(
                    format="{percent:2.0%}", 
                    show_short_text=False,
                    update_interval=10,
                    ),
                widget.TextBox("|"),
                widget.Clock(format='%b %d, %H:%M'),
                widget.TextBox("|"),

                widget.Image(
                    filename="~/.icons/qtile/logout.png",
                    mouse_callbacks={"Button1": lazy.spawn("clearine")} 
                    ),
                widget.TextBox("|")
            ],
            size=24,
            background="383C4A",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class="gnome-screenshot"),
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
