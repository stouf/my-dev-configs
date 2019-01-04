#!/usr/bin/env bash

set -e
set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install-reason-language-server {
  dldir="/tmp/reason-language-server"
  dldst="${dldir}/linux.zip"
  mkdir ${dldir}
  wget \
    https://github.com/jaredly/reason-language-server/releases/download/1.4.0/linux.zip \
    -O ${dldst}
  unzip ${dldst} -d ${dldir}
  sudo mv ${dldir}/reason-language-server/reason-language-server.exe /usr/local/bin/
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
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm ocaml-language-server flow-language-server \
  reason-cli@latest-linux bs-platform@latest
sudo npm install -g prettier
install-reason-language-server
go get -u github.com/zmb3/gogetdoc

echo "Please do not forget to install fzf (https://github.com/junegunn/fzf) if you haven't already done it"
