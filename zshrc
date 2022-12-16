# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ -x /opt/homebrew/bin/brew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(direnv git ssh-close vi-mode z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='nvim'
alias vi="$EDITOR"
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias aliases='alias | cat'
if type -p bat >/dev/null; then
    export BAT_STYLE='snip'
    alias cat='bat'
fi
if [ $(uname) = 'Darwin' ] && [ -n "$ALACRITTY_SOCKET" ]; then
    if ! type -p alacritty >/dev/null; then
        alias alacritty="/Applications/Alacritty.app/Contents/MacOS/alacritty"
    fi
    alias ding='osascript -e "beep"'
elif type -p tput >/dev/null; then
    alias ding='tput bel'
else
    alias ding='echo '
fi
alias dotrc="zshrc"
alias git-aliases='alias | grep "git" | bat -l zsh --style plain'
alias hosts='sudo $EDITOR /etc/hosts'
if type -p kubectl >/dev/null; then
    alias ka='kubectl apply -f'
fi
inkscape='/Applications/Inkscape.app/Contents/MacOS/inkscape'
if [ -x "$inkscape" ]; then
    alias inkscape=$inkscape
    inkscape-png() {
        /Applications/Inkscape.app/Contents/MacOS/inkscape "$1" \
            --export-file="$1.png" \
            -D \
            --export-type=png \
            -d "${2:-90}"
    }
fi
alias listeners='sudo lsof -iTCP -sTCP:LISTEN -n -P'
if type -p exa >/dev/null; then
    alias ls='exa'
    alias ll='ls -lbg'
    alias lll='ls -lbg@ --git'
fi
if type -p mtr >/dev/null; then
    alias mtr='TERM=vt220 sudo mtr'
fi
if type -p watch >/dev/null; then
    alias nods="watch -n300 find $HOME -type f -name '.DS_Store' -delete"
fi
alias mkbin='install /dev/null'
alias mktg='cd $(mktemp -d) && git init'
alias non-git-aliases='alias | grep -v "git" | bat -l zsh --style plain'
alias rmds="find $HOME -type f -name '.DS_Store' -delete"
alias rmtg='p=${PWD:P}; if [[ $p = $TMPDIR/* ]]; then printf "remove %s?" "$p"; read -r confirm; case $confirm in [Yy]* ) cd "$HOME" || exit; rm -rf "$p";; *) :;; esac; fi'
alias shell-pip-up="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias sshconfig="$EDITOR $HOME/.ssh/config"
if type -p todo.sh >/dev/null; then
    alias t='todo.sh'
fi
alias timestamp='date +"%s"'
if type -p gunits >/dev/null; then
    alias units='gunits'
fi
alias usr-ports-in-use="lsof -iTCP -sTCP:LISTEN -n -P | awk 'FNR >= 2 { print \$9 }' | cut -f 2 -d ':' | sort -n -u"
if type -p nvim >/dev/null; then
    alias vimrc="$EDITOR $HOME/.config/nvim/init.vim"
else
    alias vimrc="$EDITOR $HOME/.vimrc"
fi
alias wipe=':>'
alias zshrc="$EDITOR $HOME/.zshrc"

cw() { f=$(which "$1"); cat "$f"; }
dns() {
    sudo brew services restart dnsmasq
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder;
}
exdocker() { docker exec -it "${1}" /bin/sh -c 'if [ -x /bin/bash ]; then /bin/bash; else /bin/sh; fi'; }
alias ex='exdocker'
sshfs() { mkdir "$HOME/$1"; \sshfs "$1":/ "$HOME/$1"; }
timer() { sleep "$@" && alert; }
unsshfs() { umount "$1"; rmdir "$1"; }

if type -p direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
