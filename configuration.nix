{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      grub = {
        version = 2;
        device = "/dev/sda";
        enable = true;
      };
    };
    
    kernelPackages = pkgs.linuxPackages_3_15;

    kernelParams = [
      "quiet"
    ];
  };

  networking = {
    hostName = "tartarus";
    domain = "nixos.laptop";
    wireless = {
      enable = true;
    };
  };

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  
  time = {
    timeZone = "America/Edmonton";
  };

  environment = {
    shellAliases = {
      ll     = "ls -l";
      ls     = "ls --color=auto";
      la     = "ls -a";
      lal    = "ls -al";
      vimx   = "gvim";
      emacs  = "emacs -nw";
      emacsx = "emacs";
    };

    shellInit = ''
      export GTK_PATH=$GTKPATH:${pkgs.oxygen_gtk}/lib/gtk-2.0
      export GTK2_RC_FILES=$GTK2_RC_FILES:${pkgs.oxygen_gtk}/share/themes/oxygen-gtk/gtk-2.0/gtkrc
    '';

    systemPackages = [
      pkgs.oxygen_gtk
    ];
  };

  services = {
    openssh = {
      enable = true;
    };

    printing = {
      enable = true;
    };

    xserver = {
      displayManager = {
        kdm = {
          enable = true;
        };
      };

      desktopManager = {
        xterm = {
          enable = false;
        };
        kde4 = {
          enable = true;
        };
      };

      synaptics = {
        twoFingerScroll = true;
        enable = true;
      };
      layout = "us";
      enable = true; 
    };

    dbus = {
      enable = true;
    };

    redshift = {
      latitude = "55.17";
      longitude = "-118.80";
      temperature = {
        day = 5500;
        night = 3400;
      };
      enable = true;
    };
  };

  programs = {
    bash = {
      enableCompletion = true;
    };
  };
}
