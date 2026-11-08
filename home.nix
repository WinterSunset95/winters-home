{ config, pkgs, inputs, ... }: {
  imports = [
    ./modules/browsers.nix
    ./modules/vscode.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
    ./modules/performance.nix
    ./modules/party.nix
    ./modules/noctalia.nix
    ./modules/discord.nix
    ./modules/shell_tools.nix
    ./modules/zsh.nix
    ./modules/theme.nix
    ./modules/kitty.nix
    ./modules/media.nix
    ./modules/email.nix
    ./modules/qol.nix
    ./modules/minecraft.nix
    ./modules/auth.nix
    ./modules/ai_tools.nix
    ./modules/hacking.nix
  ];

  nixpkgs.config.allowUnfree = true;

	home.username = "autumn";
	home.homeDirectory = "/home/autumn";
  home.packages  = with pkgs; [
    beeper
    spotify
    spotify-player
    playerctl
    openvpn
    networkmanager-openvpn
    stremio-linux-shell
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];

  home.sessionVariables = {
    GST_PLUGIN_SYSTEM_PATH_1_0 = "$HOME/.nix-profile/lib/gstreamer-1.0";
  };

	programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "red"; # Options: rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender
    cursors.enable = true;
  };

  programs.nsticky = {
    enable = true;
    # settings = {
    #   sticky = {
    #     vesktop = {
    #       app-id = "vesktop";
    #       title = ".*Stream";
    #     };
    #   };
    # };
  };

  xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/modules/niri";
  xdg.configFile."awesome".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/modules/awesome";

	home.stateVersion = "26.05";
}

