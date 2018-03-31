world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      ISO8601 = opamSelection.ISO8601;
      atdgen = opamSelection.atdgen;
      base-bytes = opamSelection.base-bytes;
      base-unix = opamSelection.base-unix;
      hex = opamSelection.hex;
      jbuilder = opamSelection.jbuilder;
      lwt = opamSelection.lwt;
      lwt-zmq = opamSelection.lwt-zmq;
      nocrypto = opamSelection.nocrypto;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      result = opamSelection.result;
      tyxml = opamSelection.tyxml or null;
      uuidm = opamSelection.uuidm;
      uutf = opamSelection.uutf;
      yojson = opamSelection.yojson;
      zmq = opamSelection.zmq;
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
  name = "jupyter-kernel-0.3";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "jupyter-kernel";
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
    sha256 = "0wbrjsvjj6qpvgc42y86j00wyh29rnpmv0gk2cn71pz6b7zfcvwi";
    url = "https://github.com/ocaml-jupyter/jupyter-kernel/archive/0.3.tar.gz";
  };
}

