# If you come from bash you might have to change your $PATH.
export PATH="${HOME}/bin:${PATH}"
mysqlPath='/usr/local/opt/mysql-client/bin'
pgPath='/usr/local/opt/libpq/bin'
export PATH="${PATH}:${mysqlPath}"
export PATH="${PATH}:/usr/local/sbin"
export PATH="${PATH}:${HOME}/.composer/vendor/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/.symfony/bin"
export PATH="${PATH}:${HOME}/.dotnet"
export PATH="${PATH}:${HOME}/.dotnet/tools"
export PATH="${PATH}:${pgPath}"

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

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
# Add wisely, as too many plugins slow down shell startup

source $ZSH/oh-my-zsh.sh

# User configuration
if type -p brew >/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
autoload -U compinit && compinit

if type "brew" > /dev/null; then
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"
fi
export EDITOR='vim'
TODO="${HOME}/OneDrive/todo/todo.txt"
if [ -d $TODO ]; then
    export TODO
fi
export AD_USER='josephl'
DOTNET_ROOT="${HOME}/.dotnet"
if [ -d $DOTNET_ROOT ]; then
    export DOTNET_ROOT
fi


# ssh
ssh-add -K >/dev/null 2>&1

alias aliases='alias | bat -l zsh --style plain'
alias ding='echo '
alias dotrc="zshrc"
alias git-aliases='alias | grep "git" | bat -l zsh --style plain'
alias hosts='sudo $EDITOR /etc/hosts'
alias listeners='sudo lsof -iTCP -sTCP:LISTEN -n -P'
alias usr-ports-in-use="lsof -iTCP -sTCP:LISTEN -n -P | awk 'FNR >= 2 { print \$9 }' | cut -f 2 -d ':' | sort -n -u"
if type -p exa >/dev/null; then
    alias ls='exa'
fi
alias nods='find ~ -type f -name ".DS_Store" -delete'
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

alias inkscape='/Applications/Inkscape.app/Contents/MacOS/inkscape'
alias vboxmanage='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'

export BAT_STYLE='snip'
if type -p bat >/dev/null; then
    alias cat='bat'
fi

alert() { while true; do sleep 1 && printf ; done; }
bool() { if [[ "$@" ]]; then echo 'true'; else echo 'false'; fi }
cw() { cat $(which $1); }
docker-exec() { docker exec -it "${@-:test\:latest}" /bin/bash; }
dns() { sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder; }
inkscape-png() { /Applications/Inkscape.app/Contents/MacOS/inkscape "$1" --export-file="$1.png" -D --export-type=png -d "${2:-90}"; }
minikube-cleanup() { for m in ${TMPDIR}minikube*; do rm "$m"; done; }
sshfs() { mkdir ~/$1; \sshfs $1:/ $1; }
timer() { sleep "$@" && alert; }
unsshfs() { umount $1; rmdir ~/$1; }

if type -p go > /dev/null; then
    export GOPATH="$(go env GOPATH)"
fi

if type -p direnv > /dev/null; then
    #eval "$(direnv hook zsh)"
fi
