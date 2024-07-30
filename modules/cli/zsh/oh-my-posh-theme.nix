{
  pkgs,
  config,
  ...
}: {
  home.file."Projects/nixos-configuration/modules/cli/zsh/theme.omp.json".text = ''
    {
      "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
      "palette": {
        "raisin_black": "#${config.colorScheme.palette.base00}",
        "jet": "#${config.colorScheme.palette.base01}",
        "walnut_brown": "#${config.colorScheme.palette.base02}",
        "walnut_brown_2":  "#${config.colorScheme.palette.base03}",
        "khaki": "#${config.colorScheme.palette.base04}",
        "dun": "#${config.colorScheme.palette.base05}",
        "dutch_white": "#${config.colorScheme.palette.base06}",
        "lemon_chiffon": "#${config.colorScheme.palette.base07}",
        "cinnabar": "#${config.colorScheme.palette.base08}",
        "white": "#FFFFFF"
      },
      "blocks": [
        {
          "alignment": "left",
          "segments": [
            {
              "background": "p:raisin_black",
              "foreground": "p:white",
              "powerline_symbol": "\ue0b4",
              "leading_diamond": "\ue0b6",
              "style": "diamond",
              "template": "{{.Icon}} ",
              "type": "os"
            },
            {
              "background": "p:raisin_black",
              "foreground": "p:white",
              "powerline_symbol": "\ue0b4",
              "style": "diamond",
              "template": "{{ .UserName }}",
              "type": "session"
            },
            {
              "background": "p:khaki",
              "foreground": "p:raisin_black",
              "properties": {
                "folder_icon": "..\ue5fe..",
                "home_icon": "~",
                "style": "agnoster_short"
              },
              "powerline_symbol": "\ue0b4",
              "style": "powerline",
              "template": " {{ .Path }}",
              "type": "path"
            },
            {
              "background": "p:lemon_chiffon",
              "foreground": "p:raisin_black",
              "style": "powerline",
              "properties": {
                "branch_icon": "\ue725 ",
                "cherry_pick_icon": "\ue29b ",
                "commit_icon": "\uf417 ",
                "fetch_status": false,
                "fetch_upstream_icon": false,
                "merge_icon": "\ue727 ",
                "no_commits_icon": "\uf0c3 ",
                "rebase_icon": "\ue728 ",
                "revert_icon": "\uf0e2 ",
                "tag_icon": "\uf412 "
              },
              "powerline_symbol": "\ue0b4",
              "template": " {{ .HEAD }}",
              "type": "git"
            }
          ],
          "type": "prompt"
        }
      ],
      "final_space": true,
      "version": 2
    }
  '';
}