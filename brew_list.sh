#!/bin/bash

echo "Hello! This is a brew list file,"
echo "which automatically install convenient applications"

# latest home Homebrew
brew update
# update already-installed formula
brew upgrade

brew install vim
brew install fzf
brew install ripgrep
brew install tree
brew install docker

brew install rbenv
brew install goenv
brew install nodenv
brew install ffmpeg
brew install coreutils
brew install graphviz
brew install virtualbox

brew install mysql
brew install postgresql
brew install redis

brew install brew-cask
brew cask install visual-studio-code
brew cask install git-gui
brew cask install google-chrome
brew cask install postman
brew cask install slack
# brew cask install skitch

# regularly executed
brew cleanup
