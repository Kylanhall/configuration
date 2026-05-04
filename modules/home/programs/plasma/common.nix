{ config, pkgs, lib, ... }:
{
  programs.plasma = {
    enable = true;
    workspace = {
      wallpaper = "${config.home.homeDirectory}/.config/nixos/wallpapers/sonic.png";
      colorScheme = "BreezeDark";
    };
    panels = [
      {
        location = "top";
        height = 28;
        widgets = [
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance = {
              showDate = "true";
              dateFormat = "shortDate";
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.lock_logout"
        ];
      }
    ];
  };

  # Dark mode
  gtk.enable = true;
  gtk.theme.name = "Breeze-Dark";
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };
}