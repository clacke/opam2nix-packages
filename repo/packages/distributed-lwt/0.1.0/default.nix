world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      distributed = opamSelection.distributed;
      jbuilder = opamSelection.jbuilder;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
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
  name = "distributed-lwt-0.1.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "distributed-lwt";
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
    sha256 = "099ng7rjaya12w3bcan14a9d7mkndpsl5bq5c2ncdzf831g2f2p6";
    url = "https://github.com/essdotteedot/distributed/archive/v0.5.0.tar.gz";
  };
}

