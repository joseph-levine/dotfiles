#!/bin/sh

echo "ASSUMING: cwd is $PWD"
printf "Control-c if it is not. Else, Enter"
read -r

if ! type brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -z ${SKIP_BREW+x} ]; then
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
fi

if [ ! -r "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -s "$PWD/.vimrc" "$HOME/.vimrc"
    vim -c PlugInstall -c qall
fi

# see https://github.com/mathiasbynens/dotfiles/blob/main/.macos
# open save panel
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# don't save to icloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# undo all that auto-substitute-break-my-code stuff
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# scroll the correct direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# reboot on power failure
sudo pmset -a autorestart 1

# or on freeze
sudo systemsetup -setrestartfreeze on

# get rid of shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Show all the icons on my desktop, I'm old, that's where I like 'em
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# file extensions are useful
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# and I know how to change them
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# give me back my status bar
defaults write com.apple.finder ShowStatusBar -bool true

# death to .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# don't hide useful stuff
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# but do hide the dock.... even though it's useful...
defaults write com.apple.dock autohide -bool true

# display sleep on top-right
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0

# full url
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# web dev safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# git - I'm me!
git config --global user.name "Joseph Levine"
printf "git email: "
read -r email;
git config --global user.email "$email"
git config --global core.excludesFile "$HOME/.gitignore"
