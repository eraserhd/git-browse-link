{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs { config = {}; };
  git-browse-link = pkgs.callPackage ./derivation.nix {};
in {
  test = pkgs.runCommandNoCC "git-browse-link-test" {} ''
    mkdir -p $out
    : ${git-browse-link}
  '';
}