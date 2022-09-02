{
  description = "mgr8's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
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
          inherit system pkgs;

          stateVersion = "22.05";
	  username = "mgr8";
	  homeDirectory = "/home/mgr8";
	  configuration = import ./users/mgr8/home.nix;
	};
      };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

	  modules = [
            ./system/configuration.nix
	  ];
	};
      };

    };
}
