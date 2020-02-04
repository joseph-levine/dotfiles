#jl
starship init fish | source

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/Users/josephle/.composer/vendor/bin" $fish_user_paths
set -g fish_user_paths "/Users/josephle/.cargo/bin" $fish_user_paths
set -g fish_user_paths "/Users/josephle/bin" $fish_user_paths
set -g fish_user_paths "bin" $fish_user_paths

set -g fun ~/.config/fish/functions

ssh-add -K > /dev/null 2>&1

alias activate='source venv/bin/activate.fish'
alias aliases='alias | bat -l zsh --style plain'
alias bat='bat --style=snip'
alias ding='echo '
alias git-aliases='alias | grep "git" | bat -l zsh --style plain'
alias hosts='sudo $EDITOR /etc/hosts'
alias nods='watch -n300 find ~ -type f -name ".DS_Store" -delete'
alias non-git-aliases='alias | grep -v "git" | bat -l zsh --style plain'
alias rmds='find . -type f -name ".DS_Store" -delete'
alias rsyncProd="rsync -rav prod:/var/www/html $HOME/Developer/senate.mn/"
alias shell-pip-up="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias shutdown='sudo shutdown -h now'
alias sshconfig='$EDITOR ~/.ssh/config'
alias timestamp='date +"%s"'
alias units='gunits'
alias vboxmanage='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'
alias wipe=':>'
alias dotrc="vim ~/.config/fish/config.fish"

source $HOME/.config/fish/git.fish
