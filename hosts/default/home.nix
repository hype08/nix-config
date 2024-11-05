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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-fzf-native-nvim
    ];
  };
}

