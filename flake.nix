{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: 
  let
    host = "default";
    username = "henry";
  in
  {
    # Please replace my-nixos with your hostname
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./hosts/${host}/config.nix
	  nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          inputs.home-manager.nixosModules.default
	  {
	    home-manager.users.${username} = import ./hosts/${host}/home.nix;
	  }
       ];
    };
  };
}
