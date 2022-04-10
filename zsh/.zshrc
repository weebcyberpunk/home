# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/home/gg/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
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
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# set prompt
PS1='%B%F{blue}%2~%f%b > '

# aliases

# common
alias clear='clear && pfetch'
alias fzf='find * | grep' # emulates a fzf but directly in the cli and not in the finder
alias fzfh='find .* | grep' # same but with only hidden
alias weather='curl wttr.in/curitiba'
alias suckless='rm config.h && sudo make clean install'
alias font-list="fc-list | awk '{gsub(\$1, \"\"); print \$0}'"
# mounting and unmounting
alias mount-drive='udisksctl mount -b /dev/sdb1'
alias umount-drive='udisksctl unmount -b /dev/sdb1'
# downloads and records
alias music-dl='youtube-dl -i -x --audio-format mp3'
alias record-screen='ffmpeg -f x11grab -i :0.0 x11-screen-record.mp4'
alias record-cam='ffmpeg -i /dev/video0 -f alsa -i default webcam-record.mp4'
alias record-mic='ffmpeg -f alsa -i default alsa-mic-record.mp3'
alias take-a-shot='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed' # use mpv to display the webcam on a screen and press s to take a shot
alias record-all='$HOME/.local/bin/record-all.sh' 			      # by default ffmpeg uses a twitter-unsupported codec, this reencodes
alias convert-to-web='ffmpeg -i out.mp4 -c:v libx264 -crf 20 -preset slow -vf format=yuv420p -c:a aac -movflags +faststart output.mp4'
# command configs
alias cbonsai='cbonsai -l -S -i'
alias unimatrix='unimatrix -c cyan'
alias tty-clock='tty-clock -c -C 6 -s'

# edit line in vim (very useful to test little scripts)
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# print exit value if != 0
setopt PRINT_EXIT_VALUE

# display pfetch
pfetch
