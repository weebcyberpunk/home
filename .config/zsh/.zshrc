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

# prompt
PROMPT='%B%F{magenta}%2~%f%b  -> '
RPROMPT='%B%F{cyan}%n%f%b@%B%F{magenta}%m%f%b'

# if on a framebuffer, fix the colors and the cursor, increase the font, 
# remove the nerd icon on the prompt and start tmux
if [ "$TERM" = "linux" ]; then
    PROMPT="%B%F{magenta}%2~%f%b -> "
    setfont /usr/share/kbd/consolefonts/solar24x32
    echo -en  "\e]P01E1E2E" # black
    echo -en  "\e]P1F28FAD" # red
    echo -en  "\e]P2ABE9B3" # green
    echo -en  "\e]P3FAE3B0" # yellow
    echo -en  "\e]P496CDFB" # blue
    echo -en  "\e]P5F5C2E7" # magenta
    echo -en  "\e]P689DCEB" # cyan
    echo -en  "\e]P7FFFFFF" # white
    clear #for background artifacting
    echo -e "\e[?16;0;250c"

    if [ "$TMUX" == "" ]
    then
        tmux
        exit
    fi
fi

#
# aliases
#

# colored aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

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
alias hi='highlight -O ansi'

# edit line in nvim (very useful to test little scripts)
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# print exit value if != 0
setopt PRINT_EXIT_VALUE

# source plugins
PLUGS_HOME=$HOME"/.config/zsh/plugs"
source $PLUGS_HOME"/catppuccin-zsyntaxhi/catppuccin-zsh-syntax-highlighting.zsh"
source $PLUGS_HOME"/zsh-autosuggestions/zsh-autosuggestions.zsh"
source $PLUGS_HOME"/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
