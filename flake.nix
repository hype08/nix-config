{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ghostty, ... }@inputs: 
    let
      host = "default";
      username = "henry";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
              inherit inputs;
              inherit host;
              inherit username;
          };
          modules = [
            {
              environment.systemPackages = [
                ghostty.packages.x86_64-linux.default
              ];
            }
            ./hosts/${host}/config.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs host username; };
                users.${username} = import ./hosts/${host}/home.nix;
              };
            }
            inputs.stylix.nixosModules.stylix
          ];
        };
      };
    };
}
