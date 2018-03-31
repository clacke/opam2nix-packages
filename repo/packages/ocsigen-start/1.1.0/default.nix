world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.npm or null) (pkgs.postgresql or null)
        (pkgs.postgresql-common or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      eliom = opamSelection.eliom;
      js_of_ocaml-camlp4 = opamSelection.js_of_ocaml-camlp4;
      macaque = opamSelection.macaque;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ocsigen-i18n = opamSelection.ocsigen-i18n;
      ocsigen-toolkit = opamSelection.ocsigen-toolkit;
      pgocaml = opamSelection.pgocaml;
      safepass = opamSelection.safepass;
      yojson = opamSelection.yojson;
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
  name = "ocsigen-start-1.1.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ocsigen-start";
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
    sha256 = "09cw6qzcld0m1qm66mbjg9gw8l6dynpw3fzhm3kfx5ldh0afgvjq";
    url = "https://github.com/ocsigen/ocsigen-start/archive/1.1.0.tar.gz";
  };
}

