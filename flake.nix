{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: 
  let
    host = "my-nixos";
    username = "henry";
  in
  {
    # Please replace my-nixos with your hostname
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./config.nix
	  nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          home-manager.nixosModules.home-manager
          {
	    home-manager.extraSpecialArgs = {
	      inherit username;
	      inherit inputs;
	      inherit host;
	    };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
          }
       ];
      };
    };
  };
}
