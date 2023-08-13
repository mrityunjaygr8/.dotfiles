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
  networking.extraHosts = ''
    127.0.0.1 stratin.in
    127.0.0.1 whoami.stratin.in
    127.0.0.1 traefik.stratin.in
    127.0.0.1 portainer.stratin.in
    127.0.0.1 pihole.stratin.in
  '';
  hardware.bluetooth.enable = true;
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    #settings.PermitRootLogin = "yes";
  };

  users.users."mgr8".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDxRGwuw+V14agG/AAiB87g4sdjDU4mMgAkH5A+L38mq2W/F9SJIZROhklG1ShDOZF23sTzpjzslD1H0cR9uq137W3/eDjtNCmqZ/6Q6h4Y85jMjC+7lTIZdrKv1AMZEuQYIsF/3BFz5u0P8pQ5NlxKIwNQUqMT3qTxHoKm4flhGgzibvlD3jyyDILBmAKxfaegfMH2LqN+SyWxUBgNpCh3hr84yAjSAixeLZqSxG74JUHdXWZ3zZGUCGZ828byxWGTPnMHcs1SBjwZWvoVv2xetd1OSCcdJdjGBaEfaaRfURaz4f9BR54/+CT/bbwU3qRkiwTAXxSt/pP7TgzAbPozJ3AIShdfW+AvVhmzizSZLdBUxclAXJ0mmJuiIhVZTMDbWLGmwunaB0EAghGU4OD7NOSKmJffdN82QahgxlXMqsyrxHzUxu+Y3QbODVXj75tSC84L2IS8SiSiu/c+U7p5vQQi3N/56ooyCS7PMNrlfGuN59SMZE1cWGP6Hvh4X4E= mgr8@manjaro"
  ];
}

