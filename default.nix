{ mkDerivation, base, doctest, doctest-prop, mtl, process, QuickCheck, python, random
, safe, stdenv, strict, syb, vector
}:
mkDerivation {
  pname = "cmaes";
  version = "0.2.2";
  src = ./.;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [ base mtl process safe strict syb ];
  testHaskellDepends = [
    base doctest mtl process QuickCheck random syb vector
  ];
  executableHaskellDepends = [ python ];
  description = "CMA-ES wrapper in Haskell";
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
