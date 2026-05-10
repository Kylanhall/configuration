{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
    libnotify
  ];

  systemd.user.services.swaync = {
    Unit = {
      Description = "SwayNC notification daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync -s ${config.xdg.configHome}/swaync/style.css";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };

  xdg.configFile."swaync/config.json".text = builtins.toJSON {
    positionX = "right";
    positionY = "top";
    layer = "overlay";
    control-center-margin-top = 8;
    control-center-margin-bottom = 8;
    control-center-margin-right = 8;
    control-center-margin-left = 0;
    notification-icon-size = 48;
    notification-body-image-height = 100;
    notification-body-image-width = 200;
    timeout = 5;
    timeout-low = 2;
    timeout-critical = 0;
    fit-to-screen = false;
    control-center-width = 350;
    control-center-height = 600;
    notification-window-width = 350;
    animation-type = "slide-in";
    animation-duration = 300;
  };

    xdg.configFile."swaync/style.css".text = ''
      * {
        font-family: "JetBrains Mono", monospace;
        font-size: 13px;
      }

      .control-center {
        background: #282a36;
        border-radius: 12px;
        border: 1px solid #bd93f9;
        padding: 8px;
        margin: 8px;
      }

      .notification {
        background: #1e1f29;
        border-radius: 10px;
        border: 1px solid #44475a;
        padding: 10px;
        margin: 4px;
      }

      .notification:hover {
        background: #44475a;
      }

      .notification-summary {
        color: #f8f8f2;
        font-weight: bold;
        font-size: 13px;
      }

      .notification-body {
        color: #cdd6f4;
        font-size: 12px;
      }

      .notification-action {
        background: #44475a;
        border-radius: 6px;
        color: #f8f8f2;
        padding: 4px 8px;
        margin: 2px;
      }

      .notification-action:hover {
        background: #bd93f9;
        color: #282a36;
      }

      .close-button {
        background: #ff5555;
        border-radius: 50%;
        color: #f8f8f2;
        min-width: 20px;
        min-height: 20px;
      }

      .close-button:hover {
        background: #ff79c6;
      }

      .do-not-disturb-button {
        background: #44475a;
        border-radius: 8px;
        color: #f8f8f2;
        padding: 6px 12px;
        margin: 4px;
      }

      .do-not-disturb-button:hover {
        background: #bd93f9;
        color: #282a36;
      }

      .clear-all-button {
        background: #44475a;
        border-radius: 8px;
        color: #f8f8f2;
        padding: 6px 12px;
        margin: 4px;
      }

      .clear-all-button:hover {
        background: #ff5555;
        color: #f8f8f2;
      }
  '';
}