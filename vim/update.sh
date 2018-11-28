#!/usr/bin/env bash

set -e
set -u

NPM_TOOLS_DIR="~/.my-npm-tools"
LANGUAGE_SERVER_DIR="${HOME}/.my-language-servers"

mkdir -p "${LANGUAGE_SERVER_DIR}"

function install-reason-language-server {
  dldir="/tmp/reason-language-server"
  dldst="${dldir}/linux.zip"
  mkdir ${dldir}
  wget \
    https://github.com/jaredly/reason-language-server/releases/download/1.4.0/linux.zip \
    -O ${dldst}
  unzip ${dldst} -d ${dldir}
  mv ${dldir}/reason-language-server/reason-language-server.exe ${LANGUAGE_SERVER_DIR}/
  rm -r ${dldir}
}

vim +PlugUpdate +qall

# Update the dependencies of some plugins
npm install --prefix ${NPM_TOOLS_DIR} prettier@latest
npm install --prefix ${NPM_TOOLS_DIR} \
  ocaml-language-server@latest flow-language-server@latest
install-reason-language-server
go get -u github.com/zmb3/gogetdoc
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm reason-cli@latest-linux bs-platform@latest
