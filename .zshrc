# If you come from bash you might have to change your $PATH.
export PATH="${HOME}/bin:${PATH}"
mysqlPath='/usr/local/opt/mysql-client/bin'
pgPath='/usr/local/opt/libpq/bin'
export PATH="${PATH}:${mysqlPath}"
export PATH="${PATH}:/usr/local/sbin"
export PATH="${PATH}:${HOME}/.composer/vendor/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:./bin"
export PATH="${PATH}:${HOME}/.symfony/bin"
export PATH="${PATH}:${pgPath}"
#export PATH="${PATH}:${HOME}/bin"

# Path to your oh-my-zsh installation.
export ZSH="/Users/josephle/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Powerline9k
POWERLEVEL9K_MODE='nerdfont-complete'
# Powerline10k

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  git
  gpg-agent
  osx
  ssh-close
  terraform
  zsh-completions
)

source $ZSH/oh-my-zsh.sh
source /usr/local/etc/profile.d/z.sh

# User configuration
autoload -U compinit && compinit

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
ssh-add -K >/dev/null 2>&1
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"

#bindkey "OA" history-beginning-search-backward
#bindkey "OB" history-beginning-search-forward

alias activate='source venv/bin/activate'
alias aliases='alias | bat -l zsh --style plain'
alias ding='echo '
alias git-aliases='alias | grep "git" | bat -l zsh --style plain'
alias hosts='sudo $EDITOR /etc/hosts'
alias listeners='sudo lsof -iTCP -sTCP:LISTEN -n -P'
alias ls='exa'
alias nods='watch -n300 find ~ -type f -name ".DS_Store" -delete'
alias non-git-aliases='alias | grep -v "git" | bat -l zsh --style plain'
alias rmds='find . -type f -name ".DS_Store" -delete'
alias rsyncProd="rsync -rav prod:/var/www/html ${HOME}/Developer/senate.mn/"
alias shell-pip-up="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias shutdown='sudo shutdown -h now'
alias sshconfig='$EDITOR ~/.ssh/config'
alias t='todo.sh'
alias timestamp='date +"%s"'
alias units='gunits'
alias vboxmanage='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'
alias vimrc="$EDITOR ~/.vimrc"
alias wipe=':>'
alias zshrc="$EDITOR ~/.zshrc"
alias dotrc="zshrc"

alias inkscape='/Applications/Inkscape.app/Contents/MacOS/inkscape'

export BAT_STYLE='snip'
alias cat='bat'


originalSSHFS=$(which sshfs)
sshfs() { mkdir ~/$1; $originalSSHFS $1:/ $1; }
unsshfs() { umount $1; rmdir ~/$1; }

cw() { cat $(which $1); }
dns() { sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder; }

alert() { while true; do sleep 1 && printf ; done; }
timer() { sleep "$@" && alert; }

inkscape-png() { /Applications/Inkscape.app/Contents/MacOS/inkscape "$1" --export-file="$1.png" -D --export-type=png -d "${2:-90}"; }

# doesn't work :(
# bool() { if [[ $@ ]]; then echo 'true'; else echo 'false'; fi }

unalias gsd

if type "go" > /dev/null; then
    export GOPATH="$(go env GOPATH)"
fi

# To customize prompt, run `p9k_configure` or edit ~/.p10k.zsh.
source ~/.p10k.zsh
hn=$(hostname)

case $(hostname) in
    *MACPRO*) source "${HOME}/.zshrc-work" ;;
    *Emperor*) source "${HOME}/.zshrc-home" ;;
    *) ;;
esac

eval "$(direnv hook zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
