if [ -r "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
if [ -r "${HOME}/.composer/vendor/bin" ]; then
    export PATH="${PATH}:${HOME}/.composer/vendor/bin"
fi
if [ -r "${HOME}/.symfony/bin" ]; then
    export PATH="${PATH}:${HOME}/.symfony/bin"
fi
if type -p go > /dev/null; then
    GOPATH="$(go env GOPATH)"
    export GOPATH
fi
DOTNET_ROOT="${HOME}/.dotnet"
if [ -d "$DOTNET_ROOT" ]; then
    export DOTNET_ROOT
    export PATH="${PATH}:${DOTNET_ROOT}"
    export PATH="${PATH}:${DOTNET_ROOT}/tools"
fi
if [ -d "$HOME/bin" ]; then
    export PATH="$PATH:$HOME/bin"
fi
SHELL_SESSIONS_DISABLE=1
export SHELL_SESSIONS_DISABLE
