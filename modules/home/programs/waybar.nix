{ config, pkgs, lib, ... }:
{
  xdg.configFile."waybar/config".text = ''
    [
      {
        "layer": "top",
        "position": "top",
        "height": 32,
        "spacing": 6,
        "modules-left": [],
        "modules-center": ["clock"],
        "modules-right": ["custom/tailscale", "pulseaudio", "network", "bluetooth", "tray"],
        "clock": {
          "format": "{:%a %b %d  %H:%M}",
          "tooltip-format": "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>"
        },
        "pulseaudio": {
          "format": "{icon} {volume}%",
          "format-muted": "󰝟",
          "format-icons": { "default": ["󰕿", "󰖀", "󰕾"] },
          "on-click": "pavucontrol"
        },
        "network": {
          "format-wifi": "󰤨 {essid}",
          "format-ethernet": "󰈀 Wired",
          "format-disconnected": "󰤭 Off"
        },
        "bluetooth": {
          "format": "󰂯",
          "format-connected": "󰂱 {device_alias}",
          "on-click": "blueman-manager"
        },
        "custom/tailscale": {
          "exec": "tailscale status --json | python3 -c \"import sys,json; s=json.load(sys.stdin); print('󰖂 Up' if s.get('BackendState')=='Running' else '󰖂 Down')\"",
          "interval": 10,
          "tooltip": false
        },
        "tray": { "spacing": 8 }
      }
    ]
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono", "Noto Sans", sans-serif;
      font-size: 13px;
      border: none;
      border-radius: 0;
      min-height: 0;
    }

    #custom-tailscale {
      padding: 0 12px;
      color: #cdd6f4;
    }

    window#waybar.top {
      background: rgba(20, 20, 30, 0.85);
      color: #cdd6f4;
      border-bottom: 1px solid rgba(255,255,255,0.08);
    }

    #clock, #pulseaudio, #network, #bluetooth, #tray {
      padding: 0 12px;
      color: #cdd6f4;
    }

    #clock { font-weight: 600; }
  '';
}