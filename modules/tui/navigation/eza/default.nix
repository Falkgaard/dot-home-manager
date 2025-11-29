{ config, pkgs, ... }:
{
   programs.eza = {
      enable                = true;
      enableFishIntegration = false;
      icons                 = "auto";
      colors                = "auto";
      git                   = true;
     #theme (NOTE: Should be handled by Stylix.)
      extraOptions = [
         "-hlb"
         "--hyperlink"
         "--total-size"
         "--time-style=long-iso"
         "--group-directories-last"
         "--level=3"
        #"--dereference"
      ];
   };
}

