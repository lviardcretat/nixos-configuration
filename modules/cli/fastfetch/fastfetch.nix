{ 
  pkgs,
  config,
  inputs,
  ... 
}: {
  home.packages = with pkgs; [
    fastfetch # System info script
  ];
  
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https =//github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      "logo" = {
        source = "~/Projects/nixos-configuration/modules/cli/fastfetch/logo_nix.png";
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
        {
            "type" = "os";
            "key" = "OS   ";
            "keyColor" = "light_red";
        }
        {
            "type" = "kernel";
            "key" = " ├  ";
            "keyColor" = "light_red";
        }
        {
            "type" = "packages";
            "format" = "{} (nixpkgs)";
            "key" = " ├ 󰏖 ";
            "keyColor" = "light_red";
        }
        {
            "type" = "shell";
            "key" = " └  ";
            "keyColor" = "light_red";
        }
        "break"
        {
            "type" = "wm";
            "key" = "WM   ";
            "keyColor" = "light_cyan";
        }
        {
            "type" = "wmtheme";
            "key" = " ├ 󰉼 ";
            "keyColor" = "light_cyan";
        }
        {
            "type" = "icons";
            "key" = " ├ 󰀻 ";
            "keyColor" = "light_cyan";
        }
        {
            "type" = "cursor";
            "key" = " ├  ";
            "keyColor" = "light_cyan";
        }
        {
            "type" = "terminal";
            "key" = " ├  ";
            "keyColor" = "light_cyan";
        }
        {
            "type" = "terminalfont";
            "key" = " └  ";
            "keyColor" = "light_cyan";
        }
        "break"
        {
            "type" = "host";
            "format" = "{5} {1} Type {2}";
            "key" = "PC   ";
            "keyColor" = "light_magenta";
        }
        {
            "type" = "cpu";
            "format" = "{1} ({3}) @ {7} GHz";
            "key" = " ├  ";
            "keyColor" = "light_magenta";
        }
        {
            "type" = "gpu";
            "format" = "{1} {2} @ {12} GHz";            
            "key" = " ├ 󰢮 ";
            "keyColor" = "light_magenta";
        }
        {
            "type" = "memory";
            "key" = " ├  ";
            "keyColor" = "light_magenta";
        }
        {
            "type" = "swap";
            "key" = " ├ 󰓡 ";
            "keyColor" = "light_magenta";
        }
        {
            "type" = "disk";
            "key" = " ├ 󰋊 ";
            "keyColor" = "light_magenta";
        }
        {
            "type" = "monitor";
            "key" = " └  ";
            "keyColor" = "light_magenta";
        }
        "break"
        "break"
      ];
    };
  };
}
