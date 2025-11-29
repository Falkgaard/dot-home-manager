{ config, pkgs, ... }:
{
   services.picom = {
      enable          = true;
      activeOpacity   = 1.00;
      inactiveOpacity = 1.00;
      menuOpacity     = 1.00;
      shadow          = true;
      shadowOpacity   = 0.75;
      vSync           = true;
      settings        = {
                           backend                = "glx"; # xrender | glx | xr_glx_hybrid
                           corner-radius          = 18; # NOTE: Sync with rofi!
                           detect-rounded-corners = true;
                         # corner-radius-rules    = [ "0:fullscreen" ];
                           blur-background-fixed  = true;
                           detect-transient       = false;
                           detect-client-leader   = true;
                        };
      extraConfig     = ''
                           rules = (
                              { match = "QTILE_INTERNAL=1";           dim = 0.2; },
                              { match =         "!focused";           dim = 0.2; },
                            # { match =            "vmwin";           dim = 0.0; },
                            # { match =    "!name ~= \'\'";           dim = 0.0; },
                              { match =          "focused";           dim = 0.0; },
                              { match =       "fullscreen"; corner-radius = 0;   },
                           )
                        '';
   };
}








      # extraArgs, settings

      # fade, fadeSteps, fadeDelta, fadeExclude
      # opacityRules
     #shadowOffsets   = [ (2) (2) ];
      # shadowExclude


         #  rounded-corners-exclude = [
         #     "class_g = 'rofi'"
         #     "window_type = 'dock'"
         #     "! name~=''" # exclude windows with no name such as qtile's bar
         # ];



         # blur = {
         #    #kern      = ;
         #    #method    = "box";
         #    #size      = 0.5;
         #    #deviation = 5.0;
         # };

        # Rule for Rofi
        # {
        #   match = "class_g = 'Rofi'";   # Match window class "Rofi"
        #   # corner-radius = 24;           # Set corner radius to 24
        #   # shadow = false;               # Remove shadow (optional)
        #   invert-color = true;          # Invert colors
        # }

   #"{ match = "focused"; opacity = 0.5; }"

# match = "focused";
# match = "fullscreen";
# match = "override_redirect"; # ???
# match = "group_focused"; # ??? requires detect-transient or detect-client-leader
# match = "argb"; # what are ARGB visuals?
# match = "vmwin"; # possible WM window; no client window and no override-redirection
# match = "window_type"; # TODO
# match = "name"; # TODO
# match = "class_i"; # TODO
# match = "class_g"; # TODO
# match = "role"; # TODO
# TODO: Target and @

# shadow = true;
# full-shadow = true;
# fade = false;
# opacity = 0.2;
# dim = 0.5;
# corner-radius = 5;
# blur-background = true;
# clip-shadow-above = true; # prevents shadows on top
# invert-color = true;
# unredir = true? false? preferred? passive? forced? # TODO: Look into
# transparent-clipping = false;
# shader = path;
# animations = ?  # TODO

