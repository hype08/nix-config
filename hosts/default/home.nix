{
  host,
  inputs,
  pkgs,
  username,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  home.username = "henry";
  home.homeDirectory = "/home/henry";
  home.stateVersion = "23.11";

  imports = [
    ../../config/neovim.nix
  ];

  programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        g = "lazygit";
        rebuild = "sudo nixos-rebuild switch --flake /home/henry/Documents/nix-config/#default --show-trace";
        ".." = "cd ..";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        sv = "sudo nvim";
        v = "nvim";
      };
    };

  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
          drag_lock = true;
          tap-to-click = true;
        };
        sensitivity = 0.0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_is_master = true;

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      # Basic keybinds
      bind = [
        "SUPER,Return,exec,kitty"
        "SUPER,Q,killactive,"
        "SUPER,M,exit,"
        "SUPER,E,exec,dolphin"
        "SUPER,V,togglefloating,"
        "SUPER,R,exec,wofi --show drun"
        "SUPER,P,pseudo,"
        "SUPER,F,fullscreen,"

        # Move focus
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"

        # Switch workspaces
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"

        # Move windows to workspaces
        "SUPER SHIFT,1,movetoworkspace,1"
        "SUPER SHIFT,2,movetoworkspace,2"
        "SUPER SHIFT,3,movetoworkspace,3"
        "SUPER SHIFT,4,movetoworkspace,4"
        "SUPER SHIFT,5,movetoworkspace,5"
        "SUPER SHIFT,6,movetoworkspace,6"
        "SUPER SHIFT,7,movetoworkspace,7"
        "SUPER SHIFT,8,movetoworkspace,8"
        "SUPER SHIFT,9,movetoworkspace,9"
        "SUPER SHIFT,0,movetoworkspace,10"
      ];

      # Mouse bindings
      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      # Window rules
      windowrule = [
        "float,^(pavucontrol)$"
        "float,^(nm-connection-editor)$"
        "float,^(blueman-manager)$"
      ];
    };
  };

  # Required packages for this setup
  home.packages = with pkgs; [
    kitty          # Terminal
    wofi           # Application launcher
    waybar         # Status bar
    dolphin        # File manager
    dunst          # Notification daemon
    libnotify      # Notification library
    wl-clipboard   # Clipboard manager
    networkmanagerapplet
    blueman        # Bluetooth
    pavucontrol    # Audio control

    # Screenshots/Recording
    grim
    slurp
    
    # System
    brightnessctl  # Brightness control
    pamixer        # Volume control
    swaybg         # Wallpaper
  ];
}

