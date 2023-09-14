function ssh-close
    ssh -S "$HOME/.ssh/"$argv[1] -O exit $argv[1]
end
