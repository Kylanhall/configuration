{ pkgs, ... }:

{
  boot.supportedFilesystems = [ "cifs" ];

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  fileSystems."/nas/Plex" = {
    device = "//192.168.1.59/Plex";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/smb-credentials"
      "vers=3.0"
      "uid=1000"
      "gid=100"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/nas/Personal" = {
    device = "//192.168.1.59/personal_folder";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/smb-credentials"
      "vers=3.0"
      "uid=1000"
      "gid=100"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/nas/Kycai" = {
    device = "//192.168.1.59/shared";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/smb-credentials"
      "vers=3.0"
      "uid=1000"
      "gid=100"
      "nofail"
      "x-systemd.automount"
    ];
  };
}
