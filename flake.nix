{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem rec {
          specialArgs = {inherit inputs;};
          modules = [
            ./configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager.users.loic = import ./home.nix;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;            
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}
