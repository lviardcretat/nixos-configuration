{ 
  pkgs,
  ... 
}: {
  home.packages = with pkgs; [
    vscode
    nixd
    nixfmt-rfc-style
  ];

  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        biomejs.biome
        codeium.codeium
        editorconfig.editorconfig
        gitkraken.gitlens
      ];
      userSettings = {
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixpkgs-fmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"github.com:lviardcretat/nixos-configuration\").nixosConfigurations.CONFIGNAME.options";
              };
              "home_manager" = {
                "expr" = "(builtins.getFlake \"github.com:lviardcretat/nixos-configuration\").homeConfigurations.CONFIGNAME.options";
              };
            };
          };
        };

        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "codeium.enableConfig" = {
          "*" = true;
          "nix" = true;
          "edge" = true;
        };
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "explorer.confirmDelete" = false;
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "git.confirmSync" = false;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "biomejs.biome";
      };
    };
    # Workaround to enable biomeJS VSCODE extension
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        nodePackages_latest.npm
      ];
    };
  };
}