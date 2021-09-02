# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
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
alias ding='echo '
alias dotrc="zshrc"
alias git-aliases='alias | grep "git" | bat -l zsh --style plain'
alias hosts='sudo $EDITOR /etc/hosts'
alias listeners='sudo lsof -iTCP -sTCP:LISTEN -n -P'
alias usr-ports-in-use="lsof -iTCP -sTCP:LISTEN -n -P | awk 'FNR >= 2 { print \$9 }' | cut -f 2 -d ':' | sort -n -u"
if type -p exa >/dev/null; then
    alias ls='exa'
fi
alias nods="find ${HOME} -type f -name '.DS_Store' -delete"
alias non-git-aliases='alias | grep -v "git" | bat -l zsh --style plain'
alias rmds='nods'
alias rsync='rsync -a --info=progress2'
alias shell-pip-up="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias sshconfig='$EDITOR ~/.ssh/config'
if type -p todo.sh >/dev/null; then
    alias t='todo.sh'
fi
alias timestamp='date +"%s"'
if type -p gunits >/dev/null; then
    alias units='gunits'
fi
alias vimrc="$EDITOR ~/.vimrc"
alias wipe=':>'
alias zshrc="$EDITOR ~/.zshrc"

inkscape='/Applications/Inkscape.app/Contents/MacOS/inkscape'
if [ -x "$inkscape" ]; then
    alias inkscape=$inkscape
fi
vboxmanage='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'
if [ -x "$vboxmanage" ]; then
    alias vboxmanage=$vboxmanage
fi

if type -p bat >/dev/null; then
    export BAT_STYLE='snip'
    alias cat='bat'
fi

alert() { while true; do sleep 1 && printf ; done; }
bool() { if [[ "$@" ]]; then echo 'true'; else echo 'false'; fi }
cw() { cat $(which $1); }
docker-exec() { docker exec -it "${@-:test\:latest}" /bin/bash; }
dns() {
    sudo brew services restart dnsmasq
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder;
}
inkscape-png() { /Applications/Inkscape.app/Contents/MacOS/inkscape "$1" --export-file="$1.png" -D --export-type=png -d "${2:-90}"; }
sshfs() { mkdir ~/$1; \sshfs $1:/ $1; }
timer() { sleep "$@" && alert; }
unsshfs() { umount $1; rmdir ~/$1; }


if type -p direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

