{ config, pkgs, ... }:
{
   programs.nvf = {
      enable = true;
      
      settings.vim = {
         viAlias  = true;
         vimAlias = true;
         
         options = {
            list           = false;
            number         = true;
            relativenumber = true;
            shiftwidth     = 3;
            listchars      = "eol:⤶,tab:│ ,trail:·,extends:◀,precedes:▶,nbsp:␣,multispace:·,lead:·";
         };
         
         statusline.lualine.enable    = true;
         telescope.enable             = true;
         autocomplete.nvim-cmp.enable = true;
         
         lsp.enable = true;
         languages  = {
            enableTreesitter = true;
            # Languages:
            nix.enable = true;
            zig.enable = true;
         };
         
         ui = {
            borders.enable               = true;
           #nvim-highlight-colors.enable = true;
            colorizer.enable             = true;
            colorful-menu-nvim.enable    = true;
         };
         
         visuals = {
            nvim-web-devicons.enable  = true;
            rainbow-delimiters.enable = true;
         };
         
         utility = {
            yazi-nvim.enable = true;
            surround.enable  = true;
         };
         
         #mini = {
         #   animate.enable     = true;
         #   indentscope.enable = true;
         #};
          
         #diagnostics.config.virtual_lines
         #ui.smear-cursor = {
         #   enable                = true;
         #   mode                  = "trail";
         #   smearSteps            = 20;
         #   distanceStopAnimating = 0.5;
         #   hideTargetHack        = false;
         #   stiffness             = 0.8;
         #   trailingStiffness     = 0.5;
         #   fading                = true;
         #   maxFade               = 0.8;
         #   trailLength           = 10;
         #   speed                 = 1.0;
         #};
      };
   };
}

     #plugins = {
     #   # TODO: comment plugins
     #   # TODO: git, statusline? lsp? lazy stuff? coc stuff? cmp stuff?
     #   # TODO: dap, dap-lldb, dap-ui?, dap-view?, dap-virtual-text
     #   highlight-colors.enable   = true;
     #   #lsp? lspconfig?
     #   lsp-lines.enable          = true;
     #   lsp-signature.enable      = true;
     #   rainbow.enable            = true; # TODO
     #   # wtf
     #   #zig
     #};
     #
     #coc.enable = true;
     #plugins    = with pkgs.vimPlugins; [
     #                nvim-lspconfig
     #                nvim-treesitter.withAllGrammars
     #                gruvbox-material
     #                mini-nvim
     #             ];
# dap, coc, etc
# gitgutter, gitblame, gitsigns?
# floatterm?
# lazy-nvim
# zig?
# nix
# nix-develop?

