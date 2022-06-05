{
  description = "user-visible flake";

  inputs.lock.url = "git+file:./.?ref=lock";
  inputs.lock.inputs.lockless.follows = "/";

  outputs = {...}@_: let
    callSubflake = import ./call-flake.nix;
    me = callSubflake (builtins.readFile "${_.lock}/flake.lock") ./. "" "" "root" {phase2=true;} {};
    c = f: if _?phase2 then f _.lockless.inputs else me;
  in c ({nixpkgs,...}: {
    value = nixpkgs.legacyPackages.x86_64-linux.hello;
  });
}
