{ config, pkgs, lib, ... }:
let 
  commonLaunchers = import ./common-dock.nix;
in
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
                launchers = commonLaunchers;
              };
            };
          }
        ];
      }
    ];
  };
}