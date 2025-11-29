{ config, pkgs, lib, ... }:
let
   color = config.lib.stylix.colors;
in
{
   programs.starship = {
      enable                = true;
      enableFishIntegration = true;
      
      settings = {
         add_newline     = false;
         scan_timeout    = 30;
         command_timeout = 500;

         format = lib.concatStrings [
           #"$fill$line_break"

           #" [━━](bold fg:#${color.base09})"
            " [... action took](dimmed fg:#${color.base04}) "
            "$cmd_duration"
            "[and finished at](dimmed fg:#${color.base04}) "
            "$time"
            "$status"
            "$battery"
            "$line_break"
            "$line_break"
            "$line_break"

           #"$fill$line_break"

            " [▐](fg:#${color.base09}) "
            "\${custom.bar_begin}"
            "$sudo"
            "$username"
            "[@](dimmed fg:#${color.base04} bg:#${color.base01})"
            "$hostname"
            "\${custom.word_in}"
            "$directory"
            "\${custom.bar_end}"
            "$os"
            "$shell"
            "$jobs "
            "$git_branch"
            "$git_state"
            "$git_commit"
            "$git_metrics"
            "$git_status"
            "$cmake"
            "$c"
            "$lua"
            "$rust"
            "$zig"
            "$nix_shell"
            "$rust"
            "$package"
            "$line_break"
            
            " [▐](fg:#${color.base09})  $character"
         ];

        #battery = {}; # TODO: Add if needed.

        #c = {}; # TODO

        #cpp = {}; # TODO
         
         character = {
            format                    = "$symbol ";
            success_symbol            = "[❯](bold green)";
            error_symbol              = "[❯](bold green)";
            vimcmd_symbol             = "[❮](bold magenta)";
            vimcmd_replace_one_symbol = "[❮](bold purple)";
            vimcmd_replace_symbol     = "[❮](bold purple)";
            vimcmd_visual_symbol      = "[❮](bold white)";
            disabled                  = false;
         };

         cmd_duration = {
            format               = "[$duration]($style) ";
            min_time             = 0; # ms
            show_milliseconds    = true;
            style                = "yellow";
            show_notifications   = true;
            min_time_to_notify   = 30000; # ms
            notification_timeout = 8000;  # ms
            disabled             = false;
         };

         custom = {
            bar_begin = {
               format   = "[]($style)";
               command  = "";
               style    = "fg:#${color.base01}";
               when     = true;
               disabled = false;
            };

            bar_end = {
               format   = "[ ]($style)";
               command  = "";
               style    = "fg:#${color.base01}";
               when     = true;
               disabled = false;
            };

            word_in = {
               format   = "[in ]($style)";
               command  = "";
               style    = "dimmed fg:#${color.base04} bg:#${color.base01}";
               when     = true; # TODO: Tie to width?
               disabled = false;
            };
         };

         directory = {
            format                    = "[$path]($style)[$read_only]($read_only_style)";
            style                     = "fg:#${color.base05} bg:#${color.base01}";
            read_only                 = " ";
            read_only_style           = "fg:#FFDD88 bg:#${color.base01}";
            truncation_length         = 3;
            truncate_to_repo          = true;
            truncation_symbol         = "…/";
            before_repo_root_style    = "fg:#${color.base05} bg:#${color.base01}";
            repo_root_style           = "bold magenta bg:#${color.base01}";
            repo_root_format          = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style)";
            home_symbol               = "~";
            use_os_path_sep           = true;
           #substitutions             = ??;
            fish_style_pwd_dir_length = 0;
            use_logical_path          = true;
         };

         fill = {
            symbol   = "━";
            style    = "fg:#${color.base01}";
            disabled = false;
         };

         git_branch = {
            format             = "on [$symbol$branch(:$remote_branch)]($style) ";
            always_show_remote = false;
            symbol             = " ";
            style              = "bold purple";
            truncation_length  = 69420;
            truncation_symbol  = "…";
            only_attached      = false;
            ignore_branches    = [];
           #ignore_bare_repo   = false;
            disabled           = false;
         };

         git_commit = {
            format             = "[\($hash$tag\)]($style) ";
            commit_hash_length = 8;
            style              = "bold green";
            only_detached      = true;
            tag_disabled       = true;
            tag_max_candidates = 0;
            tag_symbol         = " ";
            disabled           = false;
         };

         git_state = {
            format       = "\([$state( $progress_current/$progress_total)]($style)\) ";
            rebase       = "REBASING";
            merge        = "MERGING";
            revert       = "REVERTING";
            cherry_pick  = "CHERRY-PICKING";
            bisect       = "BISECTING";
            am           = "AM";
            am_or_rebase = "AM/REBASE";
            style        = "bold yellow";
            disabled     = false;
         };

         git_metrics = {
            format             = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
            added_style        = "bold green";
            deleted_style      = "bold red";
            only_nonzero_diffs = true;
            ignore_submodules  = false;
            disabled           = false;
         };

         git_status = {
            format             = "[$all_status$ahead_behind]($style)";
            conflicted         = "=";
            ahead              = "⇡";
            behind             = "⇣";
            diverged           = "⇕";
            up_to_date         = "✓";
            untracked          = "?";
            stashed            = "\$";
            modified           = "!";
            staged             = "+"; # "[++\($count\)](green)";
            renamed            = "»";
            deleted            = "✘";
            typechanged        = "";
            style              = "bold red";
            ignore_submodules  = false;
           #windows_starship   = ??;
            use_git_executable = false;
            disabled           = false;
         };

         hostname = {
            format          = "[$ssh_symbol$hostname ]($style)";
            ssh_only        = false;
            ssh_symbol      = "󰣀 "; #"🌐 ";
            trim_at         = ".";
            detect_env_vars = [];
            style           = "fg:#${color.base04} bg:#${color.base01}";
            aliases         = {};
            disabled        = false;
         };

         jobs = {
            format           = "[$symbol$number]($style)";
            symbol_threshold = 1;
            number_threshold = 2;
            symbol           = " "; # 󰖵
            style            = "fg:#${color.base0A}";
            disabled         = false;
         };

         line_break = {
            disabled = false;
         };

         localip = {
            format   = "[$localipv4]($style) ";
            ssh_only = true;
            style    = "bold yellow";
            disabled = false;
         };

        #memory_usage = {}; # NOTE: Not much point in using this...

         odin = {}; # NOTE: Configure if I ever use Odin...

         os = {
            format   = "[$symbol]($style)";
            style    = "fg:#${color.base03}";
            symbols  = {
               AIX              = "➿ ";
               Alpaquita        = "🔔 ";
               AlmaLinux        = "💠 ";
               Alpine           = "🏔️ ";
               Amazon           = "🙂 ";
               Android          = "🤖 ";
              #AOSC             = "🐱 ";
               Arch             = "🎗️ ";
               Artix            = "🎗️ ";
               Bluefin          = "🐟 ";
               CachyOS          = "🎗️ ";
               CentOS           = "💠 ";
               Debian           = "🌀 ";
               DragonFly        = "🐉 ";
               Emscripten       = "🔗 ";
               EndeavourOS      = "🚀 ";
               Fedora           = "🎩 ";
               FreeBSD          = "😈 ";
               Garuda           = "🦅 ";
               Gentoo           = "🗜️ ";
               HardenedBSD      = "🛡️ ";
               Illumos          = "🐦 ";
               Kali             = "🐉 ";
               Linux            = "🐧 ";
               Mabox            = "📦 ";
               Macos            = "🍎 ";
               Manjaro          = "🥭 ";
               Mariner          = "🌊 ";
               MidnightBSD      = "🌘 ";
               Mint             = "🌿 ";
               NetBSD           = "🚩 ";
               NixOS            = "[ ](bold blue)"; #  "❄️ ";
               Nobara           = "🎩 ";
               OpenBSD          = "🐡 ";
               OpenCloudOS      = "☁️ ";
               openEuler        = "🦉 ";
               openSUSE         = "🦎 ";
               OracleLinux      = "🦴 ";
               Pop              = "🍭 ";
               Raspbian         = "🍓 ";
               Redhat           = "🎩 ";
               RedHatEnterprise = "🎩 ";
               RockyLinux       = "💠 ";
               Redox            = "🧪 ";
               Solus            = "⛵ ";
               SUSE             = "🦎 ";
               Ubuntu           = "🎯 ";
               Ultramarine      = "🔷 ";
               Unknown          = "❓ ";
               Uos              = "🐲 ";
               Void             = "  ";
               Windows          = "🪟 ";
            };
            disabled = false;
         };

         package = {
            format          = "is [$symbol$version]($style) ";
            symbol          = " "; #"📦 ";
            version_format  = "v\${raw}";
            style           = "bold 200";
            display_private = false;
            disabled        = false;
         };

         shell = {
            format               = "[$indicator]($style)";
            bash_indicator       = "󱆃 ";
            fish_indicator       = "[ ](cyan)"; #"🐟"; #"fish";
            zsh_indicator        = "󰰷 ";
            powershell_indicator = " ";
            ion_indicator        = " ";
            elvish_indicator     = " ";
            tcsh_indicator       = "TCSH";
            xonsh_indicator      = "🐚 ";
            cmd_indicator        = " ";
            nu_indicator         = "nu>";
            unknown_indicator    = "";
            style                = "fg:#${color.base03}";
            disabled             = false;
         };

         shlvl = {}; # NOTE: Ignoring this for now...

         status = {
            format                = "[$symbol$common_meaning$signal_name$maybe_int]($style)";
            symbol                = "[ ](bold red)"; # 
            success_symbol        = "[ ](bold green)";
            not_executable_symbol = "[ ](bold red)";
            not_found_symbol      = "[󱈍 ](bold red)";
            sigint_symbol         = "[󰟾 ](bold red)";
            signal_symbol         = "[ ](bold orange)";
            style                 = "bold white";
            recognize_signal_code = true;
            map_symbol            = true;
            pipestatus            = false;
            pipestatus_separator  = "|";
            pipestatus_format     = "$pipestatus => [$symbol$common_meaning$signal_name$maybe_int]($style)";
           #pipestatus_segment_format = ??;
            disabled              = false;
         };

         sudo = {
            format        = "[$symbol]($style)";
            symbol        = "󰆥 ";
            style         = "bold fg:#${color.base0A} bg:#${color.base01}";
            allow_windows = false;
            disabled      = false;
         };

         time = {
            format          = "[$time]($style) ";
            use_12hr        = false;
            time_format     = "%T";
            style           = "dimmed fg:#${color.base06}";
            utc_time_offset = "local";
            time_range      = "-";
            disabled        = false;
         };
         
         username = {
            format          = "[$user]($style)";
            style_user      = "bold fg:#${color.base04} bg:#${color.base01}";
            style_root      = "bold yellow";
            detect_env_vars = [];
            show_always     = true;
            aliases         = {};
            disabled        = false;
         };







         cmake = {
            format            = "[─](fg:#${color.base03}) [$symbol($version)]($style) ";
            version_format    = "v\${raw}";
            symbol            = " ";
            detect_extensions = [];
            detect_files      = [ "CMakeLists.txt" "CMakeCache.txt" ];
            detect_folders    = [];
            style             = "bg:#FFFFFF fg:#000000";
            disabled          = false;
         };

         lua = {
            format            = "[─](fg:#${color.base03}) [$symbol($version)]($style) ";
            version_format    = "v\${raw}";
            symbol            = " "; #"🌙 ";
            detect_extensions = ["lua"];
            detect_files      = [".lua-version"];
            detect_folders    = ["lua"];
            style             = "bold blue";
            lua_binary        = "lua";
            disabled          = false;
         };

         nix_shell = {
            format          = "[─](fg:#${color.base03}) [$symbol$state $name]($style)";
            symbol          = " "; #❄️ ";
            style           = "bold blue";
            impure_msg      = "impure";
            pure_msg        = "pure";
            unknown_msg     = "???";
            heuristic       = false;
            disabled        = false;
         };

         rust = {
            format            = "[─](fg:#${color.base03}) [$symbol($version)]($style) ";
            version_format    = "v\${raw}";
            symbol            = "󱘗 "; #"🦀 ";
            detect_extensions = ["rs"];
            detect_files      = ["Cargo.toml"];
            detect_folders    = [];
            style             = "bold red";
            disabled          = false;
         };

         zig = {
            format            = "[─](fg:#${color.base03}) [$symbol($version)]($style) ";
            version_format    = "v\${raw}";
            symbol            = " "; #"⚡️ ";
            style             = "bold yellow";
            detect_extensions = ["zig"];
            detect_files      = [];
            detect_folders    = [];
            disabled          = false;
         };

         # TODO: Add custom commands if needed.
      };
   };
}

