{
  description = "lock flake";

  inputs.lockless.url = "git+file:./.?ref=master&dir=inputs";

  outputs = {...}: {
    value = 1;
    # callSubflake = import ./call-flake.nix;
  };
}
