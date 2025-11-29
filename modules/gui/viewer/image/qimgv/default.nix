{ pkgs, config, ... }:
{
   config.home.packages = [ pkgs.qimgv ];
   config.xdg = {
      desktopEntries.qimgv = {
         name = "qimgv";
         genericName = "Image viewer";
         exec        = "qimgv %u";
         terminal    = false;
         categories  = [ "Graphics" "Viewer" "Qt" ];
         icon        = "qimgv";
         #NoDisplay  = true; # TODO
         mimeType    = [
            "image/jpeg"
            "image/png"
            "image/gif"
            "image/webp"
            "image/tiff"
            "image/bmp"
            "image/svg+xml"
         ];
      };
      mimeApps.defaultApplications = {
         "image/jpeg"    = [ "qimgv.desktop" ];
         "image/png"     = [ "qimgv.desktop" ];
         "image/gif"     = [ "qimgv.desktop" ];
         "image/webp"    = [ "qimgv.desktop" ];
         "image/tiff"    = [ "qimgv.desktop" ];
         "image/bmp"     = [ "qimgv.desktop" ];
         "image/svg+xml" = [ "qimgv.desktop" ];
      };
   };
}

