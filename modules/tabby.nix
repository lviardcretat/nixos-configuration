{ 
  pkgs,
  ... 
}: {
  home.packages = with pkgs; [
    tabby
  ];

  home.file.".tabby-client/agent/config.toml".text = ''
    [model.completion.http]
    kind = "mistral/completion"
    api_endpoint = "https://api.mistral.ai"
    api_key = "secret-api-key"
  '';
}
