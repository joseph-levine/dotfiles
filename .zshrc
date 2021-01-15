# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# If you come from bash you might have to change your $PATH.
export PATH="${HOME}/bin:${PATH}"
mysqlPath='/usr/local/opt/mysql-client/bin'
pgPath='/usr/local/opt/libpq/bin'
export PATH="${PATH}:${mysqlPath}"
export PATH="${PATH}:/usr/local/sbin"
export PATH="${PATH}:${HOME}/.composer/vendor/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/.symfony/bin"
export PATH="${PATH}:${pgPath}"
#export PATH="${PATH}:${HOME}/bin"

# User configuration
if type -p brew >/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
autoload -U compinit && compinit

if type "brew" > /dev/null; then
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"
fi
export EDITOR='vim'
export TODO="${HOME}/OneDrive/todo/todo.txt"


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
alias nods='watch -n300 find ~ -type f -name ".DS_Store" -delete'
alias non-git-aliases='alias | grep -v "git" | bat -l zsh --style plain'
alias rmds='find . -type f -name ".DS_Store" -delete'
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
alias use-minikube='kubectl config use-context minikube'
alias use-production='kubectl config use-context production'
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

if type "go" > /dev/null; then
    export GOPATH="$(go env GOPATH)"
fi

eval "$(direnv hook zsh)"

autoload -U +X bashcompinit && bashcompinit
if type -p vault >/dev/null; then
    complete -o nospace -C /usr/local/bin/vault vault
fi
if type -p kustomize >/dev/null; then
    complete -o nospace -C /usr/local/bin/kustomize kustomize
fi

hn=$(hostname)

case $(hostname) in
    *MACPRO*) source "${HOME}/.zshrc-work" ;;
    *Emperor*) source "${HOME}/.zshrc-home" ;;
    *) ;;
esac

