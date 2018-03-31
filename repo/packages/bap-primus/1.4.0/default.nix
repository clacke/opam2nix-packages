world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bap-abi = opamSelection.bap-abi;
      bap-c = opamSelection.bap-c;
      bap-future = opamSelection.bap-future;
      bap-std = opamSelection.bap-std;
      bap-strings = opamSelection.bap-strings;
      graphlib = opamSelection.graphlib;
      monads = opamSelection.monads;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      parsexp = opamSelection.parsexp;
      uuidm = opamSelection.uuidm;
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
  name = "bap-primus-1.4.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bap-primus";
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

