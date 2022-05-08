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

# colored aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# set prompt
PS1='%B%F{magenta}%2~%f%b  -> '

# aliases

# common
alias suckless='rm config.h && sudo make clean install'
alias font-list="fc-list | awk '{gsub(\$1, \"\"); print \$0}'"
# mounting and unmounting
alias mount-drive='udisksctl mount -b /dev/sdb1'
alias umount-drive='udisksctl unmount -b /dev/sdb1'
# downloads and records
alias music-dl='youtube-dl -i -x --audio-format mp3'
alias convert-to-web='ffmpeg -i out.mp4 -c:v libx264 -crf 20 -preset slow -vf format=yuv420p -c:a aac -movflags +faststart output.mp4'
# command configs
alias cbonsai='cbonsai -l -S -i'
alias unimatrix='unimatrix -c magenta'
alias tty-clock='tty-clock -c -C 6 -s'

# edit line in vim (very useful to test little scripts)
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# print exit value if != 0
setopt PRINT_EXIT_VALUE

# source plugins
PLUGS_HOME="$HOME/.config/zsh/plugs/"
source "$PLUGS_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$PLUGS_HOME/fast-syntax-highlighting/F-Sy-H.plugin.zsh"
