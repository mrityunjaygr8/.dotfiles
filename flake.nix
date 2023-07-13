{
  description = "mgr8's system config";

  inputs = {
    lanzaboote.url = "github:nix-community/lanzaboote";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv/latest";
  };

  outputs = { lanzaboote, nixpkgs, home-manager, devenv, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in
    {
      # packages.x86_64-linux = [devenv.packages.x86_64-linux.devenv];
      homeManagerConfigurations = {
        mgr8 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./users/mgr8/home.nix
          ];
        };
      };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

          modules = [
            ./system/vm-configuration.nix
          ];
        };
        kharkanas = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit devenv; };

          modules = [
            { _module.args = devenv; }
            ./system/kharkanas-configuration.nix
            lanzaboote.nixosModules.lanzaboote
            ({ config, pkgs, lib, ... }: {
              boot.bootspec.enable = true;

              environment.systemPackages = [
                # For debugging and troubleshooting Secure Boot.
                pkgs.sbctl
              ];

              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/etc/secureboot";
              };
            })
          ];

        };
        black-coral = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit devenv; };
          modules = [
            { _module.args = devenv; }
            ./system/black-coral-configuration.nix
          ];
        };
        drift-avalii = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit devenv; };
          modules = [
            { _module.args = devenv; }
            ./system/drift-avalii-configuration.nix
          ];
        };
      };
    };
}
