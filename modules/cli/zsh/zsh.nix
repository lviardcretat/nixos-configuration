{ 
  pkgs,
  inputs,
  ... 
}: {

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
    '';

    shellAliases = {
      cdnix = "cd ~/Projects/nixos-configuration && codium ~/Projects/nixos-configuration";
      nixbuild = "sudo nixos-rebuild switch --flake ~/Projects/nixos-configuration/#laptop";
      nixup = "sudo nixos-rebuild switch --upgrade --flake ~/Projects/nixos-configuration/#laptop";
      nixflakeup = "sudo nix flake update ~/Projects/nixos-configuration/#";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
    };
  };
}
