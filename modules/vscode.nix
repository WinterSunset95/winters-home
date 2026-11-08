{ pkgs, config, ... }: {
  programs.vscode = {
    enable = true;
    
    # Automatically update extensions if managed outside Nix (optional)
    # enableExtensionUpdateCheck = false;
    # enableUpdateCheck = false;

    # Install extensions from nixpkgs
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix           # Nix language support
        asvetliakov.vscode-neovim
        dracula-theme.theme-dracula
        svelte.svelte-vscode
        tauri-apps.tauri-vscode
        ms-vsliveshare.vsliveshare
        rust-lang.rust-analyzer
      ];

      # Declare user settings JSON declaratively
      userSettings = {
        # "workbench.colorTheme" = "Dracula";
        "editor.fontSize" = 14;
        "editor.minimap.enabled" = false;
        "telemetry.telemetryLevel" = "off"; # Disable telemetry
        "update.mode" = "none";
      };

      # Keybindings configuration
      keybindings = [
        {
          key = "ctrl+c";
          command = "editor.action.clipboardCopyAction";
          when = "editorTextFocus";
        }
      ];
    };
  };
}
