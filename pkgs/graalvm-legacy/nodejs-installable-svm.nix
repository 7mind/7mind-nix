{ lib
, stdenv
, graalvm-legacy-packages
, graalvm-ce
, javaVersion
, src
, version
}:

graalvm-legacy-packages.buildGraalvmProduct rec {
  inherit src javaVersion version;
  product = "nodejs-installable-svm";

  extraNativeBuildInputs = [ graalvm-ce ];

  # TODO: improve test
  graalvmPhases.installCheckPhase = ''
    echo "Testing NodeJS"
    $out/bin/npx --help
  '';
}
