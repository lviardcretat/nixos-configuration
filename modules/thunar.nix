{ 
  pkgs,
  inputs,
  host,
  ... 
}: {
  home.packages = with pkgs.xfce; [
    thunar
  ];

  programs = {
    xfconf.enable = true;
    thunar = {
        enable = true;
    };
    plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
    ];
  };
}
