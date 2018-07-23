#!/usr/bin/env bash

vim +PluginUpdate +qall

# Update the dependencies of some plugins
sudo npm update -g flow-language-server ocaml-language-server prettier
go get -u github.com/zmb3/gogetdoc
reason_cli_package_name='reason-cli@3.1.0-linux'
if [[ ${platform} = 'mac' ]]
then
  reason_cli_package_name='reason-cli@3.1.0-darwin'
fi
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm update -g --unsafe-perm ${reason_cli_package_name}

# Post-update operations
cd ~/.vim/bundle/LanguageClient-neovim/ && \
  git fetch origin && \
  git checkout next && \
  git reset --hard origin/next && \
  bash ./install.sh
vim +GoUpdateBinaries +qall
