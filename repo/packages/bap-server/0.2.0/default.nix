world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      bap = opamSelection.bap;
      cohttp = opamSelection.cohttp;
      cohttp-lwt = opamSelection.cohttp-lwt;
      cohttp-lwt-unix = opamSelection.cohttp-lwt-unix;
      core-lwt = opamSelection.core-lwt;
      core_kernel = opamSelection.core_kernel;
      ezjsonm = opamSelection.ezjsonm;
      lwt = opamSelection.lwt;
      oasis = opamSelection.oasis;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      re = opamSelection.re;
      regular = opamSelection.regular;
      uri = opamSelection.uri;
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
  name = "bap-server-0.2.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bap-server";
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
    sha256 = "00wknbkvq9gylshn0lxhda7pj3jzm62z1zz8jkzalqpwym97c6q3";
    url = "https://github.com/BinaryAnalysisPlatform/bap-server/archive/v0.2.0.tar.gz";
  };
}

