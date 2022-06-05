{
  description = "user-visible flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  inputs.lock.url = "git+file:./.?ref=lock";
  inputs.lock.inputs.lockless.follows = "/";

  outputs = {...}@_: let
    callSubflake = import ./call-flake.nix;
    me = callSubflake (builtins.readFile "${_.lock}/flake.lock") ./. "" "" "root" {} {};
    args = _ // _.lockless.inputs;
    c = f:
    builtins.trace
    (builtins.attrNames _)
    (if _?phase2 then f (builtins.removeAttrs args ["phase2"]) else me);
  in c ({nixpkgs,...}: {
    value = args.nixpkgs.legacyPackages.x86_64-linux.hello;
  });
}
