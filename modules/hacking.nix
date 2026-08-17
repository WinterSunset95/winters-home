{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    nmap
    burpsuite
    zap
  ];
}
