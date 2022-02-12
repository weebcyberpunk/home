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

# enable color support of ls and also add handy aliases

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# set prompt
PS1='%B%F{blue}%1~%f%b $ '

# aliases

alias upgrade='yay -Syu'
alias pyv='source ~/Etc/python3.10/bin/activate' # activate python venv
alias rick='~/Etc/roll.sh' # runs script of https://github.com/keroserene/rickrollrc/
alias clear='clear && pfetch'
alias music-dl='youtube-dl -x --audio-format mp3'

# display pfetch
pfetch
