{ 
  pkgs,
  inputs,
  config,
  ... 
}: {
  home.file.".config/Code/User/settings.json".text = ''
    {
      "nix.serverPath": "nixd",
      "nix.enableLanguageServer": true,
      "nix.serverSettings": {
        "nixd": {
          "formatting": {
            "command": [ "nixfmt" ], // or nixfmt or nixpkgs-fmt
          },
          "options": {
            "nixos": {
              "expr": "(builtins.getFlake \"github.com:lviardcretat/nixos-configuration").nixosConfigurations.CONFIGNAME.options"
            },
            "home_manager": {
              "expr": "(builtins.getFlake \"github.com:lviardcretat/nixos-configuration").homeConfigurations.CONFIGNAME.options"
            },
          },
        }
      }
    }
  '';
}