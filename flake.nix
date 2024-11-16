{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nixos-06cb-009a-fingerprint-sensor, ... }@inputs: 
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
              inherit nixos-06cb-009a-fingerprint-sensor;
          };
          modules = [
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
            # https://discourse.nixos.org/t/thinkpad-t480-fingerprint-reader-support/17448/8
            nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
            nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
          ];
        };
      };
    };
}
