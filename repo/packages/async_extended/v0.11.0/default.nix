world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      async = opamSelection.async;
      async_find = opamSelection.async_find;
      async_inotify = opamSelection.async_inotify;
      async_interactive = opamSelection.async_interactive;
      async_shell = opamSelection.async_shell;
      command_rpc = opamSelection.command_rpc;
      core = opamSelection.core;
      core_extended = opamSelection.core_extended;
      delimited_parsing = opamSelection.delimited_parsing;
      expect_test_helpers = opamSelection.expect_test_helpers;
      jbuilder = opamSelection.jbuilder;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_jane = opamSelection.ppx_jane;
      ppxlib = opamSelection.ppxlib;
      sequencer_table = opamSelection.sequencer_table;
      textutils = opamSelection.textutils;
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
  name = "async_extended-v0.11.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "async_extended";
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
    sha256 = "0780mmsmnd04mbfjrbb1fq0vc5hhybnqwdm5mizbpadagk56m96k";
    url = "https://ocaml.janestreet.com/ocaml-core/v0.11/files/async_extended-v0.11.0.tar.gz";
  };
}

