{ 
  pkgs,
  inputs,
  host,
  ... 
}: {

  imports = [
    ./oh-my-posh-theme.nix
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };
}
