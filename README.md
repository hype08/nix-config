# My NixOS config

If you want to follow along, clone this repository on an install of NixOS! Be warned, no promises of things working out of the box. 
Although, things _are_ quite rudimentary at the moment so it should be easy to follow.

## Requirements

- Must be installed and running on NixOS.

## Setup

I opted to put most of my NixOS configuration in userland.

- Isolation of the project from system files, 
- Easier backup
- Avoid having to sudo for most development tasks.
- I will be the sole user and am not entertaining multiple host & user configurations at the moment.

In `/etc/nixos/configuration.nix`, point to where you will be developing your NixOS project, like what I've done. This is my workaround for now.

```nix
{ config, pkgs, ... }:
{
  imports = [
    "/home/henry/Documents/nix-config/hosts/default/config.nix"
  ];
}
```

Next, edit your hardware in flake.nix. I am using a Thinkpad T480s, so you'll want to look for your machine here https://github.com/NixOS/nixos-hardware.

I'll strive to add more setup notes as things progress.
