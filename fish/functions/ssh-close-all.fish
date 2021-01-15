function ssh-close-all
    set any_open_connections (find "$HOME/.ssh" -maxdepth 1 -name 'socket*' -print -quit)
    if test -n "$any_open_connections"
        for socket in "$HOME"/.ssh/socket*
            set bn (basename "$socket")
            ssh -S "$socket" -O exit "$bn"
        end
    end
end
