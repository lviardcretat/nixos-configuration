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
    ../../modules/cli/direnv.nix
    ../../modules/vesktop.nix
    ../../modules/gui/ags/ags.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home = {
    username = "loic";
    homeDirectory = "/home/loic";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      adwaita-icon-theme # VM
      android-tools
      dunst # Notification daemon
      eww # Standalone widget system
      fastfetch # System info script
      fzf
      gamemode
      git
      grim # Needed for screenshots
      heroic
      killall
      kitty
      libjpeg
      libreoffice
      lm_sensors # Controlling fan speed
      lutris      
      mangohud # Vulkan and OpenGL overlay for monitoring system performance
      mpv # Media player
      nerdfonts
      nix-direnv
      obsidian
      oh-my-posh # A prompt theme engine for any shell
      pavucontrol # Volume controller
      protonup-ng
      protonvpn-gui_legacy
      rofi-wayland # App menu
      slurp # Needed for screenshots
      spotify
      swappy
      unzip
      v4l-utils # Linux utilities and libraries to handle media devices (capture devices, remote controllers...)
      ventoy # Bootable USB solution
      viewnior # Fast and simple image viewer
      vscode
      wl-clipboard
      wf-recorder
      yazi # Fast terminal file manager
      zoxide
      zsh
      # Zed-editor Wait until it's really complete
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
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
