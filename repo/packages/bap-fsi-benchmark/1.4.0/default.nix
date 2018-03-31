world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bap-byteweight-frontend = opamSelection.bap-byteweight-frontend;
      bap-ida = opamSelection.bap-ida;
      bap-std = opamSelection.bap-std;
      cmdliner = opamSelection.cmdliner;
      fileutils = opamSelection.fileutils;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      re = opamSelection.re;
    };
    opamSelection = world.opamSelection;
    pkgs = world.pkgs;
in
pkgs.stdenv.mkDerivation 
{
  buildInputs = inputs;
  buildPhase = "${opam2nix}/bin/opam2nix invoke build";
  configurePhase = "true";
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "bap-fsi-benchmark-1.4.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bap-fsi-benchmark";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "076i13bfqsszwq2m0z6lag8jcsmlgybfic19gp8hxlmgza5m9xbw";
    url = "https://github.com/BinaryAnalysisPlatform/bap/archive/v1.4.0.tar.gz";
  };
}

