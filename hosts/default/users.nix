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
