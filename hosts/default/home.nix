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
  ];

  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ".." = "cd ..";
        g = "lazygit";
        nc = "nvim $HOME/nix-config";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        rb = "sudo nixos-rebuild switch --flake $HOME/nix-config/#default --show-trace";
        sv = "sudo nvim";
        v = "nvim";
      };
    };
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
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
        disable_ligatures = "never";
      };
    };
    waybar = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}

