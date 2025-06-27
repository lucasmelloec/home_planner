{
  description = "A Nix-flake-based Gleam development environment";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            gleam
            beamMinimal28Packages.erlang
            beamMinimal28Packages.rebar3
            nodejs-slim_24
            inotify-tools
            (pkgs.buildFHSEnv {
              name = "gleam-run";
              pname = "dev";
              targetPkgs =
                pkgs: with pkgs; [
                  gleam
                ];
              runScript = "gleam run -m lustre/dev";
            })

          ];
        };
      }
    );
}
