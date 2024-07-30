{ 
  pkgs,
  inputs,
  ... 
}: {
  programs.zsh = {
    enable = true;
    shellAliases = {};
    autosuggestion.enable = true;
    enableCompletion = true;

    initExtra = ''
      eval "$(oh-my-posh init zsh)"
    '';
  };
}