. "$HOME/.cargo/env"
eval $(/opt/homebrew/bin/brew shellenv)
if [ -r "${HOME}/.composer/vendor/bin" ]; then
    export PATH="${PATH}:${HOME}/.composer/vendor/bin"
fi
if [ -r "${HOME}/.symfony/bin" ]; then
    export PATH="${PATH}:${HOME}/.symfony/bin"
fi
if type -p go > /dev/null; then
    export GOPATH="$(go env GOPATH)"
fi
DOTNET_ROOT="${HOME}/.dotnet"
if [ -d "$DOTNET_ROOT" ]; then
    export DOTNET_ROOT
    export PATH="${PATH}:${DOTNET_ROOT}"
    export PATH="${PATH}:${DOTNET_ROOT}/tools"
fi
