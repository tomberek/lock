{
  description = "lock flake";

  inputs.lockless.url = "git+file:./.?ref=master";
  inputs.lockless.inputs.lock.follows = "/";

  outputs = {...}: {
    value = 1;
    # callSubflake = import ./call-flake.nix;
  };
}
