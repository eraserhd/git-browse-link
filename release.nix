{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs { config = {}; };
  git-browse-link = pkgs.callPackage ./derivation.nix {};
in {
  test = pkgs.stdenv.mkDerivation {
    name = "tests";
    src = ./tests;
    buildInputs = [ pkgs.git git-browse-link pkgs.shellcheck pkgs.gerbil ];
    buildPhase = ''
      shellcheck -s sh -i SC2039 $(command -v git-browse-link)
      gxi run-tests.ss
    '';
    installPhase = "touch $out";
  };
}
