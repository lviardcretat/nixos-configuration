{ 
  pkgs,
  ... 
}: {
  home.packages = with pkgs; [
    vscode
    nixd
    nixfmt-rfc-style
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json
      
      # Essentials
      mikestead.dotenv
      editorconfig.editorconfig

      # Nix
      jnoortheen.nix-ide
      mkhl.direnv

      # Devops
      editorconfig.editorconfig
      formulahendry.auto-close-tag
      formulahendry.auto-rename-tag
      eamodio.gitlens
      biomejs.biome
      joshbolduc.commitlint
      lokalise.i18n-ally

      # Languages and frameworks
      ecmel.vscode-html-css
      bradlc.vscode-tailwindcss
      nuxtr.nuxtr-vscode
      vue.volar
      luongnd.edge
      nuxt.mdc
      nuxtr.nuxt-vscode-extentions
      nicholashsiang.vscode-pinia-snippets

      # BDD
      imgildev.vscode-drizzle-snippets
      rphlmr.vscode-drizzle-orm
      yy0931.vscode-sqlite3-editor

      # UI
      pkief.material-icon-theme

      # Other
      antfu.goto-alias
      jacano.vscode-pnpm
      redhat.vscode-yaml
    ];
    userSettings = {
      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
          "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"github.com:lviardcretat/nixos-configuration\").nixosConfigurations.CONFIGNAME.options";
            };
            "home_manager" = {
              "expr" = "(builtins.getFlake \"github.com:lviardcretat/nixos-configuration\").homeConfigurations.CONFIGNAME.options";
            };
          };
        };
      };

      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";

      "codeium.enableConfig" = {
        "*" = true;
        "nix" = true;
        "edge" = true;
      };
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "explorer.confirmDelete" = false;
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "git.confirmSync" = false;

      "nuxtr.vueFiles.template.defaultLanguage" = "html";
      "nuxtr.vueFiles.firstTag" = "template";
      "nuxtr.vueFiles.script.type" = "setup";
      "nuxtr.vueFiles.script.defaultLanguage" = "ts";
      "nuxtr.vueFiles.style.addStyleTag" = true;
      "nuxtr.vueFiles.style.alwaysScoped" = true;
      "nuxtr.vueFiles.style.defaultLanguage" = "scss";
      "nuxtr.piniaFiles.defaultTemplate" = "options";
      "nuxtr.openItemsAfterCreation" = true;

      "files.associations" = {
        "*.css" = "tailwindcss";
        "*.scss" = "tailwindcss";
      };

      "editor.quickSuggestions" = {
        "strings" = "on";
      };
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "biomejs.biome";
      "editor.gotoLocation.multipleDefinitions" = "goto";

      "i18n-ally.localesPaths" = ["i18n/locales"];
      "i18n-ally.pathMatcher" = "{locale}.json";
      "i18n-ally.keystyle" = "nested";
      "i18n-ally.enabledParsers" = ["json"];
      "i18n-ally.autoDetection" = false;
      "i18n-ally.dirStructure" = "dir";
      "i18n-ally.sourceLanguage" = "fr";
      "i18n-ally.displayLanguage" = "fr";
    };
  };
}