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
      jbuilder = opamSelection.jbuilder;
      mirage-xen-ocaml = opamSelection.mirage-xen-ocaml or null;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_compare = opamSelection.ppx_compare;
      ppx_custom_printf = opamSelection.ppx_custom_printf;
      ppx_fields_conv = opamSelection.ppx_fields_conv;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ppx_variants_conv = opamSelection.ppx_variants_conv;
      ppxlib = opamSelection.ppxlib;
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
  name = "bin_prot-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "bin_prot";
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
    sha256 = "1rsd91gx36prj4whi76nsiz1bzpgal9nzyw3pxdz1alv4ilk2il6";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/bin_prot-v0.11.0.tar.gz";
  };
}

