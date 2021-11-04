eval (/opt/homebrew/bin/brew shellenv)
# can't be in global because of interpolation
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
if test -d "$HOME/.composer/vendor/bin"
    set -g fish_user_paths "$HOME/.composer/vendor/bin" $fish_user_paths
end
if test -d "$HOME/.cargo/bin"
    set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
end
if test -d "$HOME/bin"
    set -g fish_user_paths "$HOME/bin" $fish_user_paths
end

set -g fun ~/.config/fish/functions

set -x EDITOR "vim"
if type -p n >/dev/null
    set -x N_PREFIX "$HOME/.n"
    set n_bins "$N_PREFIX/bin"
    if test ! -d "$n_bins"
        mkdir -p "$n_bins"
    end
    set -g fish_user_paths "$n_bins" $fish_user_paths
end

alias aliases='alias | cat'
alias cat='bat --style=plain -P'
if test (uname) = 'Darwin' && test -n "$ALACRITTY_LOG"
    alias ding='osascript -e "beep"'
else if type -p tput >/dev/null
    alias ding='tput bel'
else 
    alias ding='echo '
end
alias dotrc="$EDITOR ~/.config/fish/config.fish"
alias git-aliases='alias | grep "git" | bat -l zsh --style plain'
alias hosts="sudo $EDITOR /etc/hosts"
alias listeners='sudo lsof -iTCP -sTCP:LISTEN -n -P'
if type -p kubectl >/dev/null
    alias ka='kubectl apply -f'
end
alias usr-ports-in-use="lsof -iTCP -sTCP:LISTEN -n -P | awk 'FNR >= 2 { print \$9 }' | cut -f 2 -d ':' | sort -n -u"
if type -p exa >/dev/null
    alias ls='exa'
    alias ll='ls -lbg'
    alias lll='ll -@ --git'
end
if type -p mtr >/dev/null
    alias mtr='TERM=vt220 sudo mtr'
end
if type -p watch >/dev/null
    alias nods='watch -n300 find ~ -type f -name ".DS_Store" -delete'
end
alias non-git-aliases='alias | grep -v "git" | bat -l zsh --style plain'
alias rmds='find . -type f -name ".DS_Store" -delete'
alias sec='security show-keychain-info >/dev/null 2>&1 && echo "unlocked" || security unlock-keychain'
alias shell-pip-up="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias sshconfig="$EDITOR ~/.ssh/config"
if type -p todo.sh >/dev/null
    alias t='todo.sh -d ~/.todo.cfg'
end
alias timestamp='date +"%s"'
if type -p gunits >/dev/null
    alias units='gunits'
end
alias vimrc="$EDITOR ~/.vimrc"
alias wipe=':>'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias ....... 'cd ../../../../../..'
alias ........ 'cd ../../../../../../..'
alias ......... 'cd ../../../../../../../..'

source $HOME/.config/fish/git.fish

#set setbg $HOME/bin/term-background
#if test -x $setbg
#    sh -c "$setbg none >/dev/null 2>&1 </dev/null &"
#end
direnv hook fish | source
