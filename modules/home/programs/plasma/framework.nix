{ config, pkgs, lib, ... }:
{
  programs.plasma = {
    panels = [
      {
        location = "bottom";
        alignment = "center";
        floating = true;
        height = 42;
        lengthMode = "fit";
        hiding = "autohide";
        widgets = [
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:google-chrome.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:bitwarden.desktop"
                  "applications:thunderbird.desktop"
                  "applications:org.kde.kcalc.desktop"
                  "applications:code.desktop"
                  "applications:rider.desktop"
                  "applications:dbeaver.desktop"
                  "applications:figma-linux.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:obsidian.desktop"
                  "applications:spotify.desktop"
                  "applications:discord.desktop"
                ];
              };
            };
          }
        ];
      }
    ];
  };
}