{ config, pkgs, ... }:
{
   programs.kitty = {
      enable         = true;
      environment    = {};
     #keybindings    = {}; # TODO
     #mouseBindings  = {}; # TODO
      settings       = {
         dynamic_background_opacity = true;
	 confirm_os_window_close    = 0;
         font_ligatures             = true;
      };
      shellIntegration.enableFishIntegration = true;
   };
}

