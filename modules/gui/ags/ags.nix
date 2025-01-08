{ 
  pkgs,
  inputs,
  ... 
}: {
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./config;
    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.io
      inputs.ags.packages.${pkgs.system}.bluetooth
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.wireplumber
      fzf
    ];
  };

  home.packages = with pkgs; [
    inputs.ags.packages.${pkgs.system}.io
    inputs.ags.packages.${pkgs.system}.bluetooth
    inputs.ags.packages.${pkgs.system}.mpris
    inputs.ags.packages.${pkgs.system}.network
    inputs.ags.packages.${pkgs.system}.wireplumber
    fzf
  ];
}
