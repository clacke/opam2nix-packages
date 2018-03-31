world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.clang or null) (pkgs.gmp or null) (pkgs.libgmp-dev or null)
        (pkgs.libzip or null) (pkgs.libzip-dev or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bap-future = opamSelection.bap-future;
      base-unix = opamSelection.base-unix;
      bin_prot = opamSelection.bin_prot;
      camlzip = opamSelection.camlzip;
      cmdliner = opamSelection.cmdliner;
      core_kernel = opamSelection.core_kernel;
      fileutils = opamSelection.fileutils;
      graphlib = opamSelection.graphlib;
      monads = opamSelection.monads;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
      ogre = opamSelection.ogre;
      ppx_jane = opamSelection.ppx_jane;
      regular = opamSelection.regular;
      uri = opamSelection.uri;
      utop = opamSelection.utop;
      uuidm = opamSelection.uuidm;
      zarith = opamSelection.zarith;
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
  name = "bap-std-1.4.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bap-std";
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

