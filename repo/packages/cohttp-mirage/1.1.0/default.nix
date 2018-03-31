world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      astring = opamSelection.astring;
      cohttp = opamSelection.cohttp;
      cohttp-lwt = opamSelection.cohttp-lwt;
      conduit = opamSelection.conduit;
      jbuilder = opamSelection.jbuilder;
      lwt = opamSelection.lwt;
      magic-mime = opamSelection.magic-mime;
      mirage-channel-lwt = opamSelection.mirage-channel-lwt;
      mirage-conduit = opamSelection.mirage-conduit;
      mirage-flow-lwt = opamSelection.mirage-flow-lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      result = opamSelection.result;
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
  name = "cohttp-mirage-1.1.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "cohttp-mirage";
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
    sha256 = "1i1y90qn7nfkl44rx6mbns01bl63sc1iyrzaii0ffbii17x84m5j";
    url = "https://github.com/mirage/ocaml-cohttp/releases/download/v1.1.0/cohttp-1.1.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

