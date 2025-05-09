# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4f206d9c-89c1-4441-8b8f-f6e2f3e22b7d";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" "compress=zstd" "ssd" "space_cache=v2" "discard=async" ];
    };

  boot.initrd.luks.devices."main".device = "/dev/disk/by-uuid/fcd14642-55c7-4b1d-b409-9b177e6809df";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4f206d9c-89c1-4441-8b8f-f6e2f3e22b7d";
      fsType = "btrfs";
      options = [ "subvol=@home" "noatime" "compress=zstd" "ssd" "space_cache=v2" "discard=async" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/4f206d9c-89c1-4441-8b8f-f6e2f3e22b7d";
      fsType = "btrfs";
      options = [ "subvol=@nix" "noatime" "compress=zstd" "ssd" "space_cache=v2" "discard=async" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/4f206d9c-89c1-4441-8b8f-f6e2f3e22b7d";
      fsType = "btrfs";
      options = [ "subvol=@persist" "noatime" "compress=zstd" "ssd" "space_cache=v2" "discard=async" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/4f206d9c-89c1-4441-8b8f-f6e2f3e22b7d";
      fsType = "btrfs";
      options = [ "subvol=@log" "noatime" "compress=zstd" "ssd" "space_cache=v2" "discard=async" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D86B-E054";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  virtualisation.virtualbox.guest.enable = true;
}
