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

    nix-colors.url = "github:misterio77/nix-colors";

    ags.url = "github:Aylur/ags";
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
            ./systems/desktop/configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager.users.loic = import ./systems/desktop/home.nix;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;            
              home-manager.useUserPackages = true;
            }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem rec {
          specialArgs = {inherit inputs;};
          modules = [
            ./systems/laptop/configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager.users.loic = import ./systems/laptop/home.nix;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;            
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}
