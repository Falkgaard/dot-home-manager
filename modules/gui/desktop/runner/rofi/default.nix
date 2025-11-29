{ lib, config, pkgs, ... }:
let
   color = config.lib.stylix.colors;
in
{
   stylix.targets.rofi.enable = false;
   
   programs.rofi = {
      enable      = true;
      cycle       = true;
      location    = "top";
      extraConfig = {
                       steal-focus      = true;
                       transient-window = false;
                       hover-select     = true;
                       sorting-method   = "fzf";
                       matching         = "fuzzy";
                       show-icons       = true;
                    };
      plugins     = with pkgs; [ rofi-calc ];
      modes       = [ "window" "run" "drun" "calc" ];
      terminal    = "kitty"; # TODO: Figure out how to make it portable...
      theme       = let inherit (config.lib.formats.rasi) mkLiteral; in {
                       "*" = {
                          background                  = mkLiteral "#${color.base00}";
                          foreground                  = mkLiteral "#${color.base08}";
                          
                          normal-background           = mkLiteral "#${color.base00}";
                          normal-foreground           = mkLiteral "#${color.base03}";
                          active-background           = mkLiteral "#${color.base00}";
                          active-foreground           = mkLiteral "#${color.base05}";
                          urgent-background           = mkLiteral "#FF00FF";
                          urgent-foreground           = mkLiteral "#FF00FF";
                          
                          alternate-normal-background = mkLiteral "var(normal-background)";
                          alternate-normal-foreground = mkLiteral "var(normal-foreground)";
                          alternate-active-background = mkLiteral "var(active-background)";
                          alternate-active-foreground = mkLiteral "var(active-foreground)";
                          alternate-urgent-background = mkLiteral "var(urgent-background)";
                          alternate-urgent-foreground = mkLiteral "var(urgent-foreground)";
                          
                          selected-normal-background  = mkLiteral "#${color.base01}";
                          selected-normal-foreground  = mkLiteral "#${color.base04}";
                          selected-active-background  = mkLiteral "#${color.base01}";
                          selected-active-foreground  = mkLiteral "#${color.base05}";
                          selected-urgent-background  = mkLiteral "#FF00FF";
                          selected-urgent-foreground  = mkLiteral "#FF00FF";
                          
                          background-color            = mkLiteral "transparent";
                          text-color                  = mkLiteral "#${color.base07}"; # Calculator output text
                          border-color                = mkLiteral "#${color.base00}";
                          highlight                   = mkLiteral "bold italic";
                          separatorcolor              = mkLiteral "#${color.base02}";
                          scrollbar-handle            = mkLiteral "#${color.base03}";
                          scrollbar                   = mkLiteral "true";
                          width                       = mkLiteral "calc( 25% )";
                          margin                      = mkLiteral "0px";
                          padding                     = mkLiteral "0px";
                          spacing                     = mkLiteral "0px";
                       };
                       
                       "window" = {
                          padding           = 0;
                          background-color  = mkLiteral "var(background)";
                          border            = 0;
                          border-radius     = mkLiteral "18px";
                       };
                       
                       "mainbox" = {
                          padding           = mkLiteral "12px";
                          border            = 0;
                          border-radius     = mkLiteral "18px";
                          # children          = map mkLiteral [ "inputbar" "message" "listview" ];
                          children          = mkLiteral "[ inputbar, message, listview ]";
                       };
                       
                       "message" = {
                          # padding         = mkLiteral "2px";
                          # border-color    = mkLiteral "var(separatorcolor)";
                          # border          = mkLiteral "2px 0px 0px";
                          border-color      = mkLiteral "#FF00FF";
                          text-color        = mkLiteral "#${color.base07}";
                          background-color  = mkLiteral "#${color.base00}";
                          margin            = mkLiteral "12px 0 0";
                       };
                       
                       "textbox" = {
                          highlight         = mkLiteral "var(highlight)";
                          padding           = mkLiteral "8px 24px";
                          # text-color      = mkLiteral "var(foreground)";
                       };
                       
                       "listview" = {
                          margin            = mkLiteral "12px 0 0";
                          lines             = 10;
                          columns           = 1;
                          fixed-height      = false;
                          # padding         = mkLiteral "2px 0px 0px";
                          # scrollbar       = mkLiteral "var(scrollbar)";
                          # border-color    = mkLiteral "var(separatorcolor)";
                          # spacing         = mkLiteral "2px";
                          # border          = mkLiteral "2px 0px 0px";
                       };
                       
                       "element" = {
                          padding           = mkLiteral "8px 16px";
                          spacing           = mkLiteral "8px";
                          border-radius     = mkLiteral "16px";
                          # padding         = mkLiteral "2px";
                          # border          = 0;
                       };
                       
                       "element normal normal" = {
                          background-color  = mkLiteral "var(normal-background)";
                          text-color        = mkLiteral "var(normal-foreground)";
                       };
                       
                       "element normal urgent" = {
                          background-color  = mkLiteral "var(urgent-background)";
                          text-color        = mkLiteral "var(urgent-foreground)";
                       };
                       
                       "element normal active" = {
                          background-color  = mkLiteral "var(active-background)";
                          text-color        = mkLiteral "var(active-foreground)";
                       };
                       
                       "element selected normal" = {
                          background-color  = mkLiteral "var(selected-normal-background)";
                          text-color        = mkLiteral "var(selected-normal-foreground)";
                       };
                       
                       "element selected urgent" = {
                          background-color  = mkLiteral "var(selected-urgent-background)";
                          text-color        = mkLiteral "var(selected-urgent-foreground)";
                       };
                       
                       "element selected active" = {
                          background-color  = mkLiteral "var(selected-active-background)";
                          text-color        = mkLiteral "var(selected-active-foreground)";
                       };
                       
                       "element alternate normal" = {
                          background-color  = mkLiteral "var(alternate-normal-background)";
                          text-color        = mkLiteral "var(alternate-normal-foreground)";
                       };
                       
                       "element alternate urgent" = {
                          background-color  = mkLiteral "var(alternate-urgent-background)";
                          text-color        = mkLiteral "var(alternate-urgent-foreground)";
                       };
                       
                       "element alternate active" = {
                          background-color  = mkLiteral "var(alternate-active-background)";
                          text-color        = mkLiteral "var(alternate-active-foreground)";
                       };
                       
                       "scrollbar" = {
                          width             = mkLiteral "4px";
                          padding           = 0;
                          handle-width      = mkLiteral "8px";
                          border            = 0;
                          handle-color      = mkLiteral "var(scrollbar-handle)";
                       };
                       
                       "mode-switcher" = {
                          border-color      = mkLiteral "var(separatorcolor)";
                          border            = mkLiteral "2px 0px 0px";
                       };
                       
                       "inputbar" = {
                          # padding         = mkLiteral "2px";
                          # spacing         = 0;
                          # text-color      = mkLiteral "var(normal-foreground)";
                          # children        = map mkLiteral [ "prompt" "textbox-prompt-sep" "entry" "case-indicator" ];
                          background-color  = mkLiteral "#${color.base00}";
                          border-color      = mkLiteral "#${color.base03}";
                          border            = mkLiteral "2px";
                          border-radius     = mkLiteral "16px";
                          padding           = mkLiteral "8px 16px";
                          spacing           = mkLiteral "16px";
                          # children          = map mkLiteral [ "prompt" "textbox-prompt-sep" "entry" ];
                          children          = mkLiteral "[ prompt, entry ]"; #textbox-prompt-sep, entry ]";
                       };
                       
                       "case-indicator" = {
                          spacing           = 0;
                          text-color        = mkLiteral "var(normal-foreground)";
                       };
                       
                       "entry" = {
                          placeholder       = "Enter search term here...";
                          placeholder-color = mkLiteral "#${color.base02}";
                          spacing           = 0;
                          text-color        = mkLiteral "#${color.base07}"; # Actual search text
                          # text-color      = mkLiteral "var(normal-foreground)";
                       };
                       
                       "prompt" = {
                          spacing           = 0;
                          text-color        = mkLiteral "#${color.base05}"; # run | drun | window | etc
                       };
                       
                       "button" = {
                          spacing           = 0;
                          text-color        = mkLiteral "var(normal-foreground)";
                       };
                       
                       "button.selected" = {
                          background-color  = mkLiteral "var(selected-normal-background)";
                          text-color        = mkLiteral "var(selected-normal-foreground)";
                       };
                       
                       "#textbox-prompt-sep" = {
                          spacing           = 0;
                          expand            = false;
                          str               = ":";
                          text-color        = mkLiteral "#${color.base03}";
                          margin            = mkLiteral "0 0.3em 0 0";
                       };
                       
                       "element-text" = {
                         #background-color  = mkLiteral "inherit";
                          text-color        = mkLiteral "inherit";
                       };
                       
                       "element-icon" = {
                          background-color  = mkLiteral "inherit";
                          text-color        = mkLiteral "inherit";
                          vertical-align    = mkLiteral "0.5";
                          size              = mkLiteral "1em";
                       };
                    };
   };
}

