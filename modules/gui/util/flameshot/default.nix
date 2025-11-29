{ config, pkgs, ... }:
let
   color = config.lib.stylix.colors;
in
{
   services.flameshot = {
      enable   = true;
      settings = {
         General = {
            # Draw settings:
            drawThickness            = 6;
            drawFontSize             = 12;
            drawRectangleSize        = 4; # Corner rounding?
            drawPixelateSize         = 2;
            drawMarkerSize           = 5;
            drawCircleCounterSize    = 1; # ??
            # UI colors:
            uiColor                  = "#${color.base06}"; #7
            contrastUiColor          = "#${color.base09}";
            drawColor                = "#FFBB66"; # TODO
            disabledTrayIcon         = true;
            contrastOpacity          = 190; # [0~255]; opacity of area outside selection
            # Additional UI elements:
            showHelp                 = false;
            showSidePanelButton      = false;
            showStartupLaunchMessage = false;
            # Notifications:
            showAbortNotification    = true; # TODO
            showDesktopNotification  = true; # TODO
            # Save settings:
            filenamePattern          = "Screenshot_%F_%H꞉%M꞉%S";
            saveAsFileExtension      = ".png";
            savePath                 = "${config.home.homeDirectory}/Screenshots";
            savePathFixed            = true;
            
            # Maybe if Wayland: useGrimAdapter, disabledGrimWarning
            # TODO(undecided): autoCloseIdleDaemon, keepOpenAppLauncher, startupLaunch, saveAfterCopy, copyPathAfterSave, copyAndCloseAfterUpload, antialiasingPinZoom, useJpgForClipboard, uploadWithoutConfirmation, predefinedColorPaletteLarge, jpegQuality, etc
         };
         shortcuts = {
            TYPE_ARROW               = "A";
            TYPE_CANCEL              = "Ctrl+Backspace";
            TYPE_CIRCLE              = "C";
            TYPE_CIRCLECOUNT         = "";
            TYPE_COMMIT_CURRENT_TOOL = "Ctrl+Return";
            TYPE_COPY                = "Ctrl+C";
            TYPE_DRAWER              = "D";
            TYPE_EXIT                = "Ctrl+Q";
            TYPE_IMAGEUPLOADER       = "Return";
            TYPE_MARKER              = "M";
            TYPE_MOVESELECTION       = "Ctrl+M";
            TYPE_MOVE_DOWN           = "Down";
            TYPE_MOVE_LEFT           = "Left";
            TYPE_MOVE_RIGHT          = "Right";
            TYPE_MOVE_UP             = "Up";
            TYPE_OPEN_APP            = "Ctrl+O";
            TYPE_PENCIL              = "P";
            TYPE_PIN                 = "";
            TYPE_PIXELATE            = "B";
            TYPE_RECTANGLE           = "R";
            TYPE_REDO                = "Ctrl+Shift+Z";
            TYPE_RESIZE_DOWN         = "Shift+Down";
            TYPE_RESIZE_LEFT         = "Shift+Left";
            TYPE_RESIZE_RIGHT        = "Shift+Right";
            TYPE_RESIZE_UP           = "Shift+Up";
            TYPE_SYM_RESIZE_DOWN     = "Ctrl+Shift+Down";
            TYPE_SYM_RESIZE_LEFT     = "Ctrl+Shift+Left";
            TYPE_SYM_RESIZE_RIGHT    = "Ctrl+Shift+Right";
            TYPE_SYM_RESIZE_UP       = "Ctrl+Shift+Up";
            TYPE_SAVE                = "Ctrl+S";
            TYPE_SELECTION           = "S";
            TYPE_SELECT_ALL          = "Ctrl+A";
            TYPE_TEXT                = "T";
            TYPE_TOGGLE_PANEL        = "Space";
            TYPE_GRAB_COLOR          = "G";
            TYPE_UNDO                = "Ctrl+Z";
         };
      };
   };
}

