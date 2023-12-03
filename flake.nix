{
  inputs = {
    nixpkgs.url = "flake:nixpkgs";
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
        inherit (pkgs) callPackage;
        inherit (pkgs.beam) packagesWith;
        inherit (pkgs.beam.packages) erlangR25;
        erl = packagesWith erlangR25;
      in {
        packages.default = let
          node = callPackage ./assets/default.nix {};
          inherit (node.shell) nodeDependencies;
        in
          erl.callPackage ./nix/ativar.nix {
            inherit nodeDependencies;
            inherit (pkgs) nix-gitignore;
          };
        devShells.default = with pkgs;
          mkShell {
            name = "ativar";
            shellHook = "mkdir -p .nix-mix";
            packages = with pkgs;
              [erlangR25.elixir_1_15 nodejs_18 postgresql node2nix]
              ++ lib.optional stdenv.isDarwin [
                darwin.apple_sdk.frameworks.CoreServices
                darwin.apple_sdk.frameworks.CoreFoundation
              ];
          };
      };
    };
}
