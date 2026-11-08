{ pkgs, ... }: {
  programs.feh = {
    enable = true;
  };
  programs.mpv = {
    enable = true;
  };
  programs.imv = {
    enable = true;
  };
  home.packages = with pkgs; [
   vlc
  ];
}
