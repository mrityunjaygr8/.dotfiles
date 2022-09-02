#!/bin/sh

pushd ~/.nixfiles/
home-manager switch -f ./users/mgr8/home.nix
popd
