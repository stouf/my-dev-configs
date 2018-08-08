#!/usr/bin/env bash

set +x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

REASON_CLI_VERSION="3.3.2"

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

# Platform detection
platform='linux'
echo 'Are you using Mac OS? [y/N]'
read is_mac_os
if [[ ${is_mac_os} = 'y' || ${is_mac_os} = 'Y' ]]
then
  platform='mac'
fi

# Install Vundle
if [[ ! -d ~/.vim/bundle/Vundle.vim ]]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Copy the vimrc file
cp ${DIR}/vimrc ~/.vimrc

# Installing all the plugins
vim +PluginInstall +qall

# Install the dependencies of some plugins
sudo npm install -g flow-language-server ocaml-language-server prettier
go get -u github.com/zmb3/gogetdoc
reason_cli_package_name="reason-cli@${REASON_CLI_VERSION}-linux"
if [[ ${platform} = 'mac' ]]
then
  reason_cli_package_name="reason-cli@${REASON_CLI_VERSION}-darwin"
fi
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm ${reason_cli_package_name}

# Some plugins require some post installation operations
cd ~/.vim/bundle/LanguageClient-neovim/ && git checkout next && bash ./install.sh
vim +GoUpdateBinaries +qall

# Mac OS specific
if [[ ${platform} = 'mac' ]]
then
  cat ${DIR}/vimrc-macos >> ~/.vimrc
fi

echo "Please do not forget to install fzf (https://github.com/junegunn/fzf) if you haven't already done it"
