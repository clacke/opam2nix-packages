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
  name = "jbuilder-1.0+beta19";
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
    sha256 = "160xv1x726s37a15lx0ddawpjgyl97zq2frpvrrwmx3aga5hbjqh";
    url = "https://github.com/ocaml/dune/releases/download/1.0+beta19/jbuilder-1.0.beta19.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

