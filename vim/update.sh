#!/usr/bin/env bash

vim +PlugUpdate +qall

# Update the dependencies of some plugins
sudo npm install -g flow-language-server@latest prettier@latest
go get -u github.com/zmb3/gogetdoc
# See https://github.com/reasonml/reasonml.github.io/pull/157 for more details about why the --unsafe-perm tag is
# required
sudo npm install -g --unsafe-perm reason-cli@latest-linux bs-platform@latest
