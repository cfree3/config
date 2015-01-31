#!/bin/sh
# update_plugins.sh | Curtis Free (http://curtisfree.com)
# Updates all Vim plugins to the latest versions.

cd bundle
for plugin in *; do
    ( cd ${plugin} && git pull --rebase ) && git add ${plugin}
done
