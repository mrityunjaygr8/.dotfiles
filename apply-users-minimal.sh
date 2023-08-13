#!/bin/sh

pushd ~/.dotfiles/
nix build .\#homeManagerConfigurations.mgr8Minimal.activationPackage
./result/activate
popd
