{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  networking.hostName = "Topaz";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Graphics
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  hardware.graphics.enable32Bit = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Power Settings
  powerManagement.enable = true;
  services.logind.lidSwitch = "ignore";
  systemd.sleep.extraConfig = ''
    AllowHibernation=no
    AllowSuspend=yes
  '';

  # Programs
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
  programs.steam.enable = true;

  system.stateVersion = "24.11";
}
