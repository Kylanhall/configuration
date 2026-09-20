{ config, pkgs, lib, ... }:
let 
  secrets = import /etc/nix/secrets.nix;
in 
{
  xdg.configFile."waybar/config".text = ''
    [
      {
        "layer": "top",
        "position": "top",
        "height": 32,
        "exclusive": true,
        "spacing": 6,
        "modules-left": ["custom/launcher", "custom/weather", "mpris" ],
        "modules-center": ["clock"],
        "modules-right": [ "memory" , "network", "custom/tailscale", "pulseaudio", "tray", "custom/swaync", "custom/power" ],
        "clock": {
          "format": "{:%a %b %d  %I:%M:%S %p}",
          "tooltip-format": "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>",
          "interval": 1
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
        "memory": {
          "interval": 5,
          "format": "RAM {used:0.1f}G / {total:0.1f}G",
          "tooltip-format": "Memory: {used:0.1f}G used / {total:0.1f}G\nAvailable: {avail:0.1f}G\nUsed: {percentage}%"
        },
        "custom/swaync": {
          "tooltip": false,
          "format": "{icon}",
          "format-icons": {
            "notification": "󰂚",
            "none": "󰂚",
            "dnd-notification": "󰂛",
            "dnd-none": "󰂛",
            "inhibited-notification": "󰂚",
            "inhibited-none": "󰂚",
            "dnd-inhibited-notification": "󰂛",
            "dnd-inhibited-none": "󰂛"
          },
          "return-type": "json",
          "exec-if": "which swaync-client",
          "exec": "swaync-client -swb",
          "on-click": "swaync-client -t -sw",
          "on-click-right": "swaync-client -d -sw",
          "escape": true
        },
        "custom/tailscale": {
          "exec": "tailscale status --json | python3 -c \"import sys,json; s=json.load(sys.stdin); print('󰖂 Up' if s.get('BackendState')=='Running' else '󰖂 Down')\"",
          "interval": 10,
          "tooltip": false
        },
        "mpris": {
          "format": "{player_icon} {title} — {artist}",
          "format-paused": "{player_icon} {title} — {artist}",
          "player-icons": {
            "spotify": "",
            "default": "▶"
          },
          "status-icons": {
            "paused": "⏸"
          },
          "max-length": 40
        },
        "custom/weather": {
          "exec": "curl -s 'https://wttr.in/${secrets.weatherLocation}?format=%c+%t' | tr -d '+'",
          "interval": 1800,
          "tooltip": false
        },
        "custom/power": {
          "format": "⏻",
          "tooltip": false,
          "on-click": "wlogout"
        }
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
      color: #f8f8f2;
    }

    #custom-swaync {
      font-family: "NotoSansMono Nerd Font";
      padding: 0 12px;
      color: #cdd6f4;
    }

    #memory {
      padding: 0 10px;
    }

    #mpris, #custom-weather {
      padding: 0 12px;
      color: #f8f8f2;
    }

    window#waybar.top {
      background: #1e1f2e;
      color: #f8f8f2;
    }

    #clock, #pulseaudio, #network, #bluetooth, #tray {
      padding: 0 12px;
      color: #f8f8f2;
    }

    #clock { font-weight: 600; }
  '';
}
