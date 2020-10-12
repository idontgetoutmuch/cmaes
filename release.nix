let

nixpkgsRev = "bc260badaebf67442befe20fb443034d3a91f2b3"; # 20.09-beta
nixpkgsSha256 = "1iysc4xyk88ngkfb403xfq5bs3zy29zfs83pn99kchxd45nbpb5q";

nixpkgs = fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/${nixpkgsRev}.tar.gz";
  sha256 = nixpkgsSha256;
};

in

{ pkgs ? import nixpkgs { overlays = [ ]; } }:

let

my-python-packages = python-packages: with python-packages; [
  numpy
  ];

python-with-my-packages = pkgs.python3.withPackages my-python-packages;

in

pkgs.haskellPackages.callPackage ./default.nix { python = python-with-my-packages; }
