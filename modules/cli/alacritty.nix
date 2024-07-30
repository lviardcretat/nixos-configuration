{ 
  pkgs,
  config,
  ... 
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "${pkgs.zsh}/bin/zsh";

      window.padding = {
        x = 20;
        y = 20;
      };
    };
  };
}