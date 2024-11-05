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

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };
}

