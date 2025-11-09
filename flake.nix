{
  description = "k0s via Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        /*site = pkgs.stdenv.mkDerivation {
          name = "my-static-site";
          src = ./.;
          installPhase = ''
            mkdir -p $out
            cp -r * $out/
          '';
        }; */

        app-run = pkgs.writeShellScriptBin "my-command" ''
          ${pkgs.python3}/bin/python -m http.server 8000
        '';

      in
      {
        packages.default = app-run;

      }
    );
}
