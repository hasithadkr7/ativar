{
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    flake-parts,
    systems,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {pkgs, ...}: let
        inherit (pkgs.beam) packagesWith;
        inherit (pkgs.beam.interpreters) erlangR26;
        erl = packagesWith erlangR26;
      in {
        devShells.default = with pkgs;
          mkShell {
            name = "ativar";
            shellHook = "mkdir -p .nix-mix";
            packages = with pkgs;
              [erl.elixir_1_16 nodejs_18 postgresql node2nix]
              ++ lib.optional stdenv.isLinux [inotify-tools]
              ++ lib.optional stdenv.isDarwin [
                darwin.apple_sdk.frameworks.CoreServices
                darwin.apple_sdk.frameworks.CoreFoundation
              ];
          };
      };
    };
}
