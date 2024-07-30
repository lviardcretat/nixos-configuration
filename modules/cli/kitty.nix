{ 
  pkgs,
  inputs,
  ... 
}: {
  programs.kitty.shellIntegration.enableZshIntegration = true;
}