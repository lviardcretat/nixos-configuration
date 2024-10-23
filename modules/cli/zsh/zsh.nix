{ 
  pkgs,
  inputs,
  host,
  ... 
}: {
  home.packages = with pkgs; [
    zsh
  ];

  imports = [
    ./oh-my-posh-theme.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initExtra = ''
      ${pkgs.fastfetch}/bin/fastfetch
      echo ""
      eval "$(oh-my-posh init zsh --config ~/Projects/nixos-configuration/modules/cli/zsh/theme.omp.json)"
      eval "$(zoxide init zsh)"
    '';

    shellAliases = {
      cdnix = "cd ~/Projects/nixos-configuration && code ~/Projects/nixos-configuration";
      nixbuild = "sudo nixos-rebuild switch --flake ~/Projects/nixos-configuration/#${host}";
      nixup = "sudo nixos-rebuild switch --upgrade --flake ~/Projects/nixos-configuration/#${host}";
      nixflakeup = "nix flake update --flake /home/loic/Projects/nixos-configuration/#";
      nixclean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
    };
  };
}
