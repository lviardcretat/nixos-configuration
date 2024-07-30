{ 
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./modules/gui/hyprland/hyprland.nix
    ./modules/cli/kitty.nix
    ./modules/cli/zsh/zsh.nix
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
      gamemode
      git
      grim # Needed for screenshots
      heroic
      kitty
      libreoffice
      lm_sensors # Controlling fan speed
      lutris
      mangohud # Vulkan and OpenGL overlay for monitoring system performance
      mpv # Media player
      nerdfetch # System info script
      nerdfonts
      oh-my-posh # A prompt theme engine for any shell
      pavucontrol # Volume controller
      protonup-ng
      rofi-wayland # App menu
      slurp # Needed for screenshots
      swww # Animated wallpaper daemon
      typora
      unzip
      v4l-utils # Linux utilities and libraries to handle media devices (capture devices, remote controllers...)
      vesktop # Custom Discord desktop app
      vscodium
      yazi # Fast terminal file manager
      zsh
      # zed-editor Wait until it's really complete
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "lviardcretat";
    userEmail = "loic.viard-cretat@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
