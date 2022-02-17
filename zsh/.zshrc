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
PS1='%B%F{blue}%1~%f%b $ '

# aliases

alias upgrade='yay -Syu'
alias pyv='source ~/Etc/python3.10/bin/activate' # activate python venv
alias rick='~/Etc/roll.sh' # runs script of https://github.com/keroserene/rickrollrc/
alias clear='clear && pfetch'
alias music-dl='youtube-dl -x --audio-format mp3'
alias fz='vim $(fzf)' # for some unknown reason if alias fzf it bugs
alias mount-drive='udisksctl mount -b /dev/sdb1'
alias umount-drive='udisksctl unmount -b /dev/sdb1'

# edit line in vim (very useful to test little scripts)
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# print exit value if != 0
setopt PRINT_EXIT_VALUE

# window title

# as I use ST, it avoids setting the tile inside vim term
if [ $TERM != "xterm-256color" ]
then
	TITLE="Terminal"
	echo -ne '\033k'$TITLE'\033\\'
fi

function precmd() {
	echo -ne '\033k'$TITLE'\033\\'
}

# display pfetch
pfetch
