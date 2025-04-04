{
  description = "NixOS falke configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
#    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    packages.x86_64-linux = 
    let 
      pkgs = import nixpkgs { system="x86_64-linux"; };
    in
     {
      windsurf = pkgs.callPackage ./packages/windsurf {inherit inputs;};
    };
    nixosConfigurations = {
      marcel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit self;
        };
        modules = [
          ./hosts/thinkpad
        ];

      };
    };
  };
}
