#!/bin/sh

pushd ~/.dotfiles/
sudo nixos-rebuild switch --max-jobs 4 --flake .#
popd
