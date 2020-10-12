let

nixpkgsRev = "bc260badaebf67442befe20fb443034d3a91f2b3"; # 20.09-beta
nixpkgsSha256 = "1iysc4xyk88ngkfb403xfq5bs3zy29zfs83pn99kchxd45nbpb5q";

mixpkgs = fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/${nixpkgsRev}.tar.gz";
  sha256 = nixpkgsSha256;
};

in

{ nixpkgs ? import mixpkgs { overlays = [ ]; } }:

let

inherit (nixpkgs) pkgs;
inherit (pkgs) haskellPackages;

my-python-packages = python-packages: with python-packages; [
  numpy
  ];

# python-with-my-packages = pkgs.python2.withPackages my-python-packages;
python3-with-my-packages = pkgs.python3.withPackages my-python-packages;

# cmaes = haskellPackages.callPackage ./default.nix { python = python-with-my-packages; };
cmaes = haskellPackages.callPackage ./default.nix { python = python3-with-my-packages; };

haskellDeps = ps: with ps; [
  base
  mtl process safe strict syb
  doctest QuickCheck random vector
];

ghc = haskellPackages.ghcWithPackages haskellDeps;

in

pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = [
    haskellPackages.cabal-install
    # cmaes
    ghc
    # python-with-my-packages
    python3-with-my-packages
  ];
}
