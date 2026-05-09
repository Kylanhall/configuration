{ config, pkgs, lib, ... }:

{
  xdg.configFile."ghostty/config".text = ''
    font-family = JetBrains Mono
    font-size = 10
    theme = Dracula
    background-opacity = 1.0
    cursor-style = block
    mouse-hide-while-typing = true
    shell-integration = zsh
    window-padding-x = 6
    window-padding-y = 6
    macos-option-as-alt = true
    term = xterm-256color
  '';
}