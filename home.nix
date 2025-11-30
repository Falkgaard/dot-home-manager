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

