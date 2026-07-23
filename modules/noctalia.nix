{ pkgs, config, ... }: {
  programs.noctalia = {
    enable = true;
  };
  xdg.configFile."noctalia".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/modules/noctalia";
}
