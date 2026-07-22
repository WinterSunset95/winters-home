{ pkgs, ... }: {
  home.packages = with pkgs; [
    nemo-with-extensions
    nemo-fileroller
    # nemo-terminal

    proton-vpn
    proton-vpn-cli

    wireguard-tools

    obs-studio
  ];

  programs.zathura = {
    enable = true;
  };
}
