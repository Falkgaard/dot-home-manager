{ config, pkgs, ... }:
{
   home.packages = with pkgs; [
                      yazi
                   ];

   programs.yazi = {
      enable                = true;
      enableFishIntegration = true; # TODO: Find out how to accomodate other shells.
      # TODO: settings, theme, plugins, keymap, etc
   };
}

