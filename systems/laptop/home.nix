{ 
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/gui/hyprland/hyprland.nix
    ../../modules/cli/kitty.nix
    ../../modules/cli/zsh/zsh.nix
    ../../modules/cli/fastfetch/fastfetch.nix
    ../../modules/vesktop.nix
    ../../modules/gui/ags/ags.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home = {
    username = "loic";
    homeDirectory = "/home/loic";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      android-tools
      dunst # Notification daemon
      eww # Standalone widget system
      floorp
      git
      grim # Needed for screenshots
      kitty
      libreoffice
      lm_sensors # Controlling fan speed
      mpv # Media player
      fastfetch # System info script
      nerdfonts
      oh-my-posh # A prompt theme engine for any shell
      pavucontrol # Volume controller
      rofi-wayland # App menu
      sassc
      slurp # Needed for screenshots
      typora
      unzip
      v4l-utils # Linux utilities and libraries to handle media devices (capture devices, remote controllers...)
      vscodium
      wl-clipboard
      yazi # Fast terminal file manager
      zsh
      # Zed-editor Wait until it's really complete
    ];
  };

  programs = {
    # Let Home Manager install and manage itself
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "lviardcretat";
      userEmail = "loic.viard-cretat@proton.me";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
