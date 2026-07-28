{ pkgs, config, ... }: {
  programs.cava-bg = {
    enable = true;

    # # Declarative configuration (mirrors config.toml)
    # settings = {
    #   general.framerate = 60;
    #   audio.bar_count = 150;
    #   audio.height_scale = 0.7;
    #   colors.use_gradient = true;
    #   colors.extract_from_wallpaper = true;
    #   xray.enabled = true;
    # };

    # Systemd user service management
    systemd = {
      enable = true;
      # supervisor = true;    # Enable per-output child processes
      memoryMax = "500M";
      # watchdogSec = 30;     # Hardware watchdog (restart on freeze)
    };
  };

  xdg.configFile."cava-bg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/modules/cava-bg";
}
