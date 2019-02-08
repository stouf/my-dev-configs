#!/usr/bin/env bash

set -e
set -u

# Update floskell
current_dir=$(pwd)
rm -f ~/.local/bin/floskell && \
  cd /tmp && \
  git clone https://github.com/ennocramer/floskell && \
  cd floskell && \
  stack install && \
  cd ${current_dir} && \
  rm -rf /tmp/floskell

cp -r ${DIR}/ftplugin/* ~/.vim/ftplugin/

vim +PlugUpdate +qall
