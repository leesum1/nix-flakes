{
  description = "Leesum personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # legacyPackages = import ./default.nix { inherit pkgs; };
      in {
        packages = nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v)
          (import ./default.nix { inherit pkgs; });
      });
}
