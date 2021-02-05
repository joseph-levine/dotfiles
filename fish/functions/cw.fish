function cw
    if set -q cmd (which $argv[1])
        cat $cmd
    else
        type $argv[1]
    end
end
