#!/bin/sh

echo "ASSUMING: cwd is $PWD"
printf "Control-c if it is not. Else, Enter"
read -r

ln_home() {
    if [ ! -L "$HOME/$2" ]; then
        if [ -e "$HOME/$2" ]; then
            mv "$HOME/$2" "$HOME/$2.bak"
	fi
	ln -s "$PWD/$1" "$HOME/$2"
    fi
}

if ! type brew >/dev/null 2>&1; then
    # oy...
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo 'homebrew'
brew update
while IFS= read -r line; do
    brew tap "$line"
done < brew/taps

while IFS= read -r line; do
    brew install "$line"
done < brew/brews

while IFS= read -r line; do
    brew install --cask "$line"
done < brew/casks
brew cleanup

if [ ! -d /etc/resolver ]; then
    sudo mkdir /etc/resolver
    echo 'nameserver 127.0.0.1' | sudo tee -a '/etc/resolver/test'
fi

if [ ! -r "$HOME/.vim/autoload/plug.vim" ]; then
    echo 'vim plug'
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln_home vimrc .vimrc
    ln_home shared.vimrc .shared.vimrc
    ln_home idea.vimrc .ideavimrc
    vim -c PlugInstall -c qall
fi

mkdir -p "$HOME/.config"

echo 'home ln'
ln_home global.gitignore .gitignore
ln_home .p10k.zsh .p10k.zsh
ln_home zshenv .zshenv
ln_home zshrc .zshrc

echo 'alacritty'
mkdir -p "$HOME/.config/alacritty"
ln_home alacritty.yml .config/alacritty/alacritty.yml

echo 'bat'
batcfgfile=$(bat config-file)
batcfgdir=$(dirname "$batcfgfile")
mkdir -p "$batcfgdir"
ln -s "$PWD/batconfig" "$batcfgfile"

echo 'fish'
if [ ! -L "$HOME/.config/fish" ]; then
    if [ -d "$HOME/.config/fish" ]; then
        rm -r "$HOME/.config/fish"
    fi
    ln_home fish .config/fish
fi

echo 'explicit'
if [ ! -r "$HOME/.config/homebrew/explicit" ]; then
    mkdir -p "$HOME/.config/homebrew"
    rm -f "$HOME/.config/homebrew/explicit"
    ln_home explicit .config/homebrew/explicit
fi

echo 'see https://github.com/mathiasbynens/dotfiles/blob/main/.macos'
echo 'open save panel'
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "don't save to icloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo 'undo all that auto-substitute-break-my-code stuff'
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo 'scroll the correct direction'
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo 'hide menu bar'
defaults write NSGlobalDomain _HIHideMenuBar -bool true

echo 'reset spotlight position'
defaults write com.apple.Spotlight userHasMovedWindow -bool false

echo 'reboot on power failure (echo in case sudo asks for a pass)'
echo "reboot on powerfail"
sudo pmset -a autorestart 1

echo 'or on freeze (echo in case sudo asks for a pass)'
echo "reboot on freeze"
sudo systemsetup -setrestartfreeze on

echo 'get rid of shadow in screenshots'
defaults write com.apple.screencapture disable-shadow -bool true

echo "Show all the icons on my desktop, I'm old, that's where I like 'em"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo 'file extensions are useful'
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo 'and I know how to change them'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo 'give me back my status bar'
defaults write com.apple.finder ShowStatusBar -bool true

echo 'death to .DS_Store'
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "don't hide useful stuff"
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

echo "but do hide the dock.... even though it's useful..."
defaults write com.apple.dock autohide -bool true

echo 'display sleep on top-right'
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0

echo 'full url'
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo 'web dev safari'
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# shellcheck disable=SC2016
defaults write com.apple.safari NSUserKeyEquivalents '{"Disable JavaScript" = "@$j";}'
# shellcheck disable=SC2016
defaults write com.sequel-ace.sequel-ace NSUserKeyEquivalents '{"Back In History" = "@["; "Forward In History" = "@]";}'

echo "git - I'm me!"
git config --global user.name "Joseph Levine"
printf "git email: "
read -r email;
git config --global user.email "$email"
git config --global core.excludesFile "$HOME/.gitignore"

#printf "sudo set default shell"
#if type fish; then
#echo '   which fish | sudo tee -a /etc/shells'
#echo '   me=$(who -m | awk '{print $1}')'
#echo '   sudo chsh -u "$me" -s "$(which fish)"'
#fi

echo "git dirs..."
git clone git@github.com:tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
git clone git@github.com:joseph-levine/bin.git "$HOME/Developer/bin"
git clone git@github.com:ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
git clone git@github.com:joseph-levine/oh-my-zsh-ssh-close.git "$HOME/.oh-my-zsh/custom/plugins/ssh-close"

echo "adding to ssh-agent"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

echo "now,
* FIXME: hide the menu bar (not possible via code)
* enable documents sync in apple id settings
* TODO: disable capslock
* TODO: disable notes hotcorner
* disable input source switching shortcuts in Keyboard->Shortcuts
* grant full disk access to Alacritty and Terminal
* increase mouse tracking speed
* Finder:
  - TODO: set default directory as home
  - TODO: remove recents from sidebar
  - TODO: set order by name as default
* install oh-my-zsh
* git clone p10k
* brew taps
* FIXME: brew install explicits (loop doesn't work, concat list to one line)
* install chrome, docker, keeping you awake, jetbrains toolkit, cloudflare WARP
* in chrome, go to meet.google.com, then click install in the URL bar
* increase docker available memory
* dnsmasq
  - copy dnsmasq to /opt/homebrew/etc
  - start
  - set network
* FIXME:in safari: enable developer tools
* Music: set to lossless
"
