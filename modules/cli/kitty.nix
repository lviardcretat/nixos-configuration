{ 
  pkgs,
  inputs,
  config,
  ... 
}: {
  home.file.".config/kitty/kitty.conf".text = ''
    # BEGIN_KITTY_THEME
    # Gruvbox Dark
    include current-theme.conf
    # END_KITTY_THEME

    window_padding_width 15
    background_blur 0.6
    background_opacity 0.4
  '';
}