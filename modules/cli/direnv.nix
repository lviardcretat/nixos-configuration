  { 
  pkgs,
  inputs,
  host,
  ... 
}: {
  home.packages = with pkgs; [
    nix-direnv
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}