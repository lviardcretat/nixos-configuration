{ 
  pkgs,
  inputs,
  ... 
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty-direct";
        source = "~/Projects/nixos-configuration/modules/cli/fastfetch/lotus.png";
        height = 20;
        width = 40;
      };
      display = {
        separator = "  ";
      };
      modules = [
        {
          type = "custom";
          format = "┌───────────────────────────────────────────────────┐";
        }
        {
          type = "os";
          key = " OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "│ └";
          keyColor = "yellow";
        }
        {
          type = "de";
          key = " DE";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "lm";
          key = "│ ├󰧨";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼";
          keyColor = "blue";
        }
        {
          type = "icons";
          key = "│ ├󰀻";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "wallpaper";
          key = "│ └󰸉";
          keyColor = "blue";
        }
        {
          type = "host";
          key = " PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰍛";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "│ ├󰑭";
          keyColor = "green";
        }
        {
          type = "swap";
          key = "│ ├󰓡";
          keyColor = "green";
        }
        {
          type = "uptime";
          key = "│ ├󰅐";
          keyColor = "green";
        }
        {
          type = "display";
          key = "│ └󰍹";
          keyColor = "green";
        }
        {
          type = "sound";
          key = " SND";
          keyColor = "cyan";
        }
        {
          type = "player";
          key = "│ ├󰥠";
          keyColor = "cyan";
        }
        {
          type = "media";
          key = "│ └󰝚";
          keyColor = "cyan";
        }
        {
          type = "custom";
          format = "└───────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 0;
          symbol = "block";
        }
      ];
    };
  };
}