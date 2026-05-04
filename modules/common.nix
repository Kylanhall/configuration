{ config, pkgs, lib, ... }:
{
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Users
  users.users.kylan = {
    isNormalUser = true;
    description = "Kylan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Shell
  programs.zsh.enable = true;
  users.users.kylan.shell = pkgs.zsh;

  # Common packages on all machines
  programs.firefox.enable = true;
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    nmap
    dig
    neofetch
    btop
    tree
    tigervnc
    dracula-theme

    # Common programs for all machines
    vscode
    discord
    thunderbird
    dotnet-sdk_10
    jetbrains.rider
    spotify
    bitwarden-desktop
    obsidian
    figma-linux
    kdePackages.kcalc
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
