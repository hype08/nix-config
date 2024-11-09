{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";    
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, hyprland, ... }@inputs: 
    let
      host = "default";
      username = "henry";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs host username;
        };
        modules = [
          ./hosts/${host}/config.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          hyprland.nixosModules.default
          home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs host username; };
              users.${username} = import ./hosts/${host}/home.nix;
            };
          }
        ];
      };
    };
}
