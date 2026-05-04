{ config, pkgs, ... }:
{
  # ZSH Shell
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" ];
    };
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#$(hostname)";
    };
    plugins = [
        {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
    ];
  };
}