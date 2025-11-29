{ config, pkgs, inputs, ... }:
let
   color       = config.lib.stylix.colors;
   lock-strict = { Value = "strict"; Status = "locked"; };
   lock-false  = { Value = false;    Status = "locked"; };
   lock-true   = { Value = true;     Status = "locked"; };
in
{
   xdg.configFile.darkreader = {
      enable   = true;
     #onChange = ??; # TODO: Manually tell darkreader to refresh somehow.
      target   = "darkreader/config.json";
      text     = ''{
         "schemeVersion"            : 2,
         "enabled"                  : true,
         "fetchNews"                : true,
         "theme"                    : {
                                         "mode"                       : 1,
                                         "brightness"                 : 100,
                                         "contrast"                   : 100,
                                         "grayscale"                  : 0,
                                         "sepia"                      : 0,
                                         "useFont"                    : false,
                                         "fontFamily"                 : "Open Sans",
                                         "textStroke"                 : 0,
                                         "engine"                     : "dynamicTheme",
                                         "stylesheet"                 : "",
                                         "darkSchemeBackgroundColor"  : "#${color.base00}",
                                         "darkSchemeTextColor"        : "#${color.base05}",
                                         "lightSchemeBackgroundColor" : "#${color.base05}",
                                         "lightSchemeTextColor"       : "#${color.base00}",
                                         "scrollbarColor"             : "auto",
                                         "selectionColor"             : "auto",
                                         "styleSystemControls"        : false,
                                         "lightColorScheme"           : "Default",
                                         "darkColorScheme"            : "Default",
                                         "immediateModify"            : false
                                      },
         "presets"                  : [],
         "customThemes"             : [],
         "enabledByDefault"         : true,
         "enabledFor"               : [],
         "disabledFor"              : [],
         "changeBrowserTheme"       : false,
         "syncSettings"             : false,
         "syncSitesFixes"           : true,
         "automation"               : {
                                         "enabled"  : false,
                                         "mode"     : "",
                                         "behavior" : "OnOff"
                                      },
          "time"                    : {
                                         "activation"   : "18:00",
                                         "deactivation" :  "9:00"
                                      },
          "location":                 {
                                         "latitude"  : null,
                                         "longitude" : null
                                      },
          "previewNewDesign"        : true,
          "enableForPDF"            : true,
          "enableForProtectedPages" : true,
          "enableContextMenus"      : true,
          "detectDarkTheme"         : false,
          "displayedNews"           : [ "thanks-2023" ]
      }'';
   };
   
   stylix.targets.librewolf = {
      enable                   = false;
      colorTheme.enable        = true;
     #firefoxGnomeTheme.enable = false;
      profileNames             = [ "falk" ];
   };
   
   stylix.targets.firefox = {
      enable                   = true;
      colorTheme.enable        = true;
     #firefoxGnomeTheme.enable = true;
      profileNames             = [ "falk" ];
   };
   
   programs.librewolf = {
      enable                           = false;
      profiles."falk".extensions.force = true;
   };

   programs.firefox = {
      enable = true;
      
      languagePacks = [ "en-IE" "sv" "jp" ];
      
      policies = {
         BlockAboutConfig          = true;
         DefaultDownloadDirectory  = "~/Downloads/";
         DisableTelemetry          = true;
         DisableFirefoxStudies     = true;
         DisablePocket             = true;
         DisableFirefoxAccounts    = true;
         DisableAccounts           = true;
         DisableFirefoxScreenshots = true;
         EnableTrackingProtection  = {
                                        Value          = true;
                                        Locked         = true;
                                        Cryptomining   = true;
                                        Fingerprinting = true;
                                     };
         OverrideFirstRunPage      = "";
         OverridePostUpdatePage    = "";
         DontCheckDefaultBrowser   = true;
         DisplayBookmarksToolbar   = "never";       #    "never" | "always" | "newtab"
         DisplayMenuBar            = "default-off"; #   "always" | "never"  | "default-on" | "default-off"
         SearchBar                 = "unified";     # "separate" | "unified"
         
         # NOTE: Check about:config for options.
         Preferences = { 
            "browser.contentblocking.category"                                       = lock-strict;
            "extensions.pocket.enabled"                                              = lock-false;
            "extensions.screenshots.disabled"                                        = lock-true;
            "devtools.debugger.enabled"                                              = lock-true;
            "devtools.chrome.enabled"                                                = lock-true;
            "devtools.debugger.remote-enabled"                                       = lock-true;
            "browser.topsites.contile.enabled"                                       = lock-false;
            "browser.formfill.enable"                                                = lock-false;
            "browser.search.suggest.enabled"                                         = lock-false;
            "browser.search.suggest.enabled.private"                                 = lock-false;
            "browser.urlbar.suggest.searches"                                        = lock-false;
            "browser.urlbar.showSearchSuggestionsFirst"                              = lock-false;
            "browser.newtabpage.activity-stream.feeds.section.topstories"            = lock-false;
            "browser.newtabpage.activity-stream.feeds.snippets"                      = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket"    = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited"   = lock-false;
            "browser.newtabpage.activity-stream.showSponsored"                       = lock-false;
            "browser.newtabpage.activity-stream.system.showSponsored"                = lock-false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites"               = lock-false;
         };
      };
      
      profiles = {
         falk = {
            id              = 0;
            isDefault       = true;
            containersForce = true; # ?
            # NOTE: add `path` if it ever becomes needed.
            
            settings = {
               "layout.css.devPixelsPerPx"                           = 1.0;
               "extensions.autoDisableScopes"                        = 0;
               "extensions.update.autoUpdateDefault"                 = false;
               "extensions.update.enabled"                           = false;
               "browser.startup.homepage"                            = "https://nixos.org";
               "browser.search.region"                               = "IE";    # TODO: Use locale
               "browser.search.isUS"                                 = false;
               "distribution.searchplugins.defaultLocale"            = "en-IE"; # TODO: Use locale
               "general.useragent.locale"                            = "en-IE"; # TODO: Use locale
               "browser.bookmarks.showMobileBookmarks"               = false;   # NOTE: For custom tabs.
               "toolkit.legacyUserProfileCustomizations.stylesheets" = true;    # NOTE: For custom tabs.
               "svg.context-properties.content.enabled"              = true;
               "browser.newtabpage.pinned"                           = [{
                                                                          title = "NixOS";
                                                                          url   = "https://nixos.org";
                                                                       }];
            };
            
            #preConfig   = ""; # NOTE: Add when needed.
            #extraConfig = ""; # NOTE: Add when needed.
            userChrome   = builtins.readFile ./gruvbox-gnomeish-userChrome.css;
            userContent  = builtins.readFile ./gruvbox-gnomeish-userContent.css;
            
            # userChrome   = ''
            #                  @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* set default namespace to XUL */
            #
            #                  /* ROOT - VARS */
            #                  *|*:root {
            #                   --tab-min-height:      12px !important; /* adjust */
            #                   --tab-min-width:       50px !important; /* adjust */
            #                  }
            #
            #                  /* TABS: height */
            #                  #tabbrowser-tabs,
            #                  #tabbrowser-tabs > #tabbrowser-arrowscrollbox,
            #                  .tabbrowser-tabs .tabbrowser-tab {
            #                    min-height: var(--tab-min-height) !important;
            #                    max-height: var(--tab-min-height) !important;
            #                  }
            #
            #                  #personal-toolbar-empty-description {
            #                      opacity: 0;
            #                  }
            #
            #                  #personal-toolbar-empty-description a {
            #                      display: none;
            #                  }
            #
            #                  .tab-content { font-size: 8px !important; }
            #
            #                  /* Adjust the height of the tabs */
            #                  .tabbrowser-tab {
            #                      height: 28px !important;
            #                  }
            #
            #                  /* Adjust the size of the text on the tabs */
            #                  .tabbrowser-tab .tab-label {
            #                      font-size: 8px !important;
            #                      padding-top: 4px !important;
            #                      padding-bottom: 4px !important!;
            #                  }
            #
            #                  /* Adjust padding to fine-tune the tab size */
            #                  .tabbrowser-tab .tab-text {
            #                      padding-top: 4px !important;
            #                      padding-bottom: 4px !important;
            #                  }
            #               '';
            
            search = {
               default        = "ddg"; # DuckDuckGo
               privateDefault = "ddg"; # DuckDuckGo
               force          = true;
               order          = [ "ddg" ]; # TODO
               engines        = {
                  nix-packages   = {
                     name           = "Nix Packages";
                     icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                     definedAliases = [ "@np" ];
                     urls           = [{
                        template = "https://search.nixos.org/packages";
                        params   = [
                           { name = "type";  value = "packages";      }
                           { name = "query"; value = "{searchTerms}"; }
                        ];
                     }];
                  };
                 
                  nixos-wiki = {
                     name            = "NixOS Wiki";
                     urls            = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
                     iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                     definedAliases  = [ "@nw" ];
                  };
                  
                  # TODO: HM search?
                  
                  bing.metaData.hidden  = true;
                  google.metaData.alias = "@g"; # NOTE: builtin engines only support specifying one additional alias.
               };
            };
            
            # User containers:
            containers = {};
            
            extensions = {
               force    = true;
               packages = with inputs.firefox-addons.packages.${pkgs.system}; [
                  ublock-origin
                  darkreader
                  firefox-color
               ];
               settings = {
                  firefox-color = {
                     force    = true;
                     settings = {};
                  };
                  darkreader = {
                     force    = true;
                     settings = {};
                  };
                  ublock-origin = {
                     force    = true;
                     settings = {};
                  };
               };
            };
         };
      };
   };
}

