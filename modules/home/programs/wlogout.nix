{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wlogout
  ];

  xdg.configFile."wlogout/layout".text = ''
      {
        "label": "lock",
        "action": "loginctl lock-session",
        "text": "Lock",
        "keybind": "l"
      },
      {
        "label": "logout",
        "action": "loginctl terminate-session $XDG_SESSION_ID",
        "text": "Logout",
        "keybind": "e"
      },
      {
        "label": "reboot",
        "action": "systemctl reboot",
        "text": "Restart",
        "keybind": "r"
      },
      {
        "label": "shutdown",
        "action": "systemctl poweroff",
        "text": "Shutdown",
        "keybind": "s"
      }
  '';

  xdg.configFile."wlogout/style.css".text = ''
    window {
      background-color: rgba(30, 31, 46, 0.60);
    }

    button {
      border: none;
      border-radius: 12px;

      background-color: #292a3a;
      color: #f8f8f2;

      margin: 8px;
      padding: 20px;

      font-size: 18px;
    }

    button:hover {
      background-color: #3b3c50;
    }

    button:focus {
      background-color: #45475a;
    }
  '';
}
