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
      "${secrets.github1}" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/${secrets.sshKeyName}";
        identitiesOnly = true;
      };
      "${secrets.github2}" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/${secrets.sshKeyName2}";
        identitiesOnly = true;
      };
      "* !${secrets.github1} !${secrets.github2}" = {
        identityFile = "~/.ssh/${secrets.sshKeyName}";
        user = "${secrets.username}";
        identitiesOnly = true;
      };
    };
  };

  # Git
  programs.git = {
    enable = true;

    userName = secrets.git1User;
    userEmail = secrets.git1Email;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };

    includes = [
      {
        condition = "gitdir:/home/${secrets.username}/code/work/";
        contents = {
          user = {
            name = secrets.git1User;
            email = secrets.git1Email;
          };

          url = {
            "git@${secrets.github1}:".insteadOf = "git@github.com:";
          };
        };
      }
       {
         condition = "gitdir:/home/${secrets.username}/code/misc/";
         contents = {
           user = {
             name = secrets.git2User;
             email = secrets.git2Email;
           };

           url = {
             "git@${secrets.github2}:".insteadOf = "git@github.com:";
           };
         };
       }
    ];
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
