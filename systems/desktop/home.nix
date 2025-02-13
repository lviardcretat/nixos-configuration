{
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/gui/hyprland/hyprland.nix
    ../../modules/cli/kitty.nix
    ../../modules/cli/zsh/zsh.nix
    ../../modules/cli/fastfetch/fastfetch.nix
    ../../modules/cli/direnv.nix
    ../../modules/vesktop.nix
    ../../modules/gui/ags/ags.nix
    ../../modules/vscode.nix
    ../../modules/zed.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home = {
    username = "loic";
    homeDirectory = "/home/loic";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      android-tools
      dbgate
      dunst # Notification daemon
      eww # Standalone widget system
      fzf
      gamemode
      gimp
      git
      godot_4
      grim # Needed for screenshots
      heroic
      killall
      libjpeg
      libreoffice
      lm_sensors # Controlling fan speed
      lutris
      mangohud # Vulkan and OpenGL overlay for monitoring system performance
      mpv # Media player
      obsidian
      pavucontrol # Volume controller
      protonup-ng
      protonvpn-gui
      rofi-wayland # App menu
      slurp # Needed for screenshots
      spotify
      swappy
      unzip
      v4l-utils # Linux utilities and libraries to handle media devices (capture devices, remote controllers...)
      (ventoy.override {
        # Bootable USB solution
        defaultGuiType = "gtk3";
        withGtk3 = true;
      })
      vscode
      viewnior # Fast and simple image viewer
      wl-clipboard
      wf-recorder
      xfce.thunar
      zoxide
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # Needed to run zen-browser
      MOZ_ENABLE_WAYLAND = "0";
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
