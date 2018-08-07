#!/usr/bin/env bash

vim +PluginUpdate +qall

REASON_CLI_VERSION="3.2.0"

# Update the dependencies of some plugins
sudo npm install -g \
  flow-language-server@latest \
  ocaml-language-server prettier@latest
go get -u github.com/zmb3/gogetdoc
reason_cli_package_name="reason-cli@${REASON_CLI_VERSION}-linux"
if [[ ${platform} = 'mac' ]]
then
  reason_cli_package_name="reason-cli@${REASON_CLI_VERSION}-darwin"
fi
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm ${reason_cli_package_name} bs-platform@latest

# Post-update operations
cd ~/.vim/bundle/LanguageClient-neovim/ && \
  git fetch origin && \
  git checkout next && \
  git reset --hard origin/next && \
  bash ./install.sh
vim +GoUpdateBinaries +qall
