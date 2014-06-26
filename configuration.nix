{ config, pkgs, ... }: 

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      chromium = {
        enableAdobeFlash = true;
      };
    };
  };

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

  boot.initrd.checkJournalingFS = false;

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

    systemPackages = with pkgs; [
      oxygen_gtk
      smartmontools
      kde4.kdemultimedia
      kde4.kdeaccessibility
      kde4.kdeadmin
      kde4.kdeartwork
      kde4.kdebindings
      kde4.kdeedu
      kde4.kdegames
      kde4.kdegraphics
      kde4.kdelibs
      kde4.kdenetwork
      kde4.kdepim
      kde4.kdesdk
      kde4.kdetoys
      kde4.kdeutils
    ];
  };

  services = {
    nixosManual = {
      enable = true;
      showManual = true;
       ttyNumber = "2";
    };

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

  fonts = {
    enableFontDir = true;
    fonts = with pkgs ; [
       liberation_ttf
       ttf_bitstream_vera
       dejavu_fonts
       terminus_font
       bakoma_ttf
    ];
  };

  ## Testing ##
  services.mysql.package = pkgs.mariadb;
  services.mysql.enable = true;

  hardware.pulseaudio.enable = true;
  services.acpid.enable = true;

}
