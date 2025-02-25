{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nix-colors.url = "github:misterio77/nix-colors";

    ags.url = "github:aylur/ags";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # command : nix run nixpkgs#nixos-generators -- --format iso --flake ./#laptop -o result
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          host = "desktop";
        };
        modules = [
          ./systems/desktop/configuration.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
            home-manager.users.loic = import ./systems/desktop/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
            # home-manager.useGlobalPkgs = true; # Cannot use overlays with this      
            home-manager.useUserPackages = true;
          }
        ];
      };
      laptop = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          host = "laptop";
        };
        modules = [
          ./systems/laptop/configuration.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
            home-manager.users.loic = import ./systems/laptop/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
            # home-manager.useGlobalPkgs = true; # Cannot use overlays with this      
            home-manager.useUserPackages = true;
          }
        ];
      };
        iso = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;
            host = "laptop";
          };
          modules = [
            ./systems/iso/configuration.nix
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager.users.loic = import ./systems/iso/home.nix;
              home-manager.extraSpecialArgs = specialArgs;
              # home-manager.useGlobalPkgs = true; # Cannot use overlays with this      
              home-manager.useUserPackages = true;
            }
          ];
        };
    };
  };
}
