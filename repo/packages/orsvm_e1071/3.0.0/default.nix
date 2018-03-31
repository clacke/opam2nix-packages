world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      batteries = opamSelection.batteries or null;
      conf-r = opamSelection.conf-r;
      cpm = opamSelection.cpm or null;
      dolog = opamSelection.dolog or null;
      jbuilder = opamSelection.jbuilder;
      minicli = opamSelection.minicli or null;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      parmap = opamSelection.parmap or null;
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
  name = "orsvm_e1071-3.0.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "orsvm_e1071";
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
    sha256 = "1xhsgs0nnyw8l0aflhzjqgykq49x6334h6miznsaykd35l2i8dfj";
    url = "https://github.com/UnixJunkie/orsvm-e1071/archive/v3.0.0.tar.gz";
  };
}

