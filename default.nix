# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  graalvmCEPackages =
    pkgs.lib.recurseIntoAttrs (pkgs.callPackage ./pkgs/graalvm-legacy { });
  graalvm-ce = graalvm11-ce;
  graalvm11-ce = graalvmCEPackages.graalvm11-ce;
  graalvm17-ce = graalvmCEPackages.graalvm17-ce;
  graalvm19-ce = graalvmCEPackages.graalvm19-ce;
  buildGraalvmNativeImage = (pkgs.callPackage ./pkgs/graalvm-legacy/build-graalvm-native-image {
    graalvmDrv = graalvm-ce;
  }).override;

  # example-package = pkgs.callPackage ./pkgs/example-package { };
  # # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # # ...
}
