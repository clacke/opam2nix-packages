world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      base = opamSelection.base;
      base-native-int63 = opamSelection.base-native-int63 or null;
      bin_prot = opamSelection.bin_prot;
      configurator = opamSelection.configurator;
      fieldslib = opamSelection.fieldslib;
      jane-street-headers = opamSelection.jane-street-headers;
      jbuilder = opamSelection.jbuilder;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_assert = opamSelection.ppx_assert;
      ppx_base = opamSelection.ppx_base;
      ppx_hash = opamSelection.ppx_hash;
      ppx_inline_test = opamSelection.ppx_inline_test;
      ppx_jane = opamSelection.ppx_jane;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ppx_sexp_message = opamSelection.ppx_sexp_message;
      ppxlib = opamSelection.ppxlib;
      sexplib = opamSelection.sexplib;
      splittable_random = opamSelection.splittable_random;
      stdio = opamSelection.stdio;
      typerep = opamSelection.typerep;
      variantslib = opamSelection.variantslib;
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
  name = "core_kernel-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "core_kernel";
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
    sha256 = "1hfj4f444n4kibllk0imfjs9kk7rvxayprazjgrzch9ff7af5xvq";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/core_kernel-v0.11.0.tar.gz";
  };
}

