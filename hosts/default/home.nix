{
  pkgs,
  host,
  username,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  imports = [
    ../../config/fastfetch
    ../../config/firefox.nix
    ../../config/hyprland.nix
    ../../config/neovim.nix
    ../../config/waybar.nix
    ../../config/wlogout.nix
  ];

  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };


  home.packages = [
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })

    pkgs.go
    pkgs.go-tools
    pkgs.gopls
    pkgs.golangci-lint
    
    pkgs.go_1_23
    
    pkgs.pipenv
    pkgs.python313
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;  # If using zsh
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--inline-info"
        "--color=dark"
        "--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f"
        "--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
      ];
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [
        "--preview 'bat --color=always --style=numbers --line-range=:500 {} || kitty +kitten icat --silent {}'"
      ];
      changeDirWidgetCommand = "fd --type d";
      changeDirWidgetOptions = [
        "--preview 'exa --tree --level=2 --color=always {} || tree -C {} | head -200'"
      ];
    };
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
    };
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 10;
          hide_cursor = true;
          no_fade_in = false;
        };
        background = [
          {
            path = "/home/${username}/Pictures/Wallpapers/wallpaper.jpg";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(CFE6F4)";
            inner_color = "rgb(657DC2)";
            outer_color = "rgb(0D0E15)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
          }
        ];
      };
    };
    kitty = {
      enable = true;
      font = {
        name = "0xproto";
        size = 15;
      };
      settings = {
        bold_font = "0xproto Bold";
        italic_font = "0xproto Italic";
        bold_italic_font = "Oxproto Bold Italic";
        adjust_line_height = "110%";
        term = "xterm-256color";
      };
    };
    waybar = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        eval "$(zoxide init zsh)"
      '';
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
        
        ".." = "cd ..";
        "..." = "cd ../..";
        g = "lazygit";
        nc = "nvim $HOME/nix-config";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        rb = "sudo nixos-rebuild switch --flake $HOME/nix-config/#default --show-trace";
        sv = "sudo nvim";
        v = "nvim";
      };
    };
  };
}

