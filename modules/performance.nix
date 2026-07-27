{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "resource-jail" ''
      CPU="100%"
      MEM="2"

      # Parse flags: -c for CPUQuota, -m for MemoryMax (in GB)
      while getopts "c:m:" opt; do
        case $opt in
          c) CPU="$OPTARG" ;;
          m) MEM="$OPTARG" ;;
        esac
      done
      shift $((OPTIND -1))

      # Convert GB to kB for /proc/meminfo spoofing
      MEM_KB=$((MEM * 1024 * 1024))
      FAKE_MEM="$XDG_RUNTIME_DIR/fake_meminfo_''${MEM}G"

      # Generate the fake file only if it doesn't already exist in the RAM disk
      if [ ! -f "$FAKE_MEM" ]; then
        sed -e "s/MemTotal:.*/MemTotal:        $MEM_KB kB/" \
            -e "s/MemFree:.*/MemFree:         $MEM_KB kB/" \
            -e "s/MemAvailable:.*/MemAvailable:    $MEM_KB kB/" /proc/meminfo > "$FAKE_MEM"
      fi

      # systemd requires unique unit names for transient scopes
      UNIT_NAME="jail-$(basename "$1")-$RANDOM"

      exec systemd-run --user --scope --unit="$UNIT_NAME" -p CPUQuota="$CPU" -p MemoryMax="''${MEM}G" \
        bwrap --bind / / --dev-bind /dev /dev --proc /proc \
              --ro-bind "$FAKE_MEM" /proc/meminfo \
              "$@"
    '')
    bubblewrap
  ];
  xdg.desktopEntries = {
  
    beeperjailed = {
      name = "Beeper Jailed";
      comment = "Unified Chat App";
      # 2GB RAM, 100% CPU
      exec = "resource-jail -c 100%% -m 2 beeper --no-sandbox %U";
      icon = "beepertexts";
      terminal = false;
      type = "Application";
      categories = [ "Network" ];
      settings = {
        StartupWMClass = "Beeper";
        "X-AppImage-Version" = "4.2.985";
      };
      mimeType = [ "x-scheme-handler/beeper" ];
    };

    spotijailed = {
      name = "Spotify Jailed";
      genericName = "Music Player";
      # 1GB RAM, 100% CPU
      exec = "resource-jail -c 100%% -m 1 spotify --no-sandbox %U";
      icon = "spotify-client";
      terminal = false;
      type = "Application";
      categories = [ "Audio" "Music" "Player" "AudioVideo" ];
      settings = {
        StartupWMClass = "spotify";
        TryExec = "spotify";
      };
      mimeType = [ "x-scheme-handler/spotify" ];
    };

    qutebrowser = {
      name = "Qutebrowser Jailed";
      genericName = "Web Browser";
      comment = "A keyboard-driven, vim-like browser based on Python and Qt";
      # 4GB RAM, 250% CPU
      exec = "env QTWEBENGINE_DISABLE_SANDBOX=1 resource-jail -c 200%% -m 4 qutebrowser --untrusted-args %u";
      icon = "qutebrowser";
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "application/xml" "application/rdf+xml" "image/gif" "image/webp" "image/jpeg" "image/png" "x-scheme-handler/http" "x-scheme-handler/https" "x-scheme-handler/qute" ];
      settings = {
        StartupWMClass = "qutebrowser";
        StartupNotify = "true";
        Keywords = "Browser";
      };
      # Translates your [Desktop Action] blocks
      actions = {
        "new-window" = {
          name = "New Window";
          exec = "resource-jail -c 200%% -m 4 qutebrowser";
        };
        "preferences" = {
          name = "Preferences";
          exec = "resource-jail -c 200%% -m 4 qutebrowser \"qute://settings\"";
        };
      };
    };

  };
}
