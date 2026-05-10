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
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    # CLI Tools
    wget
    git
    curl
    nmap
    dig
    neofetch
    btop
    tree
    tmux
    samba

    # Programming Languages
    nixd
    go
    nodejs_22
    nodePackages.typescript
    nodePackages.ts-node
    python3
    python3Packages.pip
    dotnet-sdk_10

    # GUI Applications
    vscode
    vesktop
    thunderbird
    jetbrains.rider
    dbeaver-bin
    tigervnc
    spotify
    bitwarden-desktop
    obsidian
    figma-linux
    qalculate-gtk
    filezilla
    google-chrome
    ghostty
    bolt-launcher
    pavucontrol
    libnotify
    kdePackages.kdenetwork-filesharing
    playerctl
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  services.samba-wsdd.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
