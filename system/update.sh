#!/usr/bin/env bash

set -e
set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# NPM packages
sudo npm config -g set prefix /usr/local
sudo npm install -g prettier@latest

sudo pacman -S fzf

go get -u golang.org/x/tools/cmd/gopls
