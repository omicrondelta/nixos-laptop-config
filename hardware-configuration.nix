{ config, pkgs, ... }:

{ imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot = {
    initrd = {
      availableKernelModules = [
        "uhci_hcd"
        "ehci_pci"
        "ahci"
        "btrfs"
      ];

      luks = {
        devices = [ 
          { name   = "nix-vault";
            device = "/dev/sda4"; }
        ];
      };
    };
  };

 fileSystems = [
    { mountPoint = "/"; 
      device = "/dev/disk/by-label/nix-root";
      fsType = "btrfs";
      options = "defaults,noatime,noacl,compress=lzo,inode_cache,space_cache,autodefrag,subvol=__ROOT"; }
    { mountPoint = "/home";
      device = "/dev/disk/by-label/nix-root";
      fsType = "btrfs";
      options = "defaults,noatime,noacl,compress=lzo,inode_cache,space_cache,autodefrag,subvol=__HOME"; }
    { mountPoint = "/boot";
      device = "/dev/disk/by-label/nix-boot";
      fsType = "xfs"; }
  ];

  swapDevices = [
    { device = "/dev/disk/by-label/nix-swap"; }
  ];

  nix = {
    maxJobs = 2;
  };
}

