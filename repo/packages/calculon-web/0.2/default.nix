world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      atdgen = opamSelection.atdgen;
      calculon = opamSelection.calculon;
      cohttp = opamSelection.cohttp;
      cohttp-lwt = opamSelection.cohttp-lwt;
      cohttp-lwt-unix = opamSelection.cohttp-lwt-unix;
      jbuilder = opamSelection.jbuilder;
      lambdasoup = opamSelection.lambdasoup;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      re = opamSelection.re;
      sequence = opamSelection.sequence;
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
  name = "calculon-web-0.2";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "calculon-web";
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
    sha256 = "1f066kl46s096kg2adxd7zj1rhbgjxlb475wq4khc50ax73iy7y4";
    url = "https://github.com/c-cube/calculon/archive/0.2.tar.gz";
  };
}

