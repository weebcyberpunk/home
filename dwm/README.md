# DWM

The Dinamic Window Manager is a suckless tilling window manager. To set the statusbar, I created my own script (to be placed in `$HOME/.local/bin`, you will have to set the username on config.def.h (that also is needed for all the dmenu scripts and the suspend script), with execute permission `chmod +x`). I applied to it the patches: cool-autostart, autoresize, swallow, fancybar, functionalgaps, hide-vacant-tags, inplacerotate, alwayscenter.

I also edited manually the source in `dwm.c` to don't overwrite the layout indicator on monocle layout.
