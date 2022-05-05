#!/usr/bin/sh
# moving configs away from ~
export XAUTHORITY="$HOME/.Xauthority"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.local/share/zsh/histfile"
export GNUPGHOME="$HOME/.local/share/gnupg"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export WGETRC="$HOME/.config/wget/wgetrc"
export CARGO_HOME="$HOME/.local/share/cargo"

# default programs
export EDITOR=vim
export BROWSER=firefox
export TERMINAL=st

# sensible defaults
export QT_STYLE_OVERRIDE=gtk2
export GTK_THEME=Dracula
