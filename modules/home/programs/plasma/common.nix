{ config, pkgs, lib, ... }:
{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "spectacle"."RectangularRegionScreenshot" = ["Ctrl+Shift+4" "Meta+Shift+Print"];
      "krunner.desktop"."_launch" = [];
      kwin = {
        "Switch to Desktop 1" = "Alt+1";
        "Switch to Desktop 2" = "Alt+2";
        "Switch to Desktop 3" = "Alt+3";
        "Switch to Desktop 4" = "Alt+4";

        "Window to Desktop 1" = "Alt+Shift+1";
        "Window to Desktop 2" = "Alt+Shift+2";
        "Window to Desktop 3" = "Alt+Shift+3";
        "Window to Desktop 4" = "Alt+Shift+4";
      };
    };
    configFile = {
      kwinrc.Desktops.Number = 4;
    };
    workspace = {
      wallpaper = "${config.home.homeDirectory}/.config/nixos/wallpapers/sonic.png";
      colorScheme = "DraculaSolid";
      cursor = {
        theme = "Quintom_Ink";
        size = 24;
      };
    };
    hotkeys.commands."rofi-launch" = {
      name = "Launch Rofi";
      key = "Alt+Space";
      command = "rofi -show drun";
    };
    configFile."powermanagementprofilesrc"."AC"."brightness".value = "100";
    configFile."powermanagementprofilesrc"."Battery"."brightness".value = "100";
    configFile."krunnerrc"."General"."activateWhenTypingOnDesktop".value = "false";
  };

  # Dark mode
  gtk.enable = true;
  gtk.theme = {
    name = "Dracula";
    package = pkgs.dracula-theme;
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };
}
