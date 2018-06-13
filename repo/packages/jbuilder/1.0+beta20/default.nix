world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
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
  name = "jbuilder-1.0+beta20";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "jbuilder";
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
    sha256 = "07hl9as5llffgd6hbw41rs76i1ibgn3n9r0dba5h0mdlkapcwb10";
    url = "https://github.com/ocaml/dune/releases/download/1.0+beta20/jbuilder-1.0.beta20.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

