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
    ../../config/neovim.nix
  ];

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ".." = "cd ..";
        config = "nvim $HOME/nix-config";
        g = "lazygit";
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
    waybar = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}

