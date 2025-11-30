{ config, pkgs, lib, ... }:
let
   color = config.lib.stylix.colors;
   fonts = config.stylix.fonts;
   
   autostart_sh = ''
      #!/bin/sh
      ~/go-4k.sh
      #picom --backend xrender -b
      # --- DEPRECATED ---- Using home-manager instead!
   '';
   
   qtile_cfg = ''
      import os                   # for autostart
      import subprocess           # for autostart
      from libqtile import hook   # for autostart
      
      @hook.subscribe.startup_once
      def autostart():
          home = os.path.expanduser('~/.config/qtile/autostart.sh')
          subprocess.call([home])
      
      from libqtile import bar, layout, qtile, widget
      from libqtile.config import Click, Drag, Group, Key, Match, Screen
      from libqtile.lazy import lazy
      from libqtile.utils import guess_terminal
      
      mod           = "mod4"
      terminal      = guess_terminal()
      file_manager  = "dolphin"   # NOTE: Set your preferred file manager binary here.
      
      @lazy.layout.function
      def modify_gap_size(layout, n):
          layout.margin += n
          if layout.margin < 0:
              layout.margin = 0
          layout.cmd_reset()

      @lazy.function
      def toggle_follow_mouse_focus(qtile):
          qtile.config.follow_mouse_focus = not qtile.config.follow_mouse_focus
      
      keys = [
          Key( [mod], "w", lazy.spawn("rofi -normal-window -show window -display-window 'Window' -yoffset 4"), desc="Shows a window selection widget" ),
          Key( [mod], "r", lazy.spawn("rofi -normal-window -show run -display-run 'Command' -yoffset 4"),      desc="Shows a command launcer widget"  ),
          Key( [mod], "a", lazy.spawn("rofi -normal-window -show drun -display-drun 'App' -yoffset 4"),        desc="Shows an app launcher widget"    ),
          Key( [mod], "c", lazy.spawn("rofi -normal-window -show calc -display-calc 'Calculate' -yoffset 4 -calc-error-color '#${color.base08}'"), desc="Shows a calculator widget"       ),
          
         #Key( [mod           ], "r", lazy.spawncmd(),                 desc="Spawn a command using a prompt widget" ),
         #Key( [mod, "control"], "r", lazy.spawn("~/home-reload.sh"),  desc="Reloads the home-manager config"       ),
          Key( [mod, "control"], "r", lazy.reload_config(),            desc="Reload the config"                     ),
          Key( [mod, "control"], "x", lazy.shutdown(),                 desc="Shutdown Qtile"                        ),
          Key( [mod, "control"], "w", lazy.window.kill(),              desc="Kill focused window"                   ),
          
          Key( [mod         ], "m", modify_gap_size(n = +5), desc="Increases gaps by +5" ),
          Key( [mod, "shift"], "m", modify_gap_size(n = -5), desc="Increases gaps by -5" ),
          
          # Switch between windows
          Key( [mod],     "h", lazy.layout.left(),  desc="Move focus to left"                ),
          Key( [mod],     "l", lazy.layout.right(), desc="Move focus to right"               ),
          Key( [mod],     "j", lazy.layout.down(),  desc="Move focus down"                   ),
          Key( [mod],     "k", lazy.layout.up(),    desc="Move focus up"                     ),
          Key( [mod], "space", lazy.layout.next(),  desc="Move window focus to other window" ),
          
          # Move windows between left/right columns or move up/down in current stack.
          # Moving out of range in Columns layout will create new column.
          Key( [mod, "shift"], "h", lazy.layout.shuffle_left(),  desc="Move window to the left"  ),
          Key( [mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right" ),
          Key( [mod, "shift"], "j", lazy.layout.shuffle_down(),  desc="Move window down"         ),
          Key( [mod, "shift"], "k", lazy.layout.shuffle_up(),    desc="Move window up"           ),
          
          # Grow windows. If current window is on the edge of screen and direction will be to screen edge - window would shrink.
          Key( [mod, "control"], "h", lazy.layout.grow_left(),  desc="Grow window to the left"  ),
          Key( [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right" ),
          Key( [mod, "control"], "j", lazy.layout.grow_down(),  desc="Grow window down"         ),
          Key( [mod, "control"], "k", lazy.layout.grow_up(),    desc="Grow window up"           ),
          Key( [mod           ], "n", lazy.layout.normalize(),  desc="Reset all window sizes"   ),
          
          # Toggle between split and unsplit sides of stack:
          #    Split   => all windows displayed
          #    Unsplit => 1 window displayed, like Max layout, but still with multiple stack panes
          Key( [mod, "shift"],      "f", toggle_follow_mouse_focus(),      desc="Toggle focus following the cursor"               ),
          Key( [mod, "shift"], "Return", lazy.layout.toggle_split(),       desc="Toggle between split and unsplit sides of stack" ),
          Key( [mod         ], "Return", lazy.spawn(terminal),             desc="Launch terminal"                                 ),
          Key( [mod         ],    "Tab", lazy.next_layout(),               desc="Toggle between layouts"                          ),
          Key( [mod         ],      "e", lazy.spawn(file_manager),         desc="Launch a file manager"                           ),
          Key( [mod         ],      "f", lazy.window.toggle_fullscreen(),  desc="Toggle fullscreen on the focused window"         ),
          Key( [mod         ],      "t", lazy.window.toggle_floating(),    desc="Toggle floating on the focused window"           ),
          Key( [mod, "shift"],      "s", lazy.spawn("flameshot gui"),      desc="Take a screenshot (GUI)"                         ),
          Key( [mod         ],      "s", lazy.spawn("flameshot full"),     desc="Take a screenshot of all screens"                ),
      ]
      
      # Add key bindings to switch VTs in Wayland.
      # We can't check qtile.core.name in default config as it is loaded before qtile is started
      # We therefore defer the check until the key binding is run by using .when(func=...)
      for vt in range(1, 8):
          keys.append(
              Key(
                  ["control", "mod1"],
                  f"f{vt}",
                  lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
                  desc=f"Switch to VT{vt}",
              )
          )
      
      groups = [Group(i) for i in "123456789"]
      for i in groups:
          keys.extend([
              # mod + group number => switch to group:
              Key( [mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}" ),
              # mod + shift + group number => switch to & move focused window to group
              Key( [mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False), desc=f"Move focused window to group {i.name}" ),
          ])
      
      layouts = [
          # layout.Columns(border_focus_stack=["#00FFFF", "#FF00FF"], border_width=4),
          # layout.Max(),
          # Try more layouts by unleashing below layouts.
          # layout.Stack(num_stacks=2),
          # layout.Bsp(),
          # layout.Matrix(),
            layout.MonadTall(
                align               = layout.MonadTall._left,
                border_focus        = "#${color.base00}", #7}",
                border_normal       = "#${color.base00}", #2}",
                border_width        = 16,  # 3,
                margin              = 24,  # 8,
                single_border_width = 16,  # 3,
                single_margin       = 24,  # 8
          ),
          # layout.MonadWide(),
          # layout.RatioTile(),
          # layout.Tile(),
          # layout.TreeTab(),
          # layout.VerticalTile(),
          # layout.Zoomy(),
      ]
      
      widget_defaults = dict(
          font     = "${fonts.sansSerif.name}",
          fontsize = ${toString fonts.sizes.desktop},
          padding  = 2,
      )
      #extension_defaults = widget_defaults.copy()
      
      screens = [
          Screen(
              top=bar.Bar(
                  [
                      widget.Spacer( length = -2 ),
                      #widget.CurrentLayout(),
                      widget.GroupBox(
                          foreground                 = '#00FFFF',
                          active                     = '#${color.base06}',
                          inactive                   = '#${color.base03}',
                          fontsize                   = 24,
                          border                     = '#${color.base05}',
                          borderwidth                = 4,
                          padding                    = 6,
                          highlight_method           = 'line',
                          highlight_color            = ['#${color.base02}', '#${color.base02}'],
                          fontshadow                 = '#000000', #${color.base02}',
                          rounded                    = True,
                          block_border               = '#FF00FF',
                          this_current_screen_border = '#${color.base0A}', #'#303030',
                          this_screen_border         = '#FFFF00',
                          urgent_border              = '#FF0000',
                          urgent_text                = '#FFFFFF',
                      ),
                      widget.Spacer( length = 10 ),
                      widget.Sep(
                          padding    = 0,
                          linewidth  = 1,
                          foreground = '#${color.base02}',
                      ),
                      widget.Spacer( length = 16 ),
                     #widget.Prompt(
                     #    background = '#000000',
                     #    foreground = '#FFFFFF',
                     #   #fontsize   = 22,
                     #   #fontshadow = '#EEEEEE', #'#606060',
                     #),
                      widget.WindowName(
                         #fmt        = '<i>{}</i>',
                         #fontsize   = 24,
                          padding    = 8,
                          foreground = '#${color.base07}',
                         #fontshadow = '#${color.base0E}', #'#606060',
                      ),
                      widget.Chord(
                          chords_colors={
                              "launch": ("#ff0000", "#ffffff"),
                          },
                          name_transform=lambda name: name.upper(),
                      ),
                      widget.StatusNotifier(),
                      # NB: Systray is incompatible with Wayland,
                      #     consider using StatusNotifier instead.
                      widget.Systray(
                          icon_size  = 32,
                      ),
                      widget.Spacer( length = 16 ),
                      widget.Sep(
                          padding    = 0,
                          linewidth  = 1,
                          foreground = '#${color.base02}',
                      ),
                      widget.Volume(
                         emoji = True,
                      ),
                      widget.Clock(
                         #fontsize   = 24,
                          format     = "%Y-%m-%d %a %H:%M:%S ", # NOTE: trailing space is right-padding hack
                          foreground = '#${color.base04}',
                          fontshadow = '#000000', #${color.base0D}',
                          padding    = 16,
                      ),
                      # widget.QuickExit(),
                  ],
                  48,          # thickness (bar height)
                  margin       = [16, 16, 0, 16],
                  border_width = [0, 0, 1, 0],  # Draw top and bottom borders
                  border_color = ["#000000", "#000000", "#000000", "#000000"],
                  background   = ["#${color.base00}","#${color.base01}"],
              ),
              left=bar.Gap(8),
              right=bar.Gap(8),
              bottom=bar.Gap(8),
              # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
              # By default we handle these events delayed to already improve performance, however your system might still be struggling
              # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
              # x11_drag_polling_rate = 60,
          ),
      ]
      
      # Drag floating layouts.
      mouse = [
          Drag(  [mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position() ),
          Drag(  [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size() ),
          Click( [mod], "Button2", lazy.window.bring_to_front() ),
      ]
      
      dgroups_key_binder         = None
      dgroups_app_rules          = [] # type: list
      follow_mouse_focus         = False
      bring_front_click          = False
      floats_kept_above          = True
      cursor_warp                = False
      auto_fullscreen            = True
      focus_on_window_activation = "smart"
      reconfigure_screens        = True
      floating_layout            = layout.Floating(
                                      border_width  = 0,
                                      border_focus  = "#FFFFFF",
                                      border_normal = "#202020",
                                      float_rules   = [
                                          # Run the utility of `xprop` to see the wm class and name of an X client.
                                          *layout.Floating.default_float_rules,
                                          Match( wm_class = "rofi"         ), # rofi
                                          Match( wm_class = "confirmreset" ), # gitk
                                          Match( wm_class = "makebranch"   ), # gitk
                                          Match( wm_class = "maketag"      ), # gitk
                                          Match( wm_class = "ssh-askpass"  ), # ssh-askpass
                                          Match(    title = "branchdialog" ), # gitk
                                          Match(    title = "pinentry"     ), # GPG key password entry
                                      ]
                                   )
      
      # If things like steam games want to auto-minimize themselves when losing focus, should we respect this or not?
      auto_minimize = True
      
      # When using the Wayland backend, this can be used to configure input devices.
      wl_input_rules = None
      
      wmname = "LG3D"
   '';
in
{
   # This will create the qtile config file at the desired location:
   home.file.".config/qtile/config.py" = {
      text  = qtile_cfg;
      force = true;
   };

   # This will create the autostart script the qtile config will invoke:
   home.file.".config/qtile/autostart.sh" = {
      text       = autostart_sh;
      executable = true;
      force      = true;
   };
}

