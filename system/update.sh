#!/usr/bin/env bash

set -e
set -u

function install-reason-language-server {
  dldir="/tmp/reason-language-server"
  dldst="${dldir}/linux.zip"
  mkdir ${dldir}
  wget \
    https://github.com/jaredly/reason-language-server/releases/download/1.5.2/linux.zip \
    -O ${dldst}
  unzip ${dldst} -d ${dldir}
  sudo mv ${dldir}/reason-language-server/reason-language-server.exe /usr/local/bin/
  rm -r ${dldir}
}

# NPM packages
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install --unsafe-perm -g ocaml-language-server@latest \
  flow-language-server@latest reason-cli@latest-linux bs-platform@latest
sudo npm install -g prettier@latest

install-reason-language-server
sudo pacman -S fzf

rm ~/.local/bin/hindent && stack install hindent
