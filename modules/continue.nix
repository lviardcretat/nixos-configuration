{ 
  pkgs,
  ... 
}: {
  home.file.".continue/config.json".text = ''
    {
      "models": [
        {
          "title": "Codestral",
          "provider": "mistral",
          "model": "codestral-latest",
          "apiKey": "[tkt]"
        }
      ],
      "tabAutocompleteModel": {
        "title": "Codestral",
        "provider": "mistral",
        "model": "codestral-latest",
        "apiKey": "[tkt]"
      }
    }
  '';
}