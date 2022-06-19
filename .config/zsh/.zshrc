# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/home/gg/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE='/home/gg/.local/share/zsh/histfile'
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep notify
unsetopt extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

#
# Custom
#

# Change cursor shape for different vi modes. (ctrl-c ctrl-v from 
# https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc)
function zle-keymap-select () {
	case $KEYMAP in
		vicmd) echo -ne '\e[1 q';;      # block
		viins|main) echo -ne '\e[5 q';; # beam
	esac
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# colored aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# set prompt
PROMPT='%B%F{magenta}%2~%f%b  -> '
RPROMPT='%B%F{cyan}%n%f%b@%B%F{magenta}%m%f%b'

# aliases

# common
alias suckless='rm config.h && sudo make clean install'
alias font-list="fc-list | awk '{gsub(\$1, \"\"); print \$0}'"
alias sxiv='sxiv -b'
# mounting and unmounting
alias mount-drive='udisksctl mount -b /dev/sdb1'
alias umount-drive='udisksctl unmount -b /dev/sdb1'
# downloads and records
alias music-dl='yt-dlp -i -x --audio-format mp3'
alias convert-to-web='ffmpeg -i out.mp4 -c:v libx264 -crf 20 -preset slow -vf format=yuv420p -c:a aac -movflags +faststart output.mp4'
# command configs
alias cbonsai='cbonsai -l -S -i'
alias unimatrix='unimatrix -c magenta'
alias tty-clock='tty-clock -c -C 5 -s'
alias vim='nvim'

# edit line in nvim (very useful to test little scripts)
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# print exit value if != 0
setopt PRINT_EXIT_VALUE

# source plugins
PLUGS_HOME="$HOME/.config/zsh/plugs/"
source $PLUGS_HOME/catppuccin-zsyntaxhi/catppuccin-zsh-syntax-highlighting.zsh
source "$PLUGS_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$PLUGS_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
