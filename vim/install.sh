#!/usr/bin/env bash

set -e
set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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

# Already existing configuration file ?
if [[ -e ~/.vimrc ]]
then
	echo 'A ~/.vimrc file already exists on the filesystem. Do you want to override it and continue ? [y/N]'
	read override
	if [[ $override = 'N' || $override = 'n' || -z $override ]]
	then
		echo 'Aborting.'
		exit 0
	fi
fi

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the vimrc file
cp ${DIR}/vimrc ~/.vimrc

# Copy the Language-client configuration file
cp ${DIR}/language-client-settings.json ${HOME}/.vim/settings.json

# Installing all the plugins
vim +PlugInstall +qall

# Install the dependencies of some plugins
npm install --prefix ${NPM_TOOLS_DIR} prettier
npm install --prefix ${NPM_TOOLS_DIR} \
  ocaml-language-server flow-language-server
install-reason-language-server
go get -u github.com/zmb3/gogetdoc
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm reason-cli@latest-linux bs-platform@latest

echo "Please do not forget to install fzf (https://github.com/junegunn/fzf) if you haven't already done it"
