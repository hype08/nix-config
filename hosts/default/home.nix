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
}

