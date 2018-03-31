world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.linux-headers or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      cstruct = opamSelection.cstruct;
      io-page-unix = opamSelection.io-page-unix or null;
      jbuilder = opamSelection.jbuilder;
      lwt = opamSelection.lwt;
      mirage-block = opamSelection.mirage-block;
      mirage-types-lwt = opamSelection.mirage-types-lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ounit = opamSelection.ounit;
      vhd-format = opamSelection.vhd-format;
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
  name = "vhd-format-lwt-0.9.2";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "vhd-format-lwt";
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
    sha256 = "0b730n52zg8gwjciihlynv9mjm87w0yjlncmqx23xwkq8fmq51kk";
    url = "https://github.com/mirage/ocaml-vhd/archive/v0.9.2.tar.gz";
  };
}

