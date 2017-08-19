#!/bin/sh
# update_submodules.sh | Curtis Free (http://curtisfree.com)
# Updates all submodules, such as Vim plugins.

# assume all submodules are Vim plugins so that `foreach` is a handy shortcut

# make sure all plugins are ready (http://stackoverflow.com/a/4438292)
git submodule update --init --recursive

# bring everything up to master
git submodule foreach 'git fetch origin master && git reset --hard FETCH_HEAD'
