{ config, pkgs, lib, ... }:
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
      rebuild = ''find ~ -name "*.backup" -delete && sudo nixos-rebuild switch --flake ~/.config/nixos#topaz'';
      speedtest = "speedtest-go";
      neofetch = "fastfetch";
      misc = "cd ~/code/misc";
      work = "cd ~/code/work";
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
