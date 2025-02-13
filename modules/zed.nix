{
  pkgs,
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
    icon_theme = "Material Icon Theme";
    telemetry = {
      metrics = false;
      diagnostics = false;
    };
    language_models = {
      mistral = {
        api_url = "https://api.mistral.ai";
        available_models = [
          {
            name = "chat-completion";
            display_name = "Chat Completion Model";
            max_tokens = 8192;
          }
          {
            name = "fim-completion";
            display_name = "Fill-in-the-middle Completion Model";
            max_tokens = 8192;
          }
          {
            name = "embedding";
            display_name = "Embedding Model";
            max_tokens = 2048;
          }
        ];
        version = "0.0.2";
      };
    };
    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Gruvbox Dark Soft";
      };
    };
  };
}
