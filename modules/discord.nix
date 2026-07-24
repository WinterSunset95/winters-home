{ pkgs, ... }: {
  programs.nixcord = {
    enable = true;
    
    # We use Vesktop instead of the official client for Wayland/Pipewire support
    discord.enable = false;
    vesktop.enable = true;

    config = {
      useQuickCss = true;
      # themeLinks = [
      #   # Matches your Tmux theme
      #   "https://raw.githubusercontent.com/catppuccin/discord/main/themes/mocha.theme.css"
      # ];
      #
      plugins = {
        hideMedia.enable = true;
        messageLogger.enable = true; # Keeps deleted messages visible locally
        typingTweaks.enable = true;
        voiceChatDoubleClick.enable = true;
        webKeybinds.enable = true;
        alwaysTrust.enable = true;
        clearUrls.enable = true; # Strips tracking parameters from links
      };
    };
  };
  xdg.desktopEntries.vesktop = {
    name = "Discord";
    genericName = "Internet Messenger";
    exec = "vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-gpu-rasterization --enable-zero-copy --ignore-gpu-blocklist --disable-features=Vulkan %U";
    icon = "discord";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    type = "Application";
    settings = {
      StartupWMClass = "Vesktop";
      Keywords = "discord;vencord;electron;chat";
    };
  };
}
