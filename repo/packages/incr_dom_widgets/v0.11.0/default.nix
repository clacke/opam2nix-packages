world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      async_js = opamSelection.async_js;
      async_kernel = opamSelection.async_kernel;
      incr_dom = opamSelection.incr_dom;
      incr_map = opamSelection.incr_map;
      incr_select = opamSelection.incr_select;
      incremental_kernel = opamSelection.incremental_kernel;
      jbuilder = opamSelection.jbuilder;
      js_of_ocaml = opamSelection.js_of_ocaml;
      js_of_ocaml-ppx = opamSelection.js_of_ocaml-ppx;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_jane = opamSelection.ppx_jane;
      ppxlib = opamSelection.ppxlib;
      record_builder = opamSelection.record_builder;
      splay_tree = opamSelection.splay_tree;
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
  name = "incr_dom_widgets-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "incr_dom_widgets";
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
    sha256 = "16gp8rjpivyrysx8s5ar3l4s3m5nypncyn4y119fxn3vkn5vp6j0";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/incr_dom_widgets-v0.11.0.tar.gz";
  };
}

