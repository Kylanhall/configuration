{ config, pkgs, lib, ... }:

{
  xdg.configFile."ghostty/config".text = ''
    font-family = JetBrains Mono
    font-size = 12
    theme = Dracula
    background-opacity = 1.0
    cursor-style = block
    mouse-hide-while-typing = true
    shell-integration = zsh
    window-padding-x = 12
    window-padding-y = 12
    macos-option-as-alt = true
  '';
}