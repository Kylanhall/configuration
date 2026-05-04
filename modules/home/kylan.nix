{ config, pkgs, lib, ... }:
{
  imports = [
    ./programs/vscode.nix
    ./programs/zsh.nix
    ./programs/konsole.nix
  ];

  home.username = "kylan";
  home.homeDirectory = "/home/kylan";
  home.file."code/.keep".text = "";
  home.stateVersion = "24.11";

  # SSH
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/kylan";
        user = "git";
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "kylanhall";
    userEmail = "git@kylan.net";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Auto-Start Discord
  systemd.user.services.discord = {
    Unit = {
      Description = "Discord";
      After = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.discord}/bin/discord";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.home-manager.enable = true;
}
