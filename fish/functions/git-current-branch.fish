function git-current-branch
    set -x GIT_OPTIONAL_LOCKS 0
    set ref (command git symbolic-ref --quiet HEAD 2>/dev/null)
    set git_status $status
    if test $git_status != 0
        if test $git_status = 128
            return
        end
        set ref (command git rev-parse --short HEAD 2>/dev/null)
    set git_status $status
    if test $git_status != 0
            return
    end
    end
    echo $ref | sed 's/^refs\/heads\///'
end
