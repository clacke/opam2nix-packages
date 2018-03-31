world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      angstrom = opamSelection.angstrom;
      async = opamSelection.async;
      core = opamSelection.core;
      core_extended = opamSelection.core_extended;
      core_kernel = opamSelection.core_kernel;
      cryptokit = opamSelection.cryptokit;
      jbuilder = opamSelection.jbuilder;
      magic-mime = opamSelection.magic-mime;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
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
  name = "email_message-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "email_message";
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
    sha256 = "01krrr17a2k19cgll1bq7g2vd723vmx603c96d7cxcp64304a6n5";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/email_message-v0.11.0.tar.gz";
  };
}

