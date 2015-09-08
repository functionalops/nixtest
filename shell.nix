{ pkgs ? import <nixpkgs> {}
, ... }:
let

  inherit (pkgs) stdenv nix nix-repl gitFull;

in stdenv.mkDerivation {
  name = "nixtest-shell";
  buildInputs = [ nix nix-repl gitFull ];
}
