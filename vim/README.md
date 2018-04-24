# Vim


## Requirements

- vim
- git
- npm


## What does this do ?

In a nutshell:

- Install [Vundle](https://github.com/VundleVim/Vundle.vim)
- Install all the plugins listed in the [`vimrc`](vimrc) file through [Vundle](https://github.com/VundleVim/Vundle.vim)
  as well as their dependencies when needed.
- Copy [`vimrc`](vimrc) to `~/.vimrc` (A confirmation is required if you already have a `~/.vimrc` file on your
  filesystem).

Please note that you may be asked your root password. This is because some of the plugins have dependencies installed
through NPM as global dependencies. Those are the only operations that will require the root permissions.
