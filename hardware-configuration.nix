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
      ];

      checkJournalingFS = false;

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
      device = "/dev/disk/by-uuid/fe1c7711-3de1-4e7a-8e3d-aa984fc3d54e";
      fsType = "btrfs";
      options = "defaults,noatime,noacl,compress=lzo,inode_cache,space_cache,autodefrag,subvol=__ROOT"; }
    { mountPoint = "/home";
      device = "/dev/disk/by-uuid/fe1c7711-3de1-4e7a-8e3d-aa984fc3d54e";
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

    gc = {
      automatic = true;
      dates = "12:00";
      options = "-d";
    };
  };
}

