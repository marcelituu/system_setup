{
  description = "NixOS falke configuration";

  inputs = {
    #    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations = {
      marcel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad
        ];

      };
    };
  };
}
