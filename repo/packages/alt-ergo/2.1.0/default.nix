world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      camlzip = opamSelection.camlzip;
      conf-autoconf = opamSelection.conf-autoconf;
      conf-gtksourceview = opamSelection.conf-gtksourceview or null;
      lablgtk = opamSelection.lablgtk or null;
      menhir = opamSelection.menhir;
      num = opamSelection.num;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ocplib-simplex = opamSelection.ocplib-simplex;
      zarith = opamSelection.zarith;
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
  name = "alt-ergo-2.1.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "alt-ergo";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  prePatch = "cp -r ${./files}/* ./";
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "0dxy95yhzvb334zxgcx6apik7qn0gvwmmjx6n9a1m7yvyqnc6gik";
    url = "http://alt-ergo.ocamlpro.com/http/alt-ergo-2.1.0/alt-ergo-2.1.0.tar.gz";
  };
}

