world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      core_kernel = opamSelection.core_kernel;
      jbuilder = opamSelection.jbuilder;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_jane = opamSelection.ppx_jane;
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
  name = "patience_diff-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "patience_diff";
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
    sha256 = "0hs4vyj5f8sr9bkfqqq8lv7w0zcz9xwrc842r9wxzkdmivm9wln6";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/patience_diff-v0.11.0.tar.gz";
  };
}
