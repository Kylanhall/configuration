{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/nas.nix
  ];

  networking.hostName = "Topaz";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.dbus.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Graphics
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb.options = "ctrl:nocaps";
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  hardware.graphics.enable32Bit = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.common.default = "kde";
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.pulseaudio.enable = false;

  # Mouse Acceleration
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "-0.3";
    };
  };

  # Power Settings
  powerManagement.enable = true;
  systemd.sleep.extraConfig = ''
    AllowHibernation=no
    AllowSuspend=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
  services.logind = {
    lidSwitch = "ignore";
    extraConfig = ''
      HandleSuspendKey=ignore
      HandleHibernateKey=ignore
      HandleLidSwitch=ignore
      IdleAction=ignore
    '';
  };

  # Programs
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
  programs.steam.enable = true;

  system.stateVersion = "25.05";
}
