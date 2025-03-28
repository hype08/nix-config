{ config, pkgs, ... }:
let
  inherit (import ./variables.nix) keyboardLayout;
in
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "btusb" ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      bat
      bluez
      bluez-tools
      blueman
      curl
      dunst
      fd
      git
      htop
      hyprpaper
      lazygit
      neovim
      networkmanagerapplet
      obsidian
      pavucontrol
      playerctl
      ripgrep
      rofi-wayland
      slack
      spotify
      tree
      unzip
      vim
      wezterm
      wget
      whatsapp-for-linux
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      zip
      zoxide
    ];
  };

  fonts.packages = with pkgs; [
    font-awesome
    material-icons
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  hardware = {
    pulseaudio.enable = false;
    keyboard.qmk.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  i18n.defaultLocale = "en_CA.UTF-8";

  imports = [ 
    ./hardware.nix
    ./users.nix
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf.symbol = " ";
        c.symbol = " ";
        directory.read_only = " 󰌾";
        docker_context.symbol = " ";
        fossil_branch.symbol = " ";
        git_branch.symbol = " ";
        golang.symbol = " ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";
        package.symbol = "󰏗 ";
        python.symbol = " ";
        rust.symbol = " ";
        swift.symbol = " ";
        zig.symbol = " ";
      };
    };
    zsh.enable = true;
    mosh.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    printing.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  stylix = {
    base16Scheme = {
      base00 = "232136";
      base01 = "2a273f";
      base02 = "393552";
      base03 = "6e6a86";
      base04 = "908caa";
      base05 = "e0def4";
      base06 = "e0def4";
      base07 = "56526e";
      base08 = "eb6f92";
      base09 = "f6c177";
      base0A = "ea9a97";
      base0B = "3e8fb0";
      base0C = "9ccfd8";
      base0D = "c4a7e7";
      base0E = "f6c177";
      base0F = "56526e";
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    enable = false;
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      };
      sansSerif = {
        name = "Montserrat";
        package = pkgs.montserrat;
      };
      serif = {
        name = "Montserrat";
        package = pkgs.montserrat;
      };
      sizes = {
        applications = 12;
        desktop = 11;
        popups = 12;
        terminal = 15;
      };
    };
    image = ../../config/wallpapers/wallpaper.jpg;
    opacity.terminal = 0.8;
    polarity = "dark";
  };

  system.stateVersion = "24.05";

  time.timeZone = "America/Vancouver";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
