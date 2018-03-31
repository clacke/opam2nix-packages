world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      core = opamSelection.core;
      core_extended = opamSelection.core_extended;
      jbuilder = opamSelection.jbuilder;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
      patience_diff = opamSelection.patience_diff;
      pcre = opamSelection.pcre;
      ppx_jane = opamSelection.ppx_jane;
      ppxlib = opamSelection.ppxlib;
      re2 = opamSelection.re2;
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
  name = "line-up-words-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "line-up-words";
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
    sha256 = "0xzfla566vcpgr4ib83j4nc2knrb4s7xp6pr2fi14hvdiyxkfd31";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/line-up-words-v0.11.0.tar.gz";
  };
}

