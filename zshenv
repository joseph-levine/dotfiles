# cargo
if [ -r "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# composer
if [ -r "$HOME/.composer/vendor/bin" ]; then
    PATH="$PATH:$HOME/.composer/vendor/bin"
fi

# symfony
if [ -r "$HOME/.symfony/bin" ]; then
    PATH="$PATH:$HOME/.symfony/bin"
fi

# go
if type -p go > /dev/null; then
    GOPATH="$(go env GOPATH)"
    export GOPATH
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
N_PREFIX="$HOME/.n"
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

export PATH
