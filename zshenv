
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

XDG_CACHE_HOME="$HOME/.cache"
export XDG_CACHE_HOME

XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_HOME

XDG_STATE_HOME="$HOME/.local/state"
export XDG_STATE_HOME

# cargo
if type -p rustup-init > /dev/null; then
    CARGO_HOME="$XDG_DATA_HOME"/cargo
    export CARGO_HOME
    if [ -r "$CARGO_HOME/env" ]; then
         . "$CARGO_HOME/env"
    fi
fi

# go
if type -p go > /dev/null; then
    GOPATH="$(go env GOPATH)"
    export GOPATH
fi

# direnv
if type -p direnv > /dev/null; then
    DIRENV_LOG_FORMAT=''
    export DIRENV_LOG_FORMAT
fi

# dotnet
DOTNET_ROOT="$HOME/.dotnet"
if [ -d "$DOTNET_ROOT" ]; then
    export DOTNET_ROOT
    PATH="$PATH:$DOTNET_ROOT"
    PATH="$PATH:$DOTNET_ROOT/tools"
fi

# my bins & scripts
if [ -d "$HOME/bin" ]; then
    PATH="$PATH:$HOME/bin"
fi

# n (node)
N_PREFIX="$HOME/Library/n"
if [ -d "$N_PREFIX" ]; then
    export N_PREFIX
    PATH="$PATH:$N_PREFIX/bin"
fi

# vmware
vmware="/Applications/VMware Fusion Tech Preview.app/Contents/Library"
if [ -d "$vmware" ]; then
    PATH="$PATH:$vmware"
fi

# macos
SHELL_SESSIONS_DISABLE=1
export SHELL_SESSIONS_DISABLE

# homebrew
HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ENV_HINTS


if type -p psql > /dev/null; then
    export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
    export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
    export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
    export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
fi
export PATH
