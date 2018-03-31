world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      base-threads = opamSelection.base-threads or null;
      base-unix = opamSelection.base-unix or null;
      gen = opamSelection.gen or null;
      jbuilder = opamSelection.jbuilder;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      odoc = opamSelection.odoc or null;
      ounit = opamSelection.ounit or null;
      qcheck = opamSelection.qcheck or null;
      qtest = opamSelection.qtest or null;
      result = opamSelection.result;
      sequence = opamSelection.sequence or null;
      uchar = opamSelection.uchar;
      uutf = opamSelection.uutf or null;
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
  name = "containers-2.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "containers";
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
    sha256 = "0rw724wlayfs8j90cqgchhn1nxxxnssjdxgnkfwghjg5mdshyln1";
    url = "https://github.com/c-cube/ocaml-containers/archive/2.1.tar.gz";
  };
}

