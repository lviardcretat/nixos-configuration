{ 
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./gui/hyprland/hyprland.nix
  ];

  home = {
    username = "loic";
    homeDirectory = "/home/loic";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      alacritty
      android-tools
      dunst # Notification daemon
      eww # Standalone widget system
      floorp
      gamemode
      git
      grim # Needed for screenshots
      heroic
      lm_sensors # Controlling fan speed
      lutris
      mangohud # Vulkan and OpenGL overlay for monitoring system performance
      mpv # Media player
      neofetch # System info script
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

  # Gaming mode : gamemoderun %command%
  # FPS monitor : mangohud %command%
  # Upscaling, windows manager problem : gamescope %command%
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  
  # webcam/android cam
  programs.adb.enable = true;
}
