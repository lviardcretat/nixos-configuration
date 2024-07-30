{ 
  pkgs,
  inputs,
  ... 
}: {
  programs.kitty.shellIntegration.enableFishIntegration = true;
}