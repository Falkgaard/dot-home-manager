{ config, pkgs, lib, ... }:
{
   stylix = {
      enable       = true;
      autoEnable   = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
      # tarot, mellow-purple, catpuccin...
      
      cursor = {
         name    = "Bibata-Modern-Classic"; # "Adwaita";
         package = pkgs.bibata-cursors;     # adwaita-icon-theme;
         size    = 36;
      };
      
      fonts = {
         serif = {
           package = pkgs.dejavu_fonts;
           name    = "DejaVu Serif";
         };
         
         sansSerif = {
           package = pkgs.dejavu_fonts;
           name    = "DejaVu Sans";
         };
         
         monospace = {
           package = pkgs.nerd-fonts.jetbrains-mono;
           name    = "JetBrainsMono Nerd Font";
         };
         
         emoji = {
           package = pkgs.noto-fonts-color-emoji;
           name    = "Noto Color Emoji";
         };
         
         sizes = {
            applications = 16;
            desktop      = 16;
            popups       = 16;
            terminal     = 16;
         };
      };
      
      opacity = {
         applications = 1.00;
         desktop      = 1.00;
         terminal     = 1.00;
         popups       = 1.00;
      };
   };
}

