{ lib
, stdenv
, graalvm-legacy-packages
, javaVersion
, src
, version
}:

graalvm-legacy-packages.buildGraalvmProduct rec {
  inherit src javaVersion version;
  product = "llvm-installable-svm";

  # TODO: improve this test
  graalvmPhases.installCheckPhase = ''
    echo "Testing llvm"
    $out/bin/lli --help
  '';
}
