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
    fastfetch
    btop
    tree
    tmux
    samba
    speedtest-go
    cifs-utils

    # Programming Languages
    nixd
    go
    nodejs_22
    nodePackages.typescript
    nodePackages.ts-node
    python3
    python3Packages.pip
    jdk17
    jdk21

    # Fucking Microsoft...
    # Csharp-ls Needs .NET 9, .NET 10 is current, .NET 8 is LTS.... FU Microsoft, this is stupid
    (dotnetCorePackages.combinePackages [
      dotnet-sdk_10
      dotnet-sdk_9
      dotnet-sdk_8
    ])

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
    obs-studio
    libreoffice-qt
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "corefonts"
    ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    corefonts
  ];

  services.samba-wsdd.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
