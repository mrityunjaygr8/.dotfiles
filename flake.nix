{
  description = "mgr8's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in {
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

          modules = [
            ./system/kharkanas-configuration.nix
          ];
        };
        black-coral = lib.nixosSystem {
          inherit system;

          modules = [
            ./system/black-coral-configuration.nix
          ];
        };
      };
    };
}
