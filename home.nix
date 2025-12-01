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
   # TODO: Stylix integration.
   programs.niri.settings = with config.lib.niri.actions; {
      binds = {
         "Mod+Space".action = toggle-overview;
         "Mod+Return".action.spawn = [ "kitty" ]; # TODO: Make terminal agnostic?

            #"Mod+Ctrl+r".action ... # TODO: reload config?
         "Mod+Ctrl+X".action = quit;
         "Mod+Ctrl+W".action = close-window;
         # Runners:
         "Mod+W".action.spawn = [ "rofi" "-normal-window" "-show" "window" "-display-window" "Window" "-yoffset" "4" ];
         "Mod+R".action.spawn = [ "rofi" "-normal-window" "-show" "run" "-display-run" "Command" "-yoffset" "4" ];
         "Mod+A".action.spawn = [ "rofi" "-normal-window" "-show" "drun" "-display-drun" "App" "-yoffset" "4" ];
         "Mod+C".action.spawn = [ "rofi" "-normal-window" "-show" "calc" "-display-calc" "Calculate" "-yoffset" "4" "-calc-error-color" "'#FF0000'" ]; #TODO: Stylix
         # Screenshotting:
         "Mod+S".action.spawn       = [ "flameshot" "gui" ];
         "Mod+Shift+S".action.spawn = [ "flameshot" "full" ];
         # Window fullscreen:
         "Mod+F".action       = fullscreen-window;
         "Mod+Shift+F".action = toggle-windowed-fullscreen;
         # Window floatiness:
         "Mod+T".action       = toggle-window-floating;
         "Mod+Shift+T".action = switch-focus-between-floating-and-tiling; # What's the difference?
         # Modify gap:
            # "Mod+M".action ...
            # "Mod+Shift+M".action ...
         # Window focus movement:
         "Mod+H".action = focus-window-up-or-column-left;
         "Mod+J".action = focus-monitor-previous;
         "Mod+K".action = focus-monitor-next;
         "Mod+L".action = focus-window-down-or-column-right;
         # Window growth:
            # "Mod+Ctrl+H".action = ...;
            # "Mod+Ctrl+J".action = ...;
            # "Mod+Ctrl+K".action = ...;
            # "Mod+Ctrl+L".action = ...;
         # Window swapping:
         "Mod+Shift+H".action = move-window-to-monitor-previous;
         "Mod+Shift+J".action = swap-window-right;
         "Mod+Shift+K".action = swap-window-left;
         "Mod+Shift+L".action = move-window-to-monitor-next;
         # TODO:
         #    "Mod+Ctrl+F".action ... toggly-mouse-focus
         #    screenshot
      };
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
         hide-after-inactive-ms = 2000;
         hide-when-typing       = false;
         size                   = 24;
         theme                  = "default";
      };
      #animations
      #gestures
      environment = {
         QT_QPA_PLATFORM = "wayland";
         DISPLAY         = null;
      };

      window-rules = [
         (with config.lib.stylix.colors.withHashtag; {
            matches = [
               { is-window-cast-target = true; }
            ];
            focus-ring = {
               active.color   = base08;
               inactive.color = base09;
            };
            geometry-corner-radius = {
               top-left     = 36.0;
               top-right    = 36.0;
               bottom-left  = 36.0;
               bottom-right = 36.0;
            };
            border.inactive.color = base0A;
            tab-indicator = {
               active.color   = base08;
               inactive.color = base09;
            };
         })
         {
            matches = [
               {
                  app-id     = "";
                  is-focused = false;
               }
            ];
            opacity                     = 0.85;
            draw-border-with-background = false;
         }
         {
            matches = [
               {
                  app-id     = "";
                  is-focused = true;
               }
            ];
            opacity                     = 0.95;
            draw-border-with-background = false;
         }
         {
            matches = [
               { app-id = "librewolf"; }
               { app-id = "firefox"; }
               { app-id = "net.lutris.Lutris"; }
            ];
            clip-to-geometry = true;
         }
         {
            matches = [
               { app-id = "^TkFDialog$"; }
               { app-id = "^Menu$"; }
               # { app-id = "^Ardour-\\d+\\.\\d+\\.\\d+$"; }
               # {
               #   app-id = "^$";
               #   title = "^$";
               # }
            ];
            open-floating = true;
         }
         {
            matches = [
               { app-id = "org.gnome.World.Secrets"; }
            ];
            block-out-from = "screencast";
         }
      ];

      #layer-rules

      # (DO-NOT-USE?) xwayland-satellite

      layout = {
         background-color = "#AA1111";
         gaps = 32;
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

