{ config, pkgs, lib, ... }:
let
  secrets = import ../../secrets.nix;
in
{
  imports = [
    ./programs/vscode.nix
    ./programs/zsh.nix
    ./programs/konsole.nix
    ./programs/ghostty.nix
    ./programs/waybar.nix
    ./programs/rofi.nix
    ./programs/swaync.nix
    ./programs/neovim.nix
  ];

  home.username = secrets.username;
  home.homeDirectory = "/home/${secrets.username}";
  home.file."code/.keep".text = "";
  home.stateVersion = "25.05";

  # Save screenshot to clipboard
  xdg.configFile."spectaclerc".text = ''
    [General]
    copyImageToClipboard=true
    autoSaveImage=false
    saveAfterManualCapture=false
  '';

  # Mouse cursor
  home.pointerCursor = {
    name = "Quintom_Ink";
    package = pkgs.quintom-cursor-theme;
    size = 24;
    gtk.enable = true;
  };

  # SSH
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/${secrets.sshKeyName}";
        user = "git";
      };
    };
  };

  # Waybar
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.rofi-bind = {
    Unit = {
      Description = "Rofi keybind";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.xdg-utils}/bin/xdg-open";
      Restart = "no";
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = secrets.gitUser;
    userEmail = secrets.gitEmail;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Auto-Start Discord
  systemd.user.services.discord = {
    Unit = {
      Description = "Vesktop";
      PartOf = [ "graphical-session.target" ];
      After = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.vesktop}/bin/vesktop";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.home-manager.enable = true;
}
