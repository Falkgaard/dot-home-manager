{ config, pkgs, ... }:
{
   home.username      = "falk";
   home.homeDirectory = "/home/falk";

   home.pointerCursor = {
      enable     = true;
      gtk.enable = true;
      x11.enable = true;
   };
   
   # Home Manager can manage environment variables through 'home.sessionVariables':
   home.sessionVariables = {
      EDITOR = "nvim";
      TERM   = "kitty";
      WEBKIT_DISABLE_COMPOSITING_MODE = 1; # TEMP
   };

   # TEMP (NOTE: will be refactored into modules/gui/desktop/window-manager/niri)
   programs.niri.settings = {
      #binds
      #switch-events
      #screenshot-path
      #hotkey-overlay
      #config-notification
      #clipboard
      #prefer-no-csd
      #spawn-at-startup
      #workspaces
      #overview
      input = {
         #mod-key
         #mod-key-nested
         focus-follows-mouse = {
            enable             = true;
            #max-scroll-amount = "20";
         };
         mouse = {
            enable           = true;
            left-handed      = false;
            middle-emulation = false;
            #natural-scroll
            #scroll-button
            #scroll-button-lock
            #scroll-factor
            #scroll-method
            accel-profile    = "flat"; # adaptive|flat
            accel-speed      = 0;
         };
         #warp-mouse-to-focus
         #workspace-auto-back-and-forth
         power-key-handling.enable = true;
         #NOTE: ignoring tablet stuff (for now)
         #NOTE: ignoring touch & touchpad stuff (for now)
         #NOTE: ignoring trackball & trackpoint stuff (for now)
         keyboard = {
            numlock = false;
            repeat-delay = 250; # ms
            repeat-rate  = 35;
            track-layout = "global"; # global|window
            #xkb
         };
      };
      outputs = {
         "eDP-1" = {
            enable = false;
            scale  = 1.0;
         };
         "HDMI-1" = {
            enable           = true;
            focus-at-startup = true;
            scale            = 1.5;
            position         = {
               x                = 0;
               y                = 0;
            };
            mode             = {
               width            = 3840;
               height           = 2160;
               refresh          = 30.0;
            };
            backdrop-color   = "#FF00FF";
            background-color = "#00FFFF";
         };
      };
      cursor = {
         hide-after-inactive-ms = 4000;
         hide-when-typing       = false;
         size                   = 36;
         theme                  = "default";
      };
      #animations
      #gestures
      environment = {
         QT_QPA_PLATFORM = "wayland";
         DISPLAY         = null;
      };
      #window-rules
      #layer-rules
      # (DO-NOT-USE?) xwayland-satellite

      layout = {
         background-color = "#AA1111";
         gaps = 16;
         #preset-column-widths
         #preset-window-heights
         #always-center-single-column
         #center-focused-column
         #default-column-display
         #default-column-width
         #tab-indicator
         #empty-workspace-above-first
         #struts
         border = {
            enable   = true;
            width    = 4;
            active.color   = "#FFFFFF";
            inactive.color = "#000000";
            urgent.color   = "#FF0000";
         };
         focus-ring = {
            enable   = true;
            width    = 4;
            active.color   = "#66FF66";
            inactive.color = "#00AA00";
            urgent.color   = "#FF6666";
         };
         shadow = {
            enable             = true;
            color              = "#00000070";
            draw-behind-window = false;
           #inactive-color     = null;
            offset             = {
               x                  = 2.5;
               y                  = 5.0;
            };
            softness           = 30.0;
            spread             =  5.0;
         };
         #insert-hint = {
         #   enable = true;
         #   #display = TODO: Figure out <decoration>
         #};
      };
   };
   
   imports = [
      modules/stylix

      modules/gui/util/flameshot
      
      modules/gui/desktop/compositor/picom
      modules/gui/desktop/window-manager/qtile
      modules/gui/desktop/runner/rofi
      
      modules/gui/app/discord
      modules/gui/app/web-browser/firefox
      modules/gui/app/graphics/2d-general/gimp
      modules/gui/app/graphics/2d-general/krita
      modules/gui/app/graphics/2d-pixel-art/libresprite
      modules/gui/app/graphics/3d-general/blender

      modules/gui/viewer/image/qimgv
      modules/gui/viewer/video/mpv # TODO: SVP

      modules/tui/terminal/kitty
      modules/tui/shell/fish
      modules/tui/shell-prompt/starship
      modules/tui/text-editor/neovim
      
      modules/tui/navigation/yazi
      modules/tui/navigation/eza
      modules/tui/navigation/fd
      modules/tui/navigation/fzf
      modules/tui/navigation/ripgrep
      modules/tui/navigation/tree
      
      modules/tui/viewer/resources/btop
      modules/tui/viewer/system/fastfetch
      modules/tui/viewer/text/bat
      
      modules/tui/util/feh
   ];

   xdg = {
      enable          = true;
      mime.enable     = true;
      mimeApps.enable = true;
      #portal = {
      #   enable       = true;
      #  #extraPortals = pkgs.xdg-desktop-portal-kde;
      #};
  };

   programs.git = {
      enable   = true;
      settings = {
         core = {
            editor       = "nvim";
            # whitespace = "trailing-space,space-before-tab";
         };
         user = {
            name = "falkgaard";
         };
         # url = {
         #    "ssh://git@host" = {
         #       insteadOf = "otherhost";
         #    };
         # };
      };
   };
   
   services.ssh-agent.enable = true;
   
   programs.ssh = {
      enable              = true;
      enableDefaultConfig = false;
      # extraConfig = ''
      #    Host github.com
      #    IdentityFile ${config.home.homeDirectory}/.ssh/id_rsa
      # '';
   };
   
   home.packages = with pkgs; [
      dconf
      easyeffects
      # e.g. `pkgs.hello`
      # e.g. `(pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })`
      # e.g. `(pkgs.writeShellScriptBin "my-hello" ''
      #          echo "Hello, ${config.home.username}!"
      #       '')`
   ];
   
   home.file = {
      # e.g. `".screenrc".source = dotfiles/screenrc;`
      # e.g. `".gradle/gradle.properties".text = ''
      #          org.gradle.console            = verbose
      #          org.gradle.daemon.idletimeout = 3600000
      #        '';`
   };
   
   programs.home-manager.enable = true;
   home.stateVersion = "25.05"; # NOTE: Do not edit.
}

