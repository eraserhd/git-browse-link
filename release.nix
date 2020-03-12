{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs { config = {}; };
  git-browse-link = pkgs.callPackage ./derivation.nix {};
in {
  test = pkgs.stdenv.mkDerivation {
    name = "tests";
    src = ./tests;
    buildInputs = [ pkgs.git git-browse-link ];

    buildPhase = ''
      ./run-tests.sh
    '';
    installPhase = ''
      touch $out
    '';
  };
}
