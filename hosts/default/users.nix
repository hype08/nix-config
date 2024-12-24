{
  pkgs,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users.users = {
    "henry" = {
      homeMode = "755";
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      initialPassword = "test";
      packages = with pkgs; [
      ];
    };
  };
}
