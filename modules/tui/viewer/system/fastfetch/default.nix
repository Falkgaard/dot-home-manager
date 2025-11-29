{ config, pkgs, ... }:
{
   # Ensure the logo is in the correct XDG config directory
   #home.file.".config/fastfetch/os-logo.png".source = "./NixOS-logo.png";
   
   programs.fastfetch = {
      enable   = true;
      settings = {
                    logo   = {
                                type      = "auto"; # "nixos_small"
                                source    = "${config.xdg.configHome}/fetch-image";
                                width     = 38; # NOTE: In characters.
                                height    = 17; # NOTE: In characters.
                                padding   = {
                                               top   = 7;
                                               left  = 2;
                                               right = 4;
                                            };
                               #color     = {};
                             };
                   display = {
                                color      = "blue";
                                hideCursor = true;
                                size       = {
                                                binaryPrefix = "si";
                                             };
                                separator  = ":";
                                key        = {
                                                width       = 16;
                                                paddingLeft = 1;
                                                type        = "both";
                                             };
                             };
                   modules = [
                                "break"
                                "title"
                                "break"
                                {
                                   type = "os";
                                   key  = " OS";
                                }
                                {
                                   type = "kernel";
                                   key  = " Kernel";
                                }
                                # {
                                #    type = "init";
                                #    key  = "Init";
                                # }
                                {
                                   type = "lm";
                                   key  = " DM";
                                }
                                {
                                   type = "wm";
                                   key  = " WM";
                                }
                                {
                                   type = "de";
                                   key  = " DE";
                                }
                                "break"
                                {
                                   type = "theme";
                                   key  = " Theme";
                                }
                                {
                                   type = "font";
                                   key  = " Font";
                                }
                                {
                                   type = "cursor";
                                   key  = " Cursor";
                                }
                                "break"
                                {
                                   type = "terminal";
                                   key  = " Terminal";
                                }
                                {
                                   type = "shell";
                                   key  = " Shell";
                                }
                                {
                                   type = "editor";
                                   key  = " Editor";
                                }
                                "break"
                                {
                                   type = "cpu";
                                   key  = " CPU";
                                }
                                {
                                   type = "gpu";
                                   key  = " GPU";
                                }
                                {
                                   type = "memory";
                                   key  = " RAM";
                                }
                                {
                                   type = "disk";
                                   key  = " Disk";
                                }
                                {
                                   type = "swap";
                                   key  = " Swap";
                                }
                                "break"
                                {
                                   type = "opengl";
                                   key  = " OpenGL";
                                }
                                {
                                   type = "vulkan";
                                   key  = " Vulkan";
                                }
                                "break"
                                {
                                   type = "packages";
                                   key  = " Packages";
                                }
                                {
                                   type = "processes";
                                   key  = " Processes";
                                }
                                "break"
                                {
                                   type        = "colors";
                                   paddingLeft = 4;
                                   block       = {
                                                    width = 6;
                                                    range = {
                                                               minimum =  0;
                                                               maximum = 15;
                                                            };
                                                 };
                                }
                                "break"
                             ];
                 };
   };
}
# Missing prompt and icons
# OS
# Kernel
# Init
# LM
# DE
# WM

# theme
# font
# cursor

# Terminal
# Shell

# Uptime
# Processes
# Packages

# CPU
# GPU
# Memory
# Disk
# Swap

#Vulkan
# OGL

# Colors
