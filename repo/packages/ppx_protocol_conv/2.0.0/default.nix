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
      msgpck = opamSelection.msgpck or null;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_core = opamSelection.ppx_core;
      ppx_driver = opamSelection.ppx_driver;
      ppx_metaquot = opamSelection.ppx_metaquot;
      ppx_type_conv = opamSelection.ppx_type_conv;
      xml-light = opamSelection.xml-light or null;
      yaml = opamSelection.yaml or null;
      yojson = opamSelection.yojson or null;
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
  name = "ppx_protocol_conv-2.0.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ppx_protocol_conv";
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
    sha256 = "0phbxvxy8bkjyk4vnlsmaiwm69a5lblkw5y160acvdxcbf04x77f";
    url = "https://github.com/andersfugmann/ppx_protocol_conv/archive/2.0.0.tar.gz";
  };
}

