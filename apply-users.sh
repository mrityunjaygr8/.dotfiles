#!/bin/sh

pushd ~/.dotfiles/
home-manager switch -f ./users/mgr8/home.nix
popd
