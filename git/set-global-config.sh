#!/usr/bin/env bash

set -e

git config --global user.name "Stephan Donin"
git config --global user.email ""

# Default to `more` like readers git commands such as `git branch`.
git config --global pager.branch "false"

# Prioritize ssh over https for GitHub URLs
git config --global url.git@github.com:.insteadOf https://github.com/
