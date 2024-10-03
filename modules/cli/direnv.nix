  { 
  pkgs,
  inputs,
  host,
  ... 
}: {

  imports = [];
  
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}