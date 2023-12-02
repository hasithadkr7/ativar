{
  outputs = {nixpkgs, ...}: let
    system = "aarch64-darwin";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    inherit (pkgs.beam.packages) erlangR25;
  in {
    devShells = {
      "${system}".default = pkgs.mkShell {
        name = "ativar";
        shellHook = "mkdir -p .nix-mix";
        packages = with pkgs;
          [erlangR25.elixir_1_15 nodejs_18]
          ++ lib.optional stdenv.isDarwin [
            darwin.apple_sdk.frameworks.CoreServices
            darwin.apple_sdk.frameworks.CoreFoundation
          ];
      };
    };
  };
}
