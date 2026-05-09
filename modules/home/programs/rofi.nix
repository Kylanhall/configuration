{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    rofi-wayland
  ];

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,filebrowser";
      show-icons: true;
      drun-display-format: "{name}";
      location: 0;
      disable-history: false;
      hide-scrollbar: true;
      display-drun: "󰍉 Apps";
      display-filebrowser: "󰉋 Files";
      sidebar-mode: true;
    }

    @theme "dracula"
  '';

  xdg.configFile."rofi/themes/dracula.rasi".text = ''
    * {
      bg:       #282a36;
      bg-alt:   #1e1f29;
      fg:       #f8f8f2;
      fg-alt:   #6272a4;
      accent:   #bd93f9;
      urgent:   #ff5555;

      background-color: transparent;
      text-color:       @fg;
    }

    window {
      background-color: @bg;
      border:           2px;
      border-color:     @accent;
      border-radius:    12px;
      width:            600px;
      padding:          12px;
    }

    mainbox {
      background-color: transparent;
      children:         [ inputbar, message, listview, mode-switcher ];
      spacing:          8px;
    }

    inputbar {
      background-color: @bg-alt;
      border-radius:    8px;
      padding:          10px 14px;
      children:         [ prompt, entry ];
      spacing:          8px;
    }

    prompt {
      text-color: @accent;
      font:       "JetBrains Mono 13";
    }

    entry {
      placeholder:      "Search...";
      placeholder-color: @fg-alt;
      font:             "JetBrains Mono 13";
    }

    listview {
      background-color: transparent;
      lines:            8;
      scrollbar:        false;
      spacing:          4px;
    }

    element {
      background-color: transparent;
      border-radius:    8px;
      padding:          8px 10px;
      spacing:          10px;
      children:         [ element-icon, element-text ];
    }

    element selected {
      background-color: @accent;
      text-color:       @bg;
    }

    element-icon {
      size:             24px;
    }

    element-text {
      font:             "JetBrains Mono 13";
      vertical-align:   0.5;
    }

    mode-switcher {
      background-color: @bg-alt;
      border-radius:    8px;
      padding:          4px;
      spacing:          4px;
    }

    button {
      background-color: transparent;
      border-radius:    6px;
      padding:          6px 12px;
      text-color:       @fg-alt;
    }

    button selected {
      background-color: @accent;
      text-color:       @bg;
    }
  '';
}