# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./drift-avalii-hardware-configuration.nix
      ./common/config.nix
    ];


  networking.hostName = "drift-avalii"; # Define your hostname.
  hardware.bluetooth.enable = true;
}

