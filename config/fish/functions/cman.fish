function cman --description "wrap 'man' for COLORS!"
    set -x LESS_TERMCAP_md (set_color -o brred)
    set -x LESS_TERMCAP_me (set_color normal)
    set -x LESS_TERMCAP_so (set_color -o yellow -b blue)
    set -x LESS_TERMCAP_se (set_color normal)
    set -x LESS_TERMCAP_us (set_color -u brgreen)
    set -x LESS_TERMCAP_ue (set_color normal)

    command man $argv
end
