{ 
  pkgs,
  inputs,
  ... 
}: {
  home.file.".config/neofetch" = {
    source = ./config;
    recursive = true;
  };
}