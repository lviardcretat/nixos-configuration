{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    zed-editor
    nixd
    nixfmt-rfc-style
  ];

  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    extensions = [
      "nix"
      "biome"
      "html"
      "git firefly"
      "material icon theme"
      "vue"
      "tailwind syntax"
    ];

    userSettings = {
      languages.Nix = {
        tab_size = 2;
        language_servers = [
          "nixd"
          "!nil"
        ];
        formatter = {
          external = {
            command = "nixfmt";
            arguments = [
              "--quiet"
              "--"
            ];
          };
        };
      };
      icon_theme = "Material Icon Theme";
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      language_models = {
        openai = {
          version = "1";
          api_url = "https://codestral.mistral.ai/v1";
          available_models = [
            {
              custom = {
                name = "codestral-latest";
                display_name = "Codestral";
                max_tokens = 131072;
              };
            }
          ];
        };
      };
      assistant = {
        version = "2";
        default_model = {
          provider = "openai";
          model = "codestral-latest";
        };
      };
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      ui_font_size = lib.mkDefault 16;
      buffer_font_size = lib.mkDefault 16;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = lib.mkDefault {
        mode = "system";
        light = "One Light";
        dark = "Gruvbox Dark Soft";
      };
    };
  };
}
