{ config, pkgs, inputs, ... }:
let
   color = config.lib.stylix.colors;
in
{
   stylix.targets.nixcord.enable = true;
   stylix.targets.vencord.enable = true;
   
   programs.nixcord = {
      enable                     = true;
      discord = { vencord.enable = true; }; # alt. `equicord.enable`
      # NOTE: Pick any:
      equibop.enable          = false;
      vesktop.enable          = false;
      dorion.enable           = false;
      
      #quickCss = "some css";
      config = {
         enableReactDevtools              = false;
         notifyAboutUpdates               = false;
         autoUpdate                       = true;
         autoUpdateNotification           = false;
         enabledThemes                    = [];
         disableMinSize                   = true;
         frameless                        = true;
        #plugins.alwaysAnimate.enable     = true;
        #plugins.alwaysTrust              = {
        #                                      enable       = true;
        #                                      confirmModal = false;
        #                                      domain       = true;
        #                                      file         = true;
        #                                   };
        #plugins.animalese.enable         = true; # NOTE: Equicord only.
        #plugins.betterFolders            = {
        #                                      enable         = true;
        #                                      keepIcons      = false;
        #                                      showFolderIcon = 1;
        #                                      sidebar        = true;
        #                                      sidebarAnim    = true;
        #                                   };
        #plugins.betterSettings           = {
        #                                      enable         = true;
        #                                      disableFade    = true;
        #                                      eagerLoad      = true;
        #                                      organizeMenu   = true;
        #                                   };
        #plugins.blurNsfw                 = {
        #                                      enable     = true;
        #                                      blurAmount = 16;
        #                                   };
        #plugins.cleanUserArea.enable     = true; # NOTE: Equicord only.
         plugins.clearUrLs.enable         = true;
         plugins.clientTheme              = {
                                               enable = true;
                                               color  = "${color.base03}"; # TODO
                                            };
        #plugins.clipsEnhancements.enable = true; # NOTE: Equicord only.
         plugins.consoleJanitor           = {
                                               enable         = true;
                                               disableLoggers = true;
                                            };
         plugins.dontRoundMyTimestamps.enable = true;
         plugins.fakeNitro                = {
                                               enable                      = true;
                                               enableEmojiBypass           = true;
                                               enableStickerBypass         = true;
                                               enableStreamQualityBypass   = true;
                                               disableEmbedPermissionCheck = true;
                                               emojiSize                   = 64.0;
                                               stickerSize                 = 192.0;
                                               transformEmojis             = true;
                                               transformStickers           = true;
                                            };
         #plugins.shikiCodeblocks, themeLibrary, quickThemeSwitcher

         #useQuickCss = false;
         #themeLinks  = [
         #  #"some/link/to/theme.css"
         #];
      };
   };
}

