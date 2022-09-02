#!/bin/sh

pushd ~/.dotfiles/
nix build .\#homeManagerConfigurations.mgr8.activationPackage
./result/activate
popd
