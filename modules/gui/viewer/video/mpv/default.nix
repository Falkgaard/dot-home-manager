{ pkgs, config, ... }:
{
   # TODO: Svp package?
   programs.mpv = {
      enable  = true;
      package = pkgs.mpv-unwrapped.wrapper {
         mpv = pkgs.mpv-unwrapped.override {
            vapoursynthSupport = true;
         };
         youtubeSupport = true;
      };
      bindings = {
         # TODO
      };
      config = {
         # TODO
         profile       = "gpu-hq";
         force-window  = true;
         ytdl-format   = "bestvideo+bestaudio";
         cache-default = 4000000;
      };
      defaultProfiles = [ "gpu-hq" ];
      extraInput = '''';
   };
}

