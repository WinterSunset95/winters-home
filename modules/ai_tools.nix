{ pkgs, config, ... }:
let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    grip
    google-generativeai
    playwright
  ]);
in
{
  home.packages = with pkgs; [
    pythonEnv
    aider-chat
  ];

  programs.antigravity-cli = {
    enable = true;
    enableMcpIntegration = true;
  };

  home.file.".aider.conf.yml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/modules/aider.config.yml";
}
