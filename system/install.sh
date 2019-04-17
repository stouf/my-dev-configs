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

function install-flowskell {
  dldir="/tmp/flowskell"
  git clone https://github.com/ennocramer/floskell ${dldir}
  cd ${dldir}
  stack install
  cd ${DIR}
  rm -rf ${dldir}
}

# NPM packages
sudo npm config -g set /usr/local
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm ocaml-language-server flow-language-server \
  reason-cli@latest-linux bs-platform@latest
sudo npm install -g prettier

install-reason-language-server
sudo pacman -S fzf

install-flowskell
stack install hdevtools
stack install hfmt
