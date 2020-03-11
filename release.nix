{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs { config = {}; };
  git-browse-link = pkgs.callPackage ./derivation.nix {};
in {
  test = pkgs.stdenv.mkDerivation {
    name = "tests";
    src = ./.;
    buildInputs = [ pkgs.elvish ];

    buildPhase = ''
      ${pkgs.elvish}/bin/elvish run-tests.elv
    '';
    installPhase = ''
      touch $out
    '';
  };
}
