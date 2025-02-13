{ 
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [ 
    ./hardware-configuration.nix
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.download-buffer-size = "1024M";
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  stylix = {
    enable = true;
    autoEnable = true;
    image = ../../modules/gui/stylix/wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  };

  environment = {
    systemPackages = [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];
    sessionVariables = {
      NIXOS_OZONE_WL="1";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs = {
    dconf.enable = true;
    direnv.enable = true;
    hyprland = { 
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    # Gaming mode : gamemoderun %command%
    # FPS monitor : mangohud %command%
    # Upscaling, windows manager problem : gamescope %command%
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    # Webcam/android cam
    adb.enable = true;
    # Always enable the shell system-wide, even if it's already enabled in your Home Manager configuration, otherwise it won't source the necessary files. 
    zsh.enable = true;
    # File manager
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
          thunar-media-tags-plugin
      ];
    };
    # Workaround to enable biomeJS VSCODE extension
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        nodePackages_latest.npm
      ];
    };
  };

  # Bootloader.
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "fr";
        variant = "";
      };
      videoDrivers = [ "amdgpu" ];
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # File manager
    # Mount, trash, and other functionalities
    gvfs.enable = true;
    # Thumbnail support for images
    tumbler.enable = true;
    udisks2.enable = true;

    # Enable automatic login for the user.
    getty.autologinUser = lib.mkDefault "loic";

    # Enable sound
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    spice-vdagentd.enable = true;

    netdata = {
      enable = true;

      config = {
        global = {
          # uncomment to reduce memory to 32 MB
          #"page cache size" = 32;

          # update interval
          "update every" = 15;
        };
        ml = {
          # enable machine learning
          "enabled" = "yes";
        };
      };
    };

    postgresql = {
      enable = true;
      ensureDatabases = [ "recepto" ];
      enableTCPIP = true;
      # port = 5432;
      authentication = pkgs.lib.mkOverride 10 ''
        #...
        #type database DBuser origin-address auth-method
        local all       all     trust
        # ipv4
        host  all      all     127.0.0.1/32   trust
        # ipv6
        host all       all     ::1/128        trust
      '';
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Needed for 32-bit applications (like Steam games)
    extraPackages = with pkgs; [
      amdvlk  # Official AMD Vulkan driver
      mesa    # Open-source Mesa driver
    ];
  };

  # Enable sound
  security.rtkit.enable = true;

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.loic = {
    isNormalUser = true;
    description = "loic";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
