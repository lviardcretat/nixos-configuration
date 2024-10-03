{ 
  pkgs,
  config,
  inputs,
  ... 
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https =//github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      "logo" = {
        source = "~/Projects/nixos-configuration/modules/cli/fastfetch/logo.png";
        "type" = "kitty";
          "height" = 20;
          "padding" = {
          "top" = 1;
        };
      };
      "display" = {
        "separator" = " ➜  ";
      };
      "modules" = [
        "break"
        "break"
        "break"
        {
            "type" = "os";
            "key" = "OS   ";
        }
        {
            "type" = "kernel";
            "key" = " ├  ";
        }
        {
            "type" = "packages";
            "format" = "{} (nixpkgs)";
            "key" = " ├ 󰏖 ";
        }
        {
            "type" = "shell";
            "key" = " └  ";
        }
        "break"
        {
            "type" = "wm";
            "key" = "WM   ";
        }
        {
            "type" = "wmtheme";
            "key" = " ├ 󰉼 ";
        }
        {
            "type" = "icons";
            "key" = " ├ 󰀻 ";
        }
        {
            "type" = "cursor";
            "key" = " ├  ";
        }
        {
            "type" = "terminal";
            "key" = " ├  ";
        }
        {
            "type" = "terminalfont";
            "key" = " └  ";
        }
        "break"
        {
            "type" = "host";
            "format" = "{5} {1} Type {2}";
            "key" = "PC   ";
        }
        {
            "type" = "cpu";
            "format" = "{1} ({3}) @ {7} GHz";
            "key" = " ├  ";
        }
        {
            "type" = "gpu";
            "format" = "{1} {2} @ {12} GHz";            
            "key" = " ├ 󰢮 ";
        }
        {
            "type" = "memory";
            "key" = " ├  ";
        }
        {
            "type" = "swap";
            "key" = " ├ 󰓡 ";
        }
        {
            "type" = "disk";
            "key" = " ├ 󰋊 ";
        }
        {
            "type" = "monitor";
            "key" = " └  ";
        }
        "break"
        "break"
      ];
    };
  };
}
