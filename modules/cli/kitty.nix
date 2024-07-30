{ 
  pkgs,
  inputs,
  ... 
}: {
  programs.kitty = {
    shellIntegration.enableZshIntegration = true;
    # theme = "Gruvbox Dark"; Not working
  };
}