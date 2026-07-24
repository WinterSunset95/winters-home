{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    neovim

    # Svelte/SvelteKit
    svelte-language-server

    # Core Deps
    ripgrep
    fd
    wl-clipboard
    gnumake

    # Important lsps
    lua-language-server
    nil
    nixpkgs-fmt

    # Generic lsps
    pyright
    vtsls
    prettier
    gopls
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  # 3. Export the Svelte path globally so Neovim can find it without the wrapper
  home.sessionVariables = {
    NIX_SVELTE_PLUGIN_PATH = "${pkgs.svelte-language-server}/lib/node_modules/svelte-language-server/node_modules/typescript-svelte-plugin";
    EDITOR = "nvim";
  };

  # 4. Create the pure, unadulterated symlink
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/modules/nvim";
 }
