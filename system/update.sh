#!/usr/bin/env bash

set -e
set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# It seems necessary NOT TO remove the repository for this langauge server to
# work property
function update-haskell-ide-engine {
  install_dir=~/.local/src
  mkdir -p ${install_dir}
  cd ${install_dir}
  if [ ! -d ./haskell-ide-engine ]
  then
    git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
  fi
  cd haskell-ide-engine
  git fetch origin
  git reset --hard origin/master
  stack ./install.hs hie-8.6.4
  stack ./install.hs hie-8.6.5
  stack ./install.hs build-doc
}

# NPM packages
sudo npm config -g set prefix /usr/local
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install --unsafe-perm -g ocaml-language-server@latest \
  flow-language-server@latest reason-cli@latest-linux bs-platform@latest
sudo npm install -g prettier@latest

install-reason-language-server
sudo pacman -S fzf

update-haskell-ide-engine
