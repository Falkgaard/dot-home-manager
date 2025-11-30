{ pkgs, config, ... }:
{
   config.home.packages = [ pkgs.blender ];
   config.xdg = {
      # desktopEntries.gimp = {
      #    name        = "gimp";
      #    genericName = "Image editor"; #?
      #    exec        = "gimp %u"; #?
      #    terminal    = false;
      #    categories  = [ "Graphics" "Viewer" "Qt" ]; #?
      #    icon        = "gimp";
      #    #NoDisplay  = true; # TODO
      #    mimeType    = [
      #       "image/jpeg"
      #       "image/png"
      #       "image/gif"
      #       "image/tiff"
      #       "image/bmp"
      #       # ?
      #    ];
      # };
   };
}

