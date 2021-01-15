function ssh-close
    ssh -S "$HOME/.ssh/$1" -O exit "$1"
end
