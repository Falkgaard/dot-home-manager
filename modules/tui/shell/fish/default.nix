{ config, pkgs, ... }:
{
   programs.fish = {
      enable = true;

      shellAliases = {
         ".."       = "cd ..";
         "..."      = "cd ../..";
         "...."     = "cd ../../..";
         "dir"      = "dir --color=auto --hyperlink=auto";
         "fm"       = "yazi";
         "e"        = "echo";
         "v"        = "bat";
         "t"        = "tree -C";
         "fetch"    = "clear && fastfetch && e -e \"\\e[?25l\" && while true;sleep 1;end;";
         "cfg-tree" = "clear && e;ta ~/.config/nixos/ && e;ta ~/.config/home-manager/ -L99 && e -e \"\\e[?25l\" && while true;sleep 1;end;";
      };

      shellAbbrs = {
         icat  = "kitten icat";
         ngc   = "nix-collect-garbage";
         sr    = "~/system-reload.sh";
         hr    = "~/home-reload.sh";
         t     = "tree";
      };

      functions = {
         fish_greeting = "";
         ns  = "nix-shell ~/Shells/(string lower $argv[1])/shell.nix --run fish";
         lf  = "eza -lf $argv";
         ld  = "eza -lD $argv";
         td  = "eza -TD $argv";
         la  = "eza -la --group-directories-last $argv";
         ta  = "eza -Ta --group-directories-last $argv";
         lfs = "eza -lfrs size --no-permissions --no-time --no-user $argv";
         lds = "eza -lDrs size --no-permissions --no-time --no-user $argv";
         tds = "eza -TDrs size --no-permissions --no-time --no-user $argv";
         las = "eza -lars size --no-permissions --no-time --no-user $argv";
         tas = "eza -Tars size --no-permissions --no-time --no-user $argv";
         lfm = "eza -lfrs modified --no-permissions --no-filesize --no-user $argv";
         ldm = "eza -lDrs modified --no-permissions --no-filesize --no-user $argv";
         tdm = "eza -TDrs modified --no-permissions --no-filesize --no-user $argv";
         lam = "eza -lars modified --no-permissions --no-filesize --no-user $argv";
         tam = "eza -Tars modified --no-permissions --no-filesize --no-user $argv";
      };

      plugins = [
         {
            name = "fzf";
            src  = pkgs.fetchFromGitHub {
               owner  = "PatrickF1";
               repo   = "fzf.fish";
               rev    = "8920367cf85eee5218cc25a11e209d46e2591e7a";
               sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
            };
         }
      ];
   };
}

